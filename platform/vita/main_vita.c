/*
 * main_vita.c - PS Vita front-end of Pinball NS (Pokemon Pinball, the whole table on one screen).
 *
 * What the desktop versions share (the game, its saves, the settings, the pictures, the handheld mode
 * of the phones) is platform/desktop/desk.c; this file is the screen (vita2d), the sound (a thread on
 * sceAudioOut), the buttons, the touch panels and the folder of the game.
 *
 * Two ways to hold it, asked at each start; SELECT + L + R switches (there and while playing), and
 * ORIENTATION in the menu (SELECT):
 *   - landscape, held normally: the table alone, played with the buttons (L / R the flippers, CROSS
 *     launches and confirms, the d-pad and START for the menus of the game) or the touch screen's
 *     halves (the flippers);
 *   - portrait, the d-pad down: the screen of the phones (the table at the top, its touch keys below,
 *     the menu), played on the touch screen; the buttons work too.
 *   - shaking the Vita up and down tilts the table up, a tap on its left or right side tilts it
 *     that way (platform/mobile/motion.h, as the phones; MOTION TILT in the menu);
 *   - the rear touch pad is not used (the hands holding the Vita rest on it).
 *
 * Files: ux0:data/PinballNS/ - the ROM (any .gbc file: Pokemon Pinball US, or Generations 1.6), its
 * cartridge save (.sav) and saved state (.state) next to it, the settings (pinball_ns.cfg, vita.cfg).
 */
#include <psp2/kernel/processmgr.h>
#include <psp2/kernel/threadmgr.h>
#include <psp2/ctrl.h>
#include <psp2/touch.h>
#include <psp2/audioout.h>
#include <psp2/power.h>
#include <psp2/motion.h>
#include <psp2/io/stat.h>
#include <psp2/io/dirent.h>
#include <vita2d.h>
#include <math.h>
#include <stdatomic.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include "../desktop/desk.h"
#include "../../src/front/pacing.h"
#include "../mobile/motion.h"
#include "chooser.h"

#ifndef M_PI_2
#define M_PI_2 1.57079632679489661923
#endif

#define DATA_DIR     "ux0:data/PinballNS"
#define SCR_W        960
#define SCR_H        544
#define AUDIO_RATE   DESK_RATE
#define AUDIO_GRAIN  512                  /* frames per sceAudioOutOutput (~10.7 ms) */
#define AUDIO_TARGET 2048                 /* frames kept waiting for the card (~43 ms) */
#define RING         16384                /* the ring between the game and the card (frames, power of two) */

int _newlib_heap_size_user = 160 * 1024 * 1024;

static Desk D;

static double now_s(void) { return sceKernelGetProcessTimeWide() * 1e-6; }

/* ------------------------------------------------------------------ how it is held */

enum { HOLD_LANDSCAPE, HOLD_DPAD_DOWN, HOLD_DPAD_UP, HOLDS };
static int hold;                         /* HOLD_LANDSCAPE or HOLD_DPAD_DOWN (the d-pad up: kept, unused) */
static bool perf_on;                     /* the speed readout shown */
static char perf_text[96];
static bool shake = true;                /* tilts by moving the Vita */
static bool ask_start = true;            /* the screens at the start shown (ASK AT START) */
static char vita_cfg[256];
static bool lmenu_open;                  /* the menu of the landscape way shown (the phones' in portrait) */

static void hold_save(void)
{
    FILE *f = fopen(vita_cfg, "wb");
    if (!f) return;
    fprintf(f, "hold=%d\nshake=%d\nask=%d\n", hold, shake ? 1 : 0, ask_start ? 1 : 0);
    fclose(f);
}

static void hold_load(void)
{
    FILE *f = fopen(vita_cfg, "rb");
    if (!f) return;
    int h = 0, s = 1;
    if (fscanf(f, "hold=%d", &h) == 1 && h >= 0 && h < HOLDS) hold = h;
    if (fscanf(f, " shake=%d", &s) == 1) shake = s != 0;
    int a = 1;
    if (fscanf(f, " ask=%d", &a) == 1) ask_start = a != 0;
    fclose(f);
}

/* the size of the picture as held (the window of the desktop versions) */
static int win_w(void) { return hold == HOLD_LANDSCAPE ? SCR_W : SCR_H; }
static int win_h(void) { return hold == HOLD_LANDSCAPE ? SCR_H : SCR_W; }

/* a point of the screen (0..960 x 0..544, as the Vita is held normally) in the picture as held. The
 * d-pad down: the Vita turned a quarter left, the picture drawn a quarter right (its top on the right
 * of the screen); the d-pad up: the other way. */
static void screen_to_win(float sx, float sy, float *wx, float *wy)
{
    switch (hold) {
    case HOLD_DPAD_DOWN: *wx = sy; *wy = SCR_W - sx; break;
    case HOLD_DPAD_UP:   *wx = SCR_H - sy; *wy = sx; break;
    default:             *wx = sx; *wy = sy; break;
    }
}

static void win_to_screen(float wx, float wy, float *sx, float *sy)
{
    switch (hold) {
    case HOLD_DPAD_DOWN: *sx = SCR_W - wy; *sy = wx; break;
    case HOLD_DPAD_UP:   *sx = wy; *sy = SCR_H - wx; break;
    default:             *sx = wx; *sy = wy; break;
    }
}

static void set_hold(int h, bool tell)
{
    hold = h;
    D.handheld = hold != HOLD_LANDSCAPE;
    D.ui.hold_portrait = D.handheld;
    lmenu_open = false;
    if (D.pb) pb_set_narrow(D.pb, D.narrow || D.handheld);
    D.osd[0] = 0;
    ui_open_menu(&D.ui, false);
    desk_keys_released(&D);
    desk_cfg_save(&D);
    hold_save();
    (void)tell;                                  /* (no note: the turn says it, and notes cost frames) */
}

/* ------------------------------------------------------------------ sound */

/* The game thread writes the ring (ring_w), the sound thread reads it (ring_r) and asks for nothing
 * else; a drop of what waits is asked of the sound thread (ring_drop, ring_flush). */
static int16_t ring[RING * 2];
static atomic_uint ring_w, ring_r, ring_drop, played;
static atomic_bool ring_flush, audio_run;
static int audio_port = -1;
static SceUID audio_thid = -1;
static SoundPacer snd;
static Pacer pacer;
static double played_total;
static unsigned played_last;

static int audio_main(SceSize args, void *argp)
{
    (void)args;
    (void)argp;
    static int16_t buf[AUDIO_GRAIN * 2];
    while (atomic_load(&audio_run)) {
        unsigned r = atomic_load(&ring_r), w = atomic_load(&ring_w);
        if (atomic_exchange(&ring_flush, false)) r = w;
        unsigned drop = atomic_exchange(&ring_drop, 0);
        if (drop) r += drop < w - r ? drop : w - r;
        unsigned n = w - r < AUDIO_GRAIN ? w - r : AUDIO_GRAIN;
        for (unsigned i = 0; i < n; i++) {
            unsigned k = ((r + i) & (RING - 1)) * 2;
            buf[i * 2] = ring[k];
            buf[i * 2 + 1] = ring[k + 1];
        }
        if (n < AUDIO_GRAIN) memset(buf + n * 2, 0, (AUDIO_GRAIN - n) * 4);
        atomic_store(&ring_r, r + n);
        atomic_fetch_add(&played, n);
        sceAudioOutOutput(audio_port, buf);            /* (waits for the card) */
    }
    return sceKernelExitDeleteThread(0);
}

static void audio_open(void)
{
    audio_port = sceAudioOutOpenPort(SCE_AUDIO_OUT_PORT_TYPE_BGM, AUDIO_GRAIN, AUDIO_RATE, SCE_AUDIO_OUT_MODE_STEREO);
    if (audio_port < 0) return;
    atomic_store(&audio_run, true);
    audio_thid = sceKernelCreateThread("pinball_audio", audio_main, 0x10000100, 0x10000, 0, 0, NULL);
    if (audio_thid < 0) { sceAudioOutReleasePort(audio_port); audio_port = -1; return; }
    sceKernelStartThread(audio_thid, 0, NULL);
    sound_reset(&snd, AUDIO_RATE, AUDIO_TARGET);
    snd.limit = RING;
    sound_restart(&snd, now_s());
}

static unsigned ring_level(void) { return atomic_load(&ring_w) - atomic_load(&ring_r); }

static void ring_put(const int16_t *s, unsigned n)
{
    unsigned w = atomic_load(&ring_w);
    unsigned room = RING - 1 - ring_level();
    if (n > room) n = room;                          /* far ahead of the card: the newest are lost */
    for (unsigned i = 0; i < n; i++) {
        unsigned k = ((w + i) & (RING - 1)) * 2;
        ring[k] = s ? s[i * 2] : 0;
        ring[k + 1] = s ? s[i * 2 + 1] : 0;
    }
    atomic_store(&ring_w, w + n);
}

static void audio_pump(void)
{
    int16_t tmp[4096];
    int n;
    while ((n = pb_audio(D.pb, tmp, 2048)) > 0) {
        if (audio_port < 0) continue;
        ring_put(D.sound ? tmp : NULL, (unsigned)n);
    }
}

static int audio_pace(double t, int frames_left)
{
    if (audio_port < 0) return SOUND_KEEP;
    unsigned p = atomic_load(&played);
    played_total += (double)(unsigned)(p - played_last);
    played_last = p;
    double waiting = ring_level(), rate, pad;
    int act = sound_pace(&snd, &pacer, t, played_total, waiting, frames_left, &rate, &pad);
    if (act == SOUND_PAD) {
        if (pad > 0) ring_put(NULL, (unsigned)pad);
    } else if (act == SOUND_FLUSH) {
        atomic_store(&ring_flush, true);
    } else if (act == SOUND_TRIM) {
        if (pad > 0) atomic_fetch_add(&ring_drop, (unsigned)pad);
    }
    pb_set_audio_rate(D.pb, rate);
    return act;
}

/* ------------------------------------------------------------------ buttons and touch */

static SceTouchPanelInfo panel[2];
struct finger { int id; float x, y; };
static struct finger front_prev[8];
static int front_prev_n;
static uint32_t select_combo;            /* buttons pressed with SELECT held (then not given to the game) */
static bool select_used;
static uint32_t buttons_prev;
static double finger_down_t;             /* a finger last came down on the screen (not a tilt, then) */

/* a report of a panel as a point of the screen (0..960 x 0..544) */
static void panel_point(int port, const SceTouchReport *r, float *sx, float *sy)
{
    const SceTouchPanelInfo *p = &panel[port];
    float w = (float)(p->maxAaX - p->minAaX), h = (float)(p->maxAaY - p->minAaY);
    *sx = w > 0 ? (r->x - p->minAaX) * SCR_W / w : r->x / 2.0f;
    *sy = h > 0 ? (r->y - p->minAaY) * SCR_H / h : r->y / 2.0f;
}

/* the front panel: sideways, the fingers to the handheld mode (as the phones: down, moves, up);
 * landscape, its left and right halves are the flippers */
static long touch_front(void)
{
    SceTouchData t;
    memset(&t, 0, sizeof t);
    if (sceTouchPeek(SCE_TOUCH_PORT_FRONT, &t, 1) < 0) return 0;
    if (hold == HOLD_LANDSCAPE) {
        long in = 0;
        for (int i = 0; i < (int)t.reportNum; i++) {
            float sx, sy;
            panel_point(SCE_TOUCH_PORT_FRONT, &t.report[i], &sx, &sy);
            in |= 1L << (sx < SCR_W / 2 ? PAD_LB : PAD_RB);
        }
        front_prev_n = 0;
        return in;
    }
    struct finger now[8];
    int n = 0;
    for (int i = 0; i < (int)t.reportNum && n < 8; i++) {
        float sx, sy;
        panel_point(SCE_TOUCH_PORT_FRONT, &t.report[i], &sx, &sy);
        now[n].id = t.report[i].id;
        screen_to_win(sx, sy, &now[n].x, &now[n].y);
        n++;
    }
    for (int i = 0; i < n; i++) {
        bool was = false;
        for (int j = 0; j < front_prev_n; j++) was |= front_prev[j].id == now[i].id;
        if (!was) finger_down_t = now_s();
        desk_pointer(&D, was ? UI_MOVE : UI_DOWN, now[i].id, now[i].x, now[i].y);
    }
    for (int j = 0; j < front_prev_n; j++) {
        bool still = false;
        for (int i = 0; i < n; i++) still |= front_prev[j].id == now[i].id;
        if (!still) desk_pointer(&D, UI_UP, front_prev[j].id, front_prev[j].x, front_prev[j].y);
    }
    memcpy(front_prev, now, sizeof now);
    front_prev_n = n;
    return 0;
}

/* The accelerometer (g, the Vita held normally: x to its right, y up it, z out of the screen), its
 * samples turned to the way it is held (the axes of motion.h: those of the screen as seen), the tilt it
 * makes pressed as the gamepad's (left: d-pad down, right: B, up: Y, the game's SELECT) for
 * MOTION_HOLD seconds, as on the phones. */
static Motion motion;
static unsigned motion_counter;
static bool motion_counter_ok;
static long tilt_in;
static double tilt_until;

static long motion_tilt(void)
{
    double t = now_s();
    if (tilt_in && t >= tilt_until) tilt_in = 0;
    bool on = shake && D.pb && pb_in_game(D.pb) && !D.paused && !lmenu_open && !(D.handheld && D.ui.menu_open);
    if (!on) { motion_counter_ok = false; motion_reset(&motion); return tilt_in = 0; }
    SceMotionSensorState st[64];
    if (sceMotionGetSensorState(st, 64) < 0) return tilt_in;
    /* the samples not seen yet, oldest first (by their counter) */
    for (;;) {
        int best = -1;
        for (int i = 0; i < 64; i++) {
            if (motion_counter_ok && (int)(st[i].counter - motion_counter) <= 0) continue;
            if (best < 0 || (int)(st[i].counter - st[best].counter) < 0) best = i;
        }
        if (best < 0) break;
        if (!motion_counter_ok) {                     /* the first time: from the newest one only */
            for (int i = 0; i < 64; i++) if ((int)(st[i].counter - st[best].counter) > 0) best = i;
            motion_counter_ok = true;
        }
        motion_counter = st[best].counter;
        const float G = 9.80665f;
        float dx = st[best].accelerometer.x * G, dy = st[best].accelerometer.y * G, dz = st[best].accelerometer.z * G;
        float ax = dx, ay = dy;
        if (hold == HOLD_DPAD_DOWN) { ax = -dy; ay = dx; }
        else if (hold == HOLD_DPAD_UP) { ax = dy; ay = -dx; }
        double ts = st[best].hostTimestamp * 1e-6;
        int tilt = motion_sample(&motion, ts, ax, ay, dz, false);
        if (tilt && t - finger_down_t > 0.15) {
            tilt_in = 1L << (tilt == MOTION_LEFT ? PAD_DDOWN : tilt == MOTION_RIGHT ? PAD_B : PAD_Y);
            tilt_until = t + MOTION_HOLD;
        }
    }
    return tilt_in;
}

/* SELECT + a button: the functions of the desktop versions' function keys */
/* ------------------------------------------------------------------ the menu, landscape */

/* The entries of the phones' menu (platform/mobile/ui.c: the same labels, the same actions, done by
 * desk_tick), in the box of the screen at the start (chooser.h), over the table; but those of the touch
 * keys of the portrait way and ABOUT. The d-pad chooses, CROSS or START does, CIRCLE or SELECT goes
 * back to the game; or a tap on one (beside the box: back to the game). */
#define LM_MAX   UI_MENU_ITEMS
#define LM_SCALE 3
#define LM_TEX   256                      /* its texture, LM_TEX x LM_TEX (the box fits) */
static int lmenu_sel, lmenu_n, lmenu_act[LM_MAX], lmenu_w, lmenu_h;
static const char *lmenu_label[LM_MAX];
static bool lmenu_touched;

static void lmenu_build(void)
{
    const char *label[LM_MAX];
    int act[LM_MAX], n = ui_menu_list(&D.ui, label, act, LM_MAX);
    lmenu_n = 0;
    for (int i = 0; i < n; i++) {
        if (act[i] == UI_ACT_NEXT_TOUCH || act[i] == UI_ACT_TOGGLE_CONTROLS || act[i] == UI_ACT_ABOUT) continue;
        lmenu_label[lmenu_n] = label[i];
        lmenu_act[lmenu_n++] = act[i];
    }
    if (lmenu_sel >= lmenu_n) lmenu_sel = lmenu_n - 1;
    if (lmenu_sel < 0) lmenu_sel = 0;
    lmenu_w = mbox_w("PINBALL NS", lmenu_label, lmenu_n, 150);
    lmenu_h = mbox_h(lmenu_n, 0);
    if (lmenu_w > LM_TEX) lmenu_w = LM_TEX;
    if (lmenu_h > LM_TEX) lmenu_h = LM_TEX;
}

static void lmenu_show(bool open)
{
    lmenu_open = open && D.pb && !D.ui.no_rom;
    lmenu_sel = 0;
    lmenu_touched = true;                     /* (a finger already down: not a tap) */
    if (lmenu_open) lmenu_build();
}

static void lmenu_choose(int i)
{
    if (i < 0 || i >= lmenu_n) return;
    int a = lmenu_act[i];
    D.ui.pending_action = a;                  /* (desk_tick does it, as with the phones' menu) */
    if (a == UI_ACT_RESUME || a == UI_ACT_QUICKSAVE || a == UI_ACT_QUICKLOAD || a == UI_ACT_NEXT_GAME ||
        a == UI_ACT_RESET || a == UI_ACT_QUIT || a == UI_ACT_NEXT_HOLD) lmenu_open = false;
}

/* the box's place on the screen */
static float lmenu_x(void) { return (SCR_W - lmenu_w * LM_SCALE) / 2.0f; }
static float lmenu_y(void) { return (SCR_H - lmenu_h * LM_SCALE) / 2.0f; }

static void lmenu_input(uint32_t pressed)
{
    if (pressed & SCE_CTRL_UP) lmenu_sel = lmenu_sel <= 0 ? lmenu_n - 1 : lmenu_sel - 1;
    if (pressed & SCE_CTRL_DOWN) lmenu_sel = lmenu_sel >= lmenu_n - 1 ? 0 : lmenu_sel + 1;
    if (pressed & (SCE_CTRL_CROSS | SCE_CTRL_START)) lmenu_choose(lmenu_sel);
    else if (pressed & SCE_CTRL_CIRCLE) lmenu_open = false;
    SceTouchData t;
    memset(&t, 0, sizeof t);
    if (sceTouchPeek(SCE_TOUCH_PORT_FRONT, &t, 1) < 0) return;
    if (t.reportNum > 0 && !lmenu_touched && lmenu_open) {
        float sx, sy;
        panel_point(SCE_TOUCH_PORT_FRONT, &t.report[0], &sx, &sy);
        float bx = (sx - lmenu_x()) / LM_SCALE, by = (sy - lmenu_y()) / LM_SCALE;
        int row = mbox_hit(lmenu_w, lmenu_n, bx, by);
        if (row >= 0) { lmenu_sel = row; lmenu_choose(row); }
        else if (bx < 0 || by < 0 || bx >= lmenu_w || by >= lmenu_h) lmenu_open = false;
    }
    lmenu_touched = t.reportNum > 0;
}

/* over the picture, in present() */
static vita2d_texture *lmenu_tex;
static uint32_t lmenu_px[LM_TEX * LM_TEX], lmenu_shown[LM_TEX * LM_TEX];

static void lmenu_draw(void)
{
    if (!lmenu_open) return;
    lmenu_build();                             /* (its labels follow the settings) */
    if (!lmenu_tex) {
        lmenu_tex = vita2d_create_empty_texture_format(LM_TEX, LM_TEX, SCE_GXM_TEXTURE_FORMAT_U8U8U8U8_ARGB);
        if (!lmenu_tex) return;
        vita2d_texture_set_filters(lmenu_tex, SCE_GXM_TEXTURE_FILTER_POINT, SCE_GXM_TEXTURE_FILTER_POINT);
        memset(lmenu_shown, 0xFF, sizeof lmenu_shown);
    }
    mbox_render(lmenu_px, lmenu_w, lmenu_h, "PINBALL NS", lmenu_label, lmenu_n, lmenu_sel, NULL, 0);
    if (memcmp(lmenu_px, lmenu_shown, sizeof(uint32_t) * lmenu_w * lmenu_h) != 0) {
        vita2d_wait_rendering_done();
        uint8_t *dst = (uint8_t *)vita2d_texture_get_datap(lmenu_tex);
        unsigned stride = vita2d_texture_get_stride(lmenu_tex);
        for (int y = 0; y < lmenu_h; y++) memcpy(dst + (size_t)y * stride, lmenu_px + y * lmenu_w, (size_t)lmenu_w * 4);
        memcpy(lmenu_shown, lmenu_px, sizeof(uint32_t) * lmenu_w * lmenu_h);
    }
    vita2d_draw_rectangle(0, 0, SCR_W, SCR_H, RGBA8(0, 0, 0, 120));     /* the table behind, darkened */
    vita2d_draw_texture_part_scale(lmenu_tex, lmenu_x(), lmenu_y(), 0, 0, (float)lmenu_w, (float)lmenu_h,
                                   LM_SCALE, LM_SCALE);
}

/* ------------------------------------------------------------------ buttons */

static void input(void)
{
    SceCtrlData c;
    memset(&c, 0, sizeof c);
    sceCtrlPeekBufferPositive(0, &c, 1);
    uint32_t b = c.buttons, pressed = b & ~buttons_prev;
    buttons_prev = b;

    if (b & SCE_CTRL_SELECT) {
        /* SELECT + L + R: the other way to hold it (nothing else is done with SELECT held) */
        static bool both;
        const uint32_t LR = SCE_CTRL_LTRIGGER | SCE_CTRL_RTRIGGER;
        if (pressed & SCE_CTRL_SELECT) { select_used = false; select_combo = 0; both = false; }
        if (pressed & ~SCE_CTRL_SELECT) select_used = true;          /* not SELECT alone, then */
        if ((b & LR) == LR && !both) {
            both = true;
            set_hold(hold == HOLD_LANDSCAPE ? HOLD_DPAD_DOWN : HOLD_LANDSCAPE, true);
        }
        if (!(b & LR)) both = false;
        select_combo |= b & ~SCE_CTRL_SELECT;
        desk_pad(&D, 0);                         /* nothing to the game while SELECT is held */
        return;
    }
    /* SELECT released: the buttons of its combination reach the game only once released too */
    select_combo &= b;
    b &= ~select_combo;
    pressed &= b;

    if (lmenu_open) {                            /* the menu, landscape: nothing to the game */
        lmenu_input(pressed);
        desk_pad(&D, 0);
        return;
    }

    long in = 0;
    if (b & SCE_CTRL_UP) in |= 1L << PAD_DUP;
    if (b & SCE_CTRL_DOWN) in |= 1L << PAD_DDOWN;
    if (b & SCE_CTRL_LEFT) in |= 1L << PAD_DLEFT;
    if (b & SCE_CTRL_RIGHT) in |= 1L << PAD_DRIGHT;
    if (b & SCE_CTRL_CROSS) in |= 1L << PAD_A;       /* launch, confirm (and the right flipper) */
    if (b & SCE_CTRL_CIRCLE) in |= 1L << PAD_B;      /* back; in a game, the right tilt */
    if (b & SCE_CTRL_SQUARE) in |= 1L << PAD_X;
    if (b & SCE_CTRL_TRIANGLE) in |= 1L << PAD_Y;    /* the upper tilt */
    if (b & SCE_CTRL_LTRIGGER) in |= 1L << PAD_LB;   /* left flipper */
    if (b & SCE_CTRL_RTRIGGER) in |= 1L << PAD_RB;   /* right flipper */
    if (b & SCE_CTRL_START) in |= 1L << PAD_START;
    if (c.lx < 64) in |= 1L << PAD_LS_LEFT;
    if (c.lx > 192) in |= 1L << PAD_LS_RIGHT;
    if (c.ly < 64) in |= 1L << PAD_LS_UP;
    if (c.ly > 192) in |= 1L << PAD_LS_DOWN;
    in |= motion_tilt();
    in |= touch_front();
    desk_pad(&D, in);
}

/* SELECT pressed and released alone: the menu (the phones' in portrait, its box in landscape) */
static void select_alone(void)
{
    static bool held;
    bool now = (buttons_prev & SCE_CTRL_SELECT) != 0;
    if (held && !now && !select_used && D.pb && !D.ui.no_rom) {
        desk_keys_released(&D);
        if (D.handheld) ui_open_menu(&D.ui, !D.ui.menu_open);
        else lmenu_show(!lmenu_open);
    }
    held = now;
}

/* ------------------------------------------------------------------ rumble */

/* The game's motor (the Rumble version of the cartridge) in the gamepads that have one: a DualShock 3
 * or 4 on a PS TV (ports 1 to 4); a Vita has none. Set when it changes; the menu's VIBRATION turns it
 * off (desk_rumble). */
static bool rumble_on;

static void rumble_set(bool on)
{
    if (on == rumble_on) return;
    rumble_on = on;
    SceCtrlPortInfo info;
    memset(&info, 0, sizeof info);
    if (sceCtrlGetControllerPortInfo(&info) < 0) return;
    for (int port = 1; port <= 4; port++) {
        int type = info.port[port];
        if (type != SCE_CTRL_TYPE_DS3 && type != SCE_CTRL_TYPE_DS4) continue;
        SceCtrlActuator act;
        memset(&act, 0, sizeof act);
        act.small = on ? 1 : 0;              /* the small motor: on or off (a light buzz, as the cartridge's) */
        act.large = on ? 96 : 0;
        sceCtrlSetActuator(port, &act);
    }
}

/* ------------------------------------------------------------------ the ROM */

static bool has_ext(const char *name, const char *ext)
{
    size_t n = strlen(name), e = strlen(ext);
    return n > e && !strcasecmp(name + n - e, ext);
}

/* every .gbc of the folder (so that the menu's GAME knows both games), then the one played last */
static bool find_roms(char *err, size_t errn)
{
    bool any = false;
    char last[DESK_PATH];
    snprintf(last, sizeof last, "%s", D.rom_path[0] ? D.rom_path : D.rom_paths[0]);
    SceUID dir = sceIoDopen(DATA_DIR);
    if (dir >= 0) {
        SceIoDirent e;
        memset(&e, 0, sizeof e);
        while (sceIoDread(dir, &e) > 0) {
            if (!has_ext(e.d_name, ".gbc")) continue;
            char path[DESK_PATH];
            snprintf(path, sizeof path, "%s/%s", DATA_DIR, e.d_name);
            if (desk_open_rom(&D, path, err, errn)) any = true;
        }
        sceIoDclose(dir);
    }
    if (any && last[0] && strcmp(last, D.rom_path) != 0) {
        char e2[512];
        desk_open_rom(&D, last, e2, sizeof e2);
    }
    if (!any && !err[0])
        snprintf(err, errn, "No ROM found.\n\nCopy the ROM dumped from your own Pokemon Pinball cartridge\n"
                            "(US version, a .gbc file) to " DATA_DIR "/\n"
                            "Pokemon Pinball Generations 1.6 (patched ROM) works too.");
    return any;
}

/* ------------------------------------------------------------------ the picture */

/* the game's picture: two textures in turn (the CPU fills one while the GPU may still read the
 * other, no wait), and for sharp pixels at a size that is no whole multiple, a texture the GPU
 * draws it into a whole number of times larger (rt), then drawn smoothly to its size */
static vita2d_texture *src[2], *rt;
static int src_i, src_w, src_h, rt_w, rt_h, rt_cw, rt_ch;   /* rt: its size (aligned), the picture in it */
static vita2d_pgf *font;

static void draw_message(const char *msg)
{
    if (!font) font = vita2d_load_default_pgf();
    vita2d_start_drawing();
    vita2d_clear_screen();
    if (font) {
        int y = 140;
        char line[256];
        const char *p = msg;
        while (*p) {
            const char *nl = strchr(p, '\n');
            size_t n = nl ? (size_t)(nl - p) : strlen(p);
            if (n >= sizeof line) n = sizeof line - 1;
            memcpy(line, p, n);
            line[n] = 0;
            vita2d_pgf_draw_text(font, 60, y, RGBA8(255, 255, 255, 255), 1.0f, line);
            y += 30;
            p += n + (nl ? 1 : 0);
        }
        vita2d_pgf_draw_text(font, 60, y + 30, RGBA8(255, 210, 80, 255), 1.0f, "CROSS: look again    START: quit");
    }
    vita2d_end_drawing();
    vita2d_swap_buffers();
}

/* The speed readout (SELECT + LEFT): the time the emulation took, a second at a time */
static double perf_emu, perf_emu_max, perf_t0;
static int perf_frames, perf_shows;

static void perf_add(double emu_s)
{
    perf_emu += emu_s;
    if (emu_s > perf_emu_max) perf_emu_max = emu_s;
}

static void perf_tick(double t, int frames)
{
    perf_frames += frames;
    perf_shows++;
    if (t - perf_t0 >= 1.0) {
        double secs = t - perf_t0;
        snprintf(perf_text, sizeof perf_text, "game %.1f fps  screen %.1f fps  emulation %.1f ms/frame (worst %.1f)",
                 perf_frames / secs, perf_shows / secs, perf_frames ? perf_emu * 1000 / perf_frames : 0.0, perf_emu_max * 1000);
        perf_t0 = t;
        perf_frames = perf_shows = 0;
        perf_emu = perf_emu_max = 0;
    }
}

/* Sharp pixels at any size: the picture made a whole number of times larger (each pixel a block, by
 * the GPU), then drawn smoothly to its size; every pixel comes out the same size, softened at its
 * edges only (sharp bilinear). The screen filters and "smooth" are drawn smoothly as they are. */
static int prescale_of(const DeskPicture *p)
{
    if (p->smooth) return 1;
    float s = fmaxf((float)p->dw / p->w, (float)p->dh / p->h);
    if (fabsf(s - roundf(s)) < 0.01f) return 1;            /* a whole size: the nearest pixel is exact */
    int k = (int)ceilf(s);
    while (k > 1 && (p->w * k > 2048 || p->h * k > 2048)) k--;
    return k;
}

static void present(void)
{
    DeskPicture p;
    desk_picture(&D, win_w(), win_h(), &p);
    /* the per-frame memory of vita2d (vertices): only vita2d_start_drawing empties it, not
     * vita2d_start_drawing_advanced (the passes into rt): emptied here, once a frame, or it runs out
     * after a few minutes (a crash: its vertices written at NULL) */
    vita2d_pool_reset();
    vita2d_texture *draw = NULL;
    int tw = 0, th = 0;
    bool smooth = false;
    if (p.px && p.w > 0 && p.h > 0) {
        if (!src[0] || src_w != p.w || src_h != p.h) {
            vita2d_wait_rendering_done();
            for (int i = 0; i < 2; i++) {
                if (src[i]) vita2d_free_texture(src[i]);
                src[i] = vita2d_create_empty_texture_format((unsigned)p.w, (unsigned)p.h, SCE_GXM_TEXTURE_FORMAT_X8U8U8U8_1RGB);
            }
            src_w = p.w;
            src_h = p.h;
        }
        vita2d_texture *cur = src[src_i];
        src_i ^= 1;
        if (cur) {
            uint8_t *dst = (uint8_t *)vita2d_texture_get_datap(cur);
            unsigned dstride = vita2d_texture_get_stride(cur);
            for (int y = 0; y < p.h; y++) memcpy(dst + (size_t)y * dstride, p.px + (size_t)y * p.stride, (size_t)p.w * 4);
            int k = prescale_of(&p);
            if (k > 1 && (!rt || rt_cw != p.w * k || rt_ch != p.h * k)) {
                /* its width a multiple of 32: vita2d draws into it with rows of `width` pixels, and the
                 * texture reads rows padded to 8 (the picture sheared otherwise); the picture in its
                 * top left corner */
                vita2d_wait_rendering_done();
                if (rt) vita2d_free_texture(rt);
                int aw = (p.w * k + 31) & ~31, ah = (p.h * k + 7) & ~7;
                rt = vita2d_create_empty_texture_rendertarget((unsigned)aw, (unsigned)ah, SCE_GXM_TEXTURE_FORMAT_A8B8G8R8);
                rt_w = rt ? aw : 0;
                rt_h = rt ? ah : 0;
                rt_cw = rt ? p.w * k : 0;
                rt_ch = rt ? p.h * k : 0;
            }
            if (k > 1 && rt) {
                /* the GPU enlarges it, each pixel a k x k block, into rt */
                vita2d_texture_set_filters(cur, SCE_GXM_TEXTURE_FILTER_POINT, SCE_GXM_TEXTURE_FILTER_POINT);
                vita2d_start_drawing_advanced(rt, SCE_GXM_SCENE_FRAGMENT_SET_DEPENDENCY);
                /* (vita2d maps 960 x 544 onto any target: the whole of rt is that size here) */
                vita2d_draw_texture_scale(cur, 0, 0, (float)SCR_W * k / rt_w, (float)SCR_H * k / rt_h);
                vita2d_end_drawing();
                vita2d_start_drawing_advanced(NULL, SCE_GXM_SCENE_VERTEX_WAIT_FOR_DEPENDENCY);
                draw = rt;
                tw = rt_cw;
                th = rt_ch;
                smooth = true;
            } else {
                vita2d_start_drawing();
                draw = cur;
                tw = p.w;
                th = p.h;
                smooth = p.smooth;
            }
        }
    }
    if (!draw) vita2d_start_drawing();
    vita2d_clear_screen();
    if (draw) {
        SceGxmTextureFilter f = smooth ? SCE_GXM_TEXTURE_FILTER_LINEAR : SCE_GXM_TEXTURE_FILTER_POINT;
        vita2d_texture_set_filters(draw, f, f);
        float xs = (float)p.dw / tw, ys = (float)p.dh / th;
        /* (the part of the texture holding the picture: tw x th from its top left corner) */
        if (hold == HOLD_LANDSCAPE) {
            vita2d_draw_texture_part_scale(draw, (float)p.x, (float)p.y, 0, 0, (float)tw, (float)th, xs, ys);
        } else {
            float cx, cy;
            win_to_screen(p.x + p.dw / 2.0f, p.y + p.dh / 2.0f, &cx, &cy);
            vita2d_draw_texture_part_scale_rotate(draw, cx, cy, 0, 0, (float)tw, (float)th, xs, ys,
                                                  hold == HOLD_DPAD_DOWN ? (float)M_PI_2 : (float)-M_PI_2);
        }
    }
    if (hold == HOLD_LANDSCAPE) lmenu_draw();
    if (perf_on && perf_text[0]) {
        if (!font) font = vita2d_load_default_pgf();
        if (font) {
            vita2d_draw_rectangle(0, 0, SCR_W, 26, RGBA8(0, 0, 0, 180));
            vita2d_pgf_draw_text(font, 8, 19, RGBA8(120, 255, 120, 255), 0.9f, perf_text);
        }
    }
    vita2d_end_drawing();
    vita2d_swap_buffers();                           /* (waits for the vertical blank) */
}

/* The screens at the start, in a box drawn as the menu of the game (chooser.h), 3 screen pixels per
 * game pixel, at the bottom of its picture (chooser_bg.png: the logo, its background extended to the
 * screen): which game (when both ROMs are there), then how the Vita will be held; the last choices
 * highlighted. The d-pad moves, CROSS or START takes the entry, or a tap on it. The last row of the
 * second, ASK AT START, is a switch: NO, and neither is shown again (ASK AT START in the menu, again). */
#define CH_SCALE 3

/* the box: `n` entries, then (if `ask`) the row ASK AT START; the entry taken. `slr`: SELECT + L + R
 * goes from one of the first two entries to the other (the orientation). */
static int choose_box(vita2d_texture *bg, const char *title, const char *const *label, int n, int sel,
                      const char *const *hint, int nh, bool *ask, bool slr)
{
    const char *rows[8];
    int nr = 0;
    for (int i = 0; i < n && nr < 7; i++) rows[nr++] = label[i];
    if (ask) rows[nr++] = "";
    const int W = CH_W, H = mbox_h(nr, nh);
    uint32_t *box = (uint32_t *)malloc(sizeof(uint32_t) * W * H);
    vita2d_texture *bt = vita2d_create_empty_texture_format(W, H, SCE_GXM_TEXTURE_FORMAT_U8U8U8U8_ARGB);
    if (bt) vita2d_texture_set_filters(bt, SCE_GXM_TEXTURE_FILTER_POINT, SCE_GXM_TEXTURE_FILTER_POINT);
    const float bx = (SCR_W - W * CH_SCALE) / 2.0f, by = SCR_H - H * CH_SCALE - 14.0f;   /* under the logo */
    const uint32_t SLR = SCE_CTRL_SELECT | SCE_CTRL_LTRIGGER | SCE_CTRL_RTRIGGER;
    int drawn = -1, chosen = -1;
    bool drawn_ask = false;
    uint32_t prev = ~0u;                         /* (the buttons held at the start: not a press) */
    bool touched = true;                         /* (a finger already down: not a tap) */
    while (chosen < 0) {
        int take = -1;
        SceCtrlData c;
        memset(&c, 0, sizeof c);
        sceCtrlPeekBufferPositive(0, &c, 1);
        uint32_t pressed = c.buttons & ~prev;
        prev = c.buttons;
        if (slr && (c.buttons & SLR) == SLR && (pressed & SLR)) sel = sel == 0 ? 1 : 0;
        if (pressed & SCE_CTRL_UP) sel = sel > 0 ? sel - 1 : 0;
        if (pressed & SCE_CTRL_DOWN) sel = sel < nr - 1 ? sel + 1 : nr - 1;
        if (pressed & (SCE_CTRL_START | SCE_CTRL_CROSS)) {
            take = sel;
            select_combo = c.buttons & (SCE_CTRL_START | SCE_CTRL_CROSS);   /* not given to the game until released */
        }
        SceTouchData t;
        memset(&t, 0, sizeof t);
        sceTouchPeek(SCE_TOUCH_PORT_FRONT, &t, 1);
        if (t.reportNum > 0 && !touched) {
            float sx, sy;
            panel_point(SCE_TOUCH_PORT_FRONT, &t.report[0], &sx, &sy);
            int row = mbox_hit(W, nr, (sx - bx) / CH_SCALE, (sy - by) / CH_SCALE);
            if (row >= 0) { sel = row; take = row; }
        }
        touched = t.reportNum > 0;
        if (take >= 0) {
            if (ask && take == n) *ask = !*ask;  /* the switch */
            else chosen = take;
        }
        vita2d_start_drawing();
        vita2d_clear_screen();
        if (bg) vita2d_draw_texture(bg, 0, 0);
        if (bt && box) {
            bool a = ask && *ask;
            if (drawn != sel || drawn_ask != a) {
                if (ask) rows[n] = a ? "ASK AT START : YES" : "ASK AT START : NO";
                vita2d_wait_rendering_done();
                mbox_render(box, W, H, title, rows, nr, sel, hint, nh);
                uint8_t *dst = (uint8_t *)vita2d_texture_get_datap(bt);
                unsigned stride = vita2d_texture_get_stride(bt);
                for (int y = 0; y < H; y++) memcpy(dst + (size_t)y * stride, box + y * W, (size_t)W * 4);
                drawn = sel;
                drawn_ask = a;
            }
            vita2d_draw_texture_scale(bt, bx, by, CH_SCALE, CH_SCALE);
        }
        vita2d_end_drawing();
        vita2d_swap_buffers();
    }
    vita2d_wait_rendering_done();
    if (bt) vita2d_free_texture(bt);
    free(box);
    return chosen;
}

/* the screens at the start (unless ASK AT START is NO) */
static void choose_start(void)
{
    if (!ask_start) return;
    font_init();
    vita2d_texture *bg = vita2d_load_PNG_file("app0:chooser_bg.png");
    if (D.rom_paths[0][0] && D.rom_paths[1][0]) {                 /* both games: which one */
        static const char *const games[2] = { "POKéMON PINBALL", "POKéMON PINBALL GENERATIONS" };
        int cur = D.pb && D.pb->rom->id == PB_ROM_GENERATIONS;
        int g = choose_box(bg, "WHICH GAME?", games, 2, cur, NULL, 0, NULL, false);
        if (g != cur) {
            char path[DESK_PATH], err[512];
            snprintf(path, sizeof path, "%s", D.rom_paths[g]);
            desk_open_rom(&D, path, err, sizeof err);
        }
    }
    static const int holds[CH_N] = { HOLD_LANDSCAPE, HOLD_DPAD_DOWN };
    bool ask = true;
    int h = choose_box(bg, "HOW WILL YOU HOLD IT?", ch_label, CH_N, hold == HOLD_LANDSCAPE ? 0 : 1,
                       ch_hint, CH_HINTS, &ask, true);
    hold = holds[h];
    ask_start = ask;
    if (bg) vita2d_free_texture(bg);
}

/* ------------------------------------------------------------------ main */

int main(void)
{
    scePowerSetArmClockFrequency(444);
    scePowerSetBusClockFrequency(222);
    scePowerSetGpuClockFrequency(222);
    scePowerSetGpuXbarClockFrequency(166);
    sceIoMkdir(DATA_DIR, 0777);
    snprintf(vita_cfg, sizeof vita_cfg, "%s/vita.cfg", DATA_DIR);

    desk_init(&D, DATA_DIR "/pinball_ns.cfg");
    D.ui.no_rom_how = "Copy it to " DATA_DIR "/ and start again.\n\n";
    /* the controls of the phones' screen for the Vita's thumbs: more room for them (the game a
     * little smaller), bigger flipper keys, pressed from a little around them too */
    nd_block_min = 62;
    nd_key_size = 48;
    nd_key_inset = 3;
    nd_key_slop = 8;
    hold_load();
    D.ui.hold_entry = true;                      /* ORIENTATION in the menu */
    D.ui.ask_entry = true;                       /* ASK AT START too */
    D.ui.port_credits = "PlayStation Vita Port\nPorted by Robert M & Claude 2026";
    D.ui.about_hint =
        "ORIENTATION: landscape (L / R the flippers, CROSS launches) or portrait (the touch keys). "
        "SELECT + L + R switches too.\n\n"
        "GAME TOUCH: TILT: the left, middle or right third of the game gives the left, upper or right tilt. "
        "FLIPPERS: its halves play the flippers.\n\n"
        "MOTION TILT: tap a side of the Vita to tilt that way; shake it up and down for the upper tilt.\n\n"
        "GAME: Pokémon Pinball, or Generations once its ROM is in " DATA_DIR ".\n\n"
        "Tap for more.";
    D.ui.menu_hide &= ~(1u << UI_ENTRY_MOTION);  /* MOTION TILT too: the shake */
    D.ui.menu_hide |= 1u << UI_ENTRY_FILTER;     /* no SCREEN FILTER: too slow on the Vita */
    D.filter = D.ui.filter = 0;                  /* (one chosen before: off) */
    D.ui.motion = shake;

    vita2d_init();
    vita2d_set_clear_color(RGBA8(0, 0, 0, 255));
    vita2d_set_vblank_wait(1);
    sceCtrlSetSamplingMode(SCE_CTRL_MODE_ANALOG);
    sceTouchSetSamplingState(SCE_TOUCH_PORT_FRONT, SCE_TOUCH_SAMPLING_STATE_START);
    sceTouchGetPanelInfo(SCE_TOUCH_PORT_FRONT, &panel[SCE_TOUCH_PORT_FRONT]);
    sceMotionStartSampling();

    /* the ROM: until one is there */
    for (;;) {
        char err[512] = "";
        if (find_roms(err, sizeof err)) break;
        uint32_t prev = SCE_CTRL_CROSS;
        for (;;) {
            draw_message(err);
            SceCtrlData c;
            sceCtrlPeekBufferPositive(0, &c, 1);
            uint32_t pressed = c.buttons & ~prev;
            prev = c.buttons;
            if (pressed & SCE_CTRL_START) { vita2d_fini(); sceKernelExitProcess(0); return 0; }
            if (pressed & SCE_CTRL_CROSS) break;
        }
    }
    if (hold == HOLD_DPAD_UP) hold = HOLD_DPAD_DOWN;
    choose_start();
    D.ui.ask_start = ask_start;
    hold_save();
    set_hold(hold, false);

    audio_open();
    pacer_reset(&pacer);
    bool was_active = false;
    double last_tick = 0;
    while (!D.quit) {
        input();
        select_alone();
        double t = now_s();
        bool active = D.pb && !D.paused && !D.page && !lmenu_open && !(D.handheld && D.ui.menu_open);
        if (active) {
            if (!was_active) {
                pacer_restart(&pacer);
                if (audio_port >= 0) sound_restart(&snd, t);
            }
            int n = pacer_frames(&pacer, t, 4);
            bool extra = false;
            for (int k = 0; k < n; k++) {
                if (audio_pace(t, n - k) == SOUND_EXTRA && !extra) { extra = true; n++; }
                double e0 = now_s();
                desk_frame(&D);
                perf_add(now_s() - e0);
                audio_pump();
            }
            perf_tick(t, n);
        } else if (!lmenu_open) {
            desk_frame(&D);                          /* (reads the buttons for the menu of the handheld mode) */
        }
        rumble_set(active && desk_rumble(&D));
        was_active = active;
        desk_tick(&D, t);
        if (D.ui.motion != shake) { shake = D.ui.motion; hold_save(); }          /* MOTION TILT */
        if (D.ui.ask_start != ask_start) { ask_start = D.ui.ask_start; hold_save(); }   /* ASK AT START */
        if (D.hold_request) {                                                  /* ORIENTATION */
            D.hold_request = false;
            set_hold(hold == HOLD_LANDSCAPE ? HOLD_DPAD_DOWN : HOLD_LANDSCAPE, true);
        }
        if (t - last_tick > 1.0) { sceKernelPowerTick(SCE_KERNEL_POWER_TICK_DISABLE_AUTO_SUSPEND); last_tick = t; }
        present();
    }

    rumble_set(false);
    desk_sram_flush(&D, false, false);
    atomic_store(&audio_run, false);
    if (audio_thid >= 0) sceKernelWaitThreadEnd(audio_thid, NULL, NULL);
    if (audio_port >= 0) sceAudioOutReleasePort(audio_port);
    vita2d_wait_rendering_done();
    for (int i = 0; i < 2; i++) if (src[i]) vita2d_free_texture(src[i]);
    if (rt) vita2d_free_texture(rt);
    if (font) vita2d_free_pgf(font);
    vita2d_fini();
    desk_free(&D);
    sceKernelExitProcess(0);
    return 0;
}
