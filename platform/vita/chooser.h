/*
 * chooser.h - the screen at the start asking how the Vita will be held, drawn as the menu of the
 * phone versions (platform/mobile/design.c): its letters (font5x7.h), the white box with the black
 * title bar and its Poke Balls, the highlighted entry in lavender with a Poke Ball, the hint in grey.
 * The box is drawn on its own (0xAARRGGBB, transparent around its rounded corners), in game pixels.
 * The same box, any size (mbox_*), is the menu of the landscape way (the phones' menu in portrait).
 */
#ifndef PB_CHOOSER_H
#define PB_CHOOSER_H

#include <math.h>
#include <stdint.h>
#include <string.h>
#include "../../src/front/font5x7.h"

#define CH_W      252                 /* the box, in game pixels */
#define CH_ROW    11
#define CH_HEAD   13
#define CH_N      2
#define CH_HINTS  1
#define CH_GAP    6                   /* between the choices and the hint */
#define CH_H      (CH_HEAD + 4 + CH_N * CH_ROW + 3 + CH_GAP + 2 + CH_HINTS * FONT_CELL_H + 3)

#define CHC_BLACK 0xFF000000u
#define CHC_WHITE 0xFFFFFFFFu
#define CHC_RED   0xFFFF0000u
#define CHC_SHADE 0xFFADADDEu
#define CHC_HOT   0xFFE6E6F5u
#define CHC_HINT  0xFF635273u

static const char *const ch_label[CH_N] = { "LANDSCAPE", "PORTRAIT" };
static const char *const ch_hint[CH_HINTS] = { "Change orientation by holding L+R+Select" };

static int ch_bw = CH_W, ch_bh = CH_H;   /* the box being drawn */

static void ch_put(uint32_t *p, int x, int y, uint32_t c)
{
    if (x >= 0 && y >= 0 && x < ch_bw && y < ch_bh) p[y * ch_bw + x] = c;
}

static void ch_fill(uint32_t *p, int x, int y, int w, int h, uint32_t c)
{
    for (int j = y; j < y + h; j++)
        for (int i = x; i < x + w; i++) ch_put(p, i, j, c);
}

static int ch_cut(int r, int dy)
{
    if (dy >= r) return 0;
    float yy = r - dy - 0.5f;
    return (int)floorf(r - sqrtf((float)r * r - yy * yy) + 0.5f);
}

static void ch_round(uint32_t *p, int x, int y, int w, int h, int r, uint32_t c)
{
    for (int j = 0; j < h; j++) {
        int dy = j < h - 1 - j ? j : h - 1 - j, cut = ch_cut(r, dy);
        ch_fill(p, x + cut, y + j, w - 2 * cut, 1, c);
    }
}

static int ch_text_w(const char *s) { int n = utf8_len(s); return n > 0 ? n * FONT_CELL_W - 1 : 0; }

static void ch_text(uint32_t *p, int x, int y, const char *s, uint32_t c)
{
    while (*s) {
        const FontGlyph *g = font_glyph(utf8_next(&s));
        for (int r = 0; r < FONT_H; r++)
            for (int k = 0; k < FONT_W; k++)
                if (g->rows[r] & (0x10 >> k)) ch_put(p, x + k, y + r, c);
        x += FONT_CELL_W;
    }
}

static void ch_text_outlined(uint32_t *p, int x, int y, const char *s, uint32_t c, uint32_t o)
{
    static const int d[8][2] = { { -1, -1 }, { 0, -1 }, { 1, -1 }, { -1, 0 }, { 1, 0 }, { -1, 1 }, { 0, 1 }, { 1, 1 } };
    for (int k = 0; k < 8; k++) ch_text(p, x + d[k][0], y + d[k][1], s, o);
    ch_text(p, x, y, s, c);
}

static void ch_pokeball(uint32_t *p, int x, int y)
{
    static const char *const rows[] = { "..000..", ".02210.", "0222220", "0003000", "0333330", ".04440.", "..000.." };
    static const uint32_t pal[] = { CHC_BLACK, CHC_WHITE, CHC_RED, CHC_WHITE, CHC_SHADE };
    for (int j = 0; j < 7; j++)
        for (int i = 0; rows[j][i]; i++)
            if (rows[j][i] != '.') ch_put(p, x + i, y + j, pal[rows[j][i] - '0']);
}

/* the height of a box of n entries and nh lines of hint */
static int mbox_h(int n, int nh)
{
    return CH_HEAD + 4 + n * CH_ROW + 3 + (nh > 0 ? CH_GAP + 2 + nh * FONT_CELL_H + 3 : 3);
}

/* the width for its title and entries (at least min_w) */
static int mbox_w(const char *title, const char *const *label, int n, int min_w)
{
    int w = ch_text_w(title) + 2 * 16 + 4;
    for (int i = 0; i < n; i++) if (ch_text_w(label[i]) + 16 + 12 > w) w = ch_text_w(label[i]) + 16 + 12;
    return w < min_w ? min_w : w;
}

/* the box (W x H), `hot` the entry highlighted (-1 none) */
static void mbox_render(uint32_t *p, int W, int H, const char *title, const char *const *label, int n, int hot,
                        const char *const *hint, int nh)
{
    ch_bw = W;
    ch_bh = H;
    memset(p, 0, sizeof(uint32_t) * W * H);
    int w = W - 2, h = H - 3;
    ch_round(p, 0, 0, w + 2, h + 3, 4, CHC_BLACK);                       /* outline and shadow */
    ch_round(p, 1, 1, w, h, 3, CHC_WHITE);
    ch_round(p, 2, 2, w - 2, CH_HEAD, 2, CHC_BLACK);                     /* the title bar */
    ch_text(p, 1 + w / 2 - ch_text_w(title) / 2, 5, title, CHC_WHITE);
    ch_pokeball(p, 5, 5);
    ch_pokeball(p, w - 10, 5);
    for (int i = 0; i < n; i++) {
        int ry = 1 + CH_HEAD + 3 + i * CH_ROW;
        if (i == hot) {
            ch_fill(p, 3, ry - 1, w - 4, CH_ROW - 1, CHC_HOT);
            ch_pokeball(p, 5, ry + 1);
        }
        ch_text_outlined(p, 16, ry + 1, label[i], CHC_WHITE, CHC_BLACK);
    }
    if (nh > 0) {
        int hy = 1 + CH_HEAD + 4 + n * CH_ROW + 2 + CH_GAP;
        ch_fill(p, 4, hy - 2, w - 6, 1, CHC_SHADE);
        for (int k = 0; k < nh; k++)
            ch_text(p, 1 + w / 2 - ch_text_w(hint[k]) / 2, hy + 1 + k * FONT_CELL_H, hint[k], CHC_HINT);
    }
    ch_bw = CH_W;
    ch_bh = CH_H;
}

/* the entry at a point of a box W wide (game pixels), -1 none */
static int mbox_hit(int W, int n, float x, float y)
{
    for (int i = 0; i < n; i++) {
        int ry = 1 + CH_HEAD + 3 + i * CH_ROW;
        if (x >= 1 && x < W - 1 && y >= ry - 1 && y < ry + CH_ROW - 1) return i;
    }
    return -1;
}

/* the screen at the start: the box (CH_W x CH_H), `hot` the entry highlighted */
static void chooser_render(uint32_t *p, int hot)
{
    mbox_render(p, CH_W, CH_H, "HOW WILL YOU HOLD IT?", ch_label, CH_N, hot, ch_hint, CH_HINTS);
}

/* the entry at a point of the box (game pixels), -1 none */
static int chooser_hit(float x, float y) { return mbox_hit(CH_W, CH_N, x, y); }

#endif
