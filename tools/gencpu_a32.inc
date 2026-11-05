/*
 * gencpu_a32.inc - the 32-bit ARM backend of gencpu.c (cpu_a32.S: PS Vita, Cortex-A9, ARM state),
 * included by gencpu.c: the same model as the ARM64 one, instruction by instruction.
 *
 * Registers (callee-saved r4-r11 hold the machine; r0-r3, r12, lr are free across the C calls):
 *   r4  X: &g->fast            r5  REM: limit - cycles (32 bits, see below)
 *   r6  PS: PC << 16 | SP      r7  A        r8  F
 *   r9  BC     r10 DE     r11 HL
 *   r0  the address (w9)       r1  T (w11)  r2  U (w12)  r3  the pointer (x10), or an operand
 *   r12 (ip), lr: scratch (lr is not kept across a bl)
 * PC in the high half of PS: PC + 1 is an add of 0x10000, the byte at PC an ldrb [p, PS, lsr #16].
 *
 * Time: the 64-bit cycle counter is held as REM = limit - cycles, 32 bits. At each reload (after
 * every call into the rest of the core) base = cycles goes to the frame, and the events, relative to
 * it and clamped to 0..0x7FFFFFFF (an event behind: 0, never: 0x7FFFFFFF), become thresholds on REM:
 *   cycles >= limit       REM <= 0
 *   cycles >= deadline    REM <= DTH  (= LIMREL - DLREL)
 *   cycles >= frame_end   REM <= FTH
 *   cycles <  dl24        REM >  D24TH
 * and cycles = base + LIMREL - REM (flush). A tick is a sub from REM.
 *
 * The frame (sp after the prologue; spoff added inside the routines that push):
 */
#define SL_G 0          /* g */
#define SL_HOOKS 4      /* g->hookbyte */
#define SL_JTF 8        /* the four tables of handlers */
#define SL_JTC 12
#define SL_JTFCB 16
#define SL_JTCCB 20
#define SL_BUDP 24      /* the budget's pointer */
#define SL_BUD 28       /* the budget, 32 bits (clamped), counted down */
#define SL_BUD0 32      /* ...from this */
#define SL_BASELO 36    /* cycles at the last reload */
#define SL_BASEHI 40
#define SL_LIMREL 44
#define SL_DTH 48
#define SL_FTH 52
#define SL_D24TH 56
#define SL_SCR 60       /* CALL: the target */
#define A32_FRAME 68    /* + 36 pushed: 104, a multiple of 8 */

static int a32;          /* backend: 32-bit ARM */
static int spoff;        /* bytes pushed below the frame (the routines) */

static int b_enc(uint32_t v)         /* an ARM modified immediate */
{
    for (int r = 0; r < 32; r += 2) {
        uint32_t x = (v << r) | (r ? v >> (32 - r) : 0);
        if (x < 256) return 1;
    }
    return 0;
}

static void b_mov32(const char *reg, uint32_t v)
{
    if (b_enc(v)) { E("mov %s, #%u", reg, v); return; }
    if (b_enc(~v)) { E("mvn %s, #%u", reg, ~v); return; }
    E("movw %s, #%u", reg, v & 0xFFFF);
    if (v >> 16) E("movt %s, #%u", reg, v >> 16);
}

static void b_cmpk(const char *reg, uint32_t v)   /* cmp reg, v (ip when v needs it) */
{
    if (b_enc(v)) E("cmp %s, #%u", reg, v);
    else { b_mov32("ip", v); E("cmp %s, ip", reg); }
}

static void b_addk(const char *dst, const char *src, uint32_t v)   /* dst = src + v (dst may be src) */
{
    if (b_enc(v)) { E("add %s, %s, #%u", dst, src, v); return; }
    uint32_t lo = v & 0xFF, hi = v - lo;
    if (b_enc(hi) && b_enc(lo)) { E("add %s, %s, #%u", dst, src, hi); E("add %s, %s, #%u", dst, dst, lo); return; }
    fprintf(stderr, "b_addk %u\n", v); exit(1);
}

static const char *B_PAIR[] = { "r9", "r10", "r11", "?", "?", "r2" };   /* BC DE HL (SP PC: PS) U */

/* an 8-bit operand into a register, a register into an 8-bit operand */
static void b_get8(const char *dst, int r)
{
    switch (r) {
    case RB: E("lsr %s, r9, #8", dst); break;
    case RC: E("uxtb %s, r9", dst); break;
    case RD: E("lsr %s, r10, #8", dst); break;
    case RE: E("uxtb %s, r10", dst); break;
    case RH: E("lsr %s, r11, #8", dst); break;
    case RL: E("uxtb %s, r11", dst); break;
    case RA: if (strcmp(dst, "r7")) E("mov %s, r7", dst); break;
    case RT: if (strcmp(dst, "r1")) E("mov %s, r1", dst); break;
    case RU: if (strcmp(dst, "r2")) E("mov %s, r2", dst); break;
    default: fprintf(stderr, "b_get8 %d\n", r); exit(1);
    }
}

static void b_set8(int r, const char *src)
{
    switch (r) {
    case RB: E("bfi r9, %s, #8, #8", src); break;
    case RC: E("bfi r9, %s, #0, #8", src); break;
    case RD: E("bfi r10, %s, #8, #8", src); break;
    case RE: E("bfi r10, %s, #0, #8", src); break;
    case RH: E("bfi r11, %s, #8, #8", src); break;
    case RL: E("bfi r11, %s, #0, #8", src); break;
    case RA: E("and r7, %s, #0xFF", src); break;
    case RT: E("and r1, %s, #0xFF", src); break;
    case RU: E("and r2, %s, #0xFF", src); break;
    default: fprintf(stderr, "b_set8 %d\n", r); exit(1);
    }
}

static const char *b_src8(int r)     /* the register holding an 8-bit operand, or r3 */
{
    if (r == RA) return "r7";
    if (r == RT) return "r1";
    if (r == RU) return "r2";
    b_get8("r3", r);
    return "r3";
}

/* the registers (and the time unless frozen) into GBC.s; uses r3, ip, lr */
static void b_flush(void)
{
    int n = lab();
    E("ldr ip, [sp, #%d]", SL_G + spoff);
    E("strb r7, [ip, #%d]", A32_S_A);
    E("strb r8, [ip, #%d]", A32_S_F);
    E("rev16 lr, r9");
    E("strh lr, [ip, #%d]", A32_S_B);
    E("rev16 lr, r10");
    E("strh lr, [ip, #%d]", A32_S_D);
    E("rev16 lr, r11");
    E("strh lr, [ip, #%d]", A32_S_H);
    E("strh r6, [ip, #%d]", A32_S_SP);
    E("lsr lr, r6, #16");
    E("strh lr, [ip, #%d]", A32_S_PC);
    E("ldrb lr, [r4, #%d]", A32_X_FROZEN);
    E("cmp lr, #0");
    E("bne L%d", n);
    E("ldr r3, [sp, #%d]", SL_LIMREL + spoff);
    E("sub r3, r3, r5");                 /* cycles - base */
    E("ldr lr, [sp, #%d]", SL_BASELO + spoff);
    E("adds lr, lr, r3");
    E("str lr, [ip, #%d]", A32_S_CYCLES);
    E("ldr r3, [sp, #%d]", SL_BASEHI + spoff);
    E("adc r3, r3, #0");
    E("str r3, [ip, #%d]", A32_S_CYCLES + 4);
    E("ldrh r3, [r4, #%d]", A32_X_DIV_BASE);
    E("add r3, r3, lr");
    b_mov32("lr", A32_S_DIV16);
    E("strh r3, [ip, lr]");
    LB("L%d", n);
}

/* r2 = an event of GBC.fast (64 bits at off) relative to base (r0, r1), clamped to 0..0x7FFFFFFF */
static void b_rel(int off)
{
    int done = lab();
    E("ldr r2, [r4, #%d]", off);
    E("ldr r3, [r4, #%d]", off + 4);
    E("subs r2, r2, r0");
    E("sbcs r3, r3, r1");                /* unsigned: never is UINT64_MAX */
    E("movlo r2, #0");                   /* behind */
    E("blo L%d", done);
    E("cmp r3, #0");
    E("mvnne r2, #0x80000000");          /* 2^32 or more ahead */
    E("cmp r2, #0");
    E("mvnlt r2, #0x80000000");          /* 2^31 or more */
    LB("L%d", done);
}

/* the registers, the time and its thresholds from GBC; uses r0-r3, ip, lr */
static void b_reload(void)
{
    E("ldr ip, [sp, #%d]", SL_G + spoff);
    E("ldrb r7, [ip, #%d]", A32_S_A);
    E("ldrb r8, [ip, #%d]", A32_S_F);
    E("ldrh lr, [ip, #%d]", A32_S_B);
    E("rev16 r9, lr");
    E("ldrh lr, [ip, #%d]", A32_S_D);
    E("rev16 r10, lr");
    E("ldrh lr, [ip, #%d]", A32_S_H);
    E("rev16 r11, lr");
    E("ldrh lr, [ip, #%d]", A32_S_SP);
    E("ldrh r3, [ip, #%d]", A32_S_PC);
    E("orr r6, lr, r3, lsl #16");
    E("ldr r0, [ip, #%d]", A32_S_CYCLES);
    E("ldr r1, [ip, #%d]", A32_S_CYCLES + 4);
    E("str r0, [sp, #%d]", SL_BASELO + spoff);
    E("str r1, [sp, #%d]", SL_BASEHI + spoff);
    b_rel(A32_X_LIMIT);
    E("str r2, [sp, #%d]", SL_LIMREL + spoff);
    E("mov r5, r2");
    b_rel(A32_X_DEADLINE);
    E("sub r2, r5, r2");
    E("str r2, [sp, #%d]", SL_DTH + spoff);
    b_rel(A32_X_FRAME_END);
    E("sub r2, r5, r2");
    E("str r2, [sp, #%d]", SL_FTH + spoff);
    b_rel(A32_X_DL24);
    E("sub r2, r5, r2");
    E("str r2, [sp, #%d]", SL_D24TH + spoff);
}

static void b_tick(int t)
{
    E("sub r5, r5, #%d", t);
    if (!careful && !wrote) return;
    int st = lab(), back = lab();
    E("ldr ip, [sp, #%d]", SL_DTH + spoff);
    E("cmp r5, ip");
    E("ble L%d", st);
    S("L%d:", st);
    S("bl Ltick_slow%d", t);
    S("b L%d", back);
    LB("L%d", back);
}

static void b_addr(int p)
{
    if (p == PSP) E("uxth r0, r6");
    else if (p == PPC) E("lsr r0, r6, #16");
    else E("mov r0, %s", B_PAIR[p]);
}

static void b_addr_ff(int r)
{
    if (r == RC) E("uxtb r0, r9");
    else E("mov r0, r1");
    E("orr r0, r0, #0xFF00");
}

static void b_rd(int dst)
{
    b_tick(4);
    int st = lab(), back = lab();
    E("lsr ip, r0, #12");
    E("ldr r3, [r4, ip, lsl #2]");
    E("cmp r3, #0");
    E("beq L%d", st);
    LB("L%d", back);
    if (dst == RA) E("ldrb r7, [r3, r0]");
    else if (dst == RT) E("ldrb r1, [r3, r0]");
    else if (dst == RU) E("ldrb r2, [r3, r0]");
    else if (dst == RX) E("ldrb r0, [r3, r0]");
    else { E("ldrb ip, [r3, r0]"); b_set8(dst, "ip"); }
    S("L%d:", st);
    S("bl Lrd_slow");
    S("b L%d", back);
}

static void b_wr(int src)
{
    b_tick(4);
    int st = lab(), back = lab();
    const char *v = b_src8(src);
    E("lsr ip, r0, #8");
    E("add ip, r4, ip, lsl #2");
    E("ldr ip, [ip, #%d]", A32_X_WRF);
    E("cmp ip, #0");
    E("beq L%d", st);
    E("strb %s, [ip, r0]", v);
    S("L%d:", st);
    if (strcmp(v, "r3")) S("mov r3, %s", v);
    S("bl Lwr_slow");
    S("b L%d", back);
    LB("L%d", back);
    wrote = 1;
}

static void b_sp_add(int d)
{
    E("uxth ip, r6");
    E(d > 0 ? "add ip, ip, #1" : "sub ip, ip, #1");
    E("pkhbt r6, ip, r6");
}

static void b_set_pair(int p, int from)
{
    const char *src = from == PSP ? "r3" : from == PPC ? "r3" : B_PAIR[from];
    if (from == PSP) E("uxth r3, r6");
    if (from == PPC) E("lsr r3, r6, #16");
    if (p == PSP) E("pkhbt r6, %s, r6", src);
    else if (p == PPC) E("pkhbt r6, r6, %s, lsl #16", src);
    else E("mov %s, %s", B_PAIR[p], src);
}

static void b_call_op(int op)
{
    b_flush();
    E("ldr r0, [sp, #%d]", SL_G + spoff);
    E("mov r1, #%d", op);
    E("bl gbc_asm_op");
    b_reload();
}

static void b_alu(int op, int src)
{
    const char *v = b_src8(src);
    if (op >= 4 && op <= 6) {
        E("%s r7, r7, %s", op == 4 ? "ands" : op == 5 ? "eors" : "orrs", v);
        E("moveq r8, #0x80");
        E("movne r8, #0");
        if (op == 4) E("orr r8, r8, #0x20");
        return;
    }
    bool sub = op >= 2;
    if (op == 1 || op == 3) E("and lr, r8, #0x10");
    E("%s ip, r7, %s", sub ? "sub" : "add", v);
    if (op == 1 || op == 3) E("%s ip, ip, lr, lsr #4", sub ? "sub" : "add");
    E("eor lr, r7, %s", v);
    E("eor lr, lr, ip");                 /* bit 4: carry (borrow) into bit 4, bit 8: out of bit 7 */
    if (op != 7) E("and r7, ip, #0xFF");
    E("and r8, lr, #0x10");
    E("lsl r8, r8, #1");
    E("tst lr, #0x100");
    E("orrne r8, r8, #0x10");
    E("tst ip, #0xFF");
    E("orreq r8, r8, #0x80");
    if (sub) E("orr r8, r8, #0x40");
}

static void b_incdec(int r, int dec)
{
    const char *v = b_src8(r);
    E("%s ip, %s, #1", dec ? "sub" : "add", v);
    E("and ip, ip, #0xFF");
    b_set8(r, "ip");
    E("and r8, r8, #0x10");
    if (dec) E("orr r8, r8, #0x40");
    E("cmp ip, #0");
    E("orreq r8, r8, #0x80");
    E("and lr, ip, #0xF");
    E("cmp lr, #%d", dec ? 15 : 0);
    E("orreq r8, r8, #0x20");
}

static void b_cb_rot(int op, int r)  /* result ip, carry lr */
{
    const char *v = b_src8(r);
    switch (op) {
    case 0: E("lsr lr, %s, #7", v); E("lsl ip, %s, #1", v); E("orr ip, ip, lr"); E("and ip, ip, #0xFF"); break;
    case 1: E("and lr, %s, #1", v); E("lsr ip, %s, #1", v); E("orr ip, ip, lr, lsl #7"); break;
    case 2: E("lsr lr, %s, #7", v); E("lsl ip, %s, #1", v); E("tst r8, #0x10"); E("orrne ip, ip, #1"); E("and ip, ip, #0xFF"); break;
    case 3: E("and lr, %s, #1", v); E("lsr ip, %s, #1", v); E("tst r8, #0x10"); E("orrne ip, ip, #0x80"); break;
    case 4: E("lsr lr, %s, #7", v); E("lsl ip, %s, #1", v); E("and ip, ip, #0xFF"); break;
    case 5: E("and lr, %s, #1", v); E("and ip, %s, #0x80", v); E("orr ip, ip, %s, lsr #1", v); break;
    case 6: E("mov lr, #0"); E("lsl ip, %s, #4", v); E("orr ip, ip, %s, lsr #4", v); E("and ip, ip, #0xFF"); break;
    default: E("and lr, %s, #1", v); E("lsr ip, %s, #1", v); break;
    }
    b_set8(r, "ip");
    E("cmp ip, #0");
    E("moveq r8, #0x80");
    E("movne r8, #0");
    E("orr r8, r8, lr, lsl #4");
}

static void b_dispatch(const char *table)    /* index r0 */
{
    int slot = !strcmp(table, "Ljt_f") ? SL_JTF : !strcmp(table, "Ljt_c") ? SL_JTC : !strcmp(table, "Ljt_fcb") ? SL_JTFCB : SL_JTCCB;
    E("ldr ip, [sp, #%d]", slot + spoff);
    E("ldr lr, [ip, r0, lsl #2]");
    E("add pc, ip, lr");
}

static void b_fetch_dispatch(const char *table)
{
    int st = lab(), back = lab();
    E("lsr ip, r6, #28");
    E("ldr r3, [r4, ip, lsl #2]");
    E("cmp r3, #0");
    E("beq L%d", st);
    LB("L%d", back);
    E("ldrb r0, [r3, r6, lsr #16]");
    E("add r6, r6, #0x10000");
    S("L%d:", st);
    S("lsr r0, r6, #16");
    S("bl Lrd_slow");
    S("b L%d", back);
    b_dispatch(table);
}

static void b_next(void)
{
    if (careful) { E("b Lnext"); return; }
    E("cmp r5, #0");
    E("ble Lslow_top");
    E("ldr ip, [sp, #%d]", SL_HOOKS);
    E("ldrb ip, [ip, r6, lsr #16]");
    E("cmp ip, #0");
    E("bne Lslow_top");
    E("ldr ip, [sp, #%d]", SL_BUD);
    E("subs ip, ip, #1");
    E("str ip, [sp, #%d]", SL_BUD);
    E("bmi Lexit_budget");
    E("sub r5, r5, #4");
    b_fetch_dispatch("Ljt_f");
}

/* the instructions written inline in gen_op / gen_cb (the rest goes through the helpers above) */
static int b_gen_op(int op)          /* 1: written here */
{
    int cc = (op >> 3) & 3, n;
    switch (op) {
    case 0x01: case 0x11: case 0x21: case 0x31:
        fetch16();
        if (op == 0x31) E("pkhbt r6, r2, r6");
        else E("mov %s, r2", B_PAIR[op >> 4]);
        return 1;
    case 0x22: case 0x32:
        addr(PHL); wr(RA);
        E("%s r11, r0, #1", op == 0x22 ? "add" : "sub");
        E("uxth r11, r11");
        return 1;
    case 0x2A: case 0x3A:
        addr(PHL); rd(RA);
        E("%s r11, r0, #1", op == 0x2A ? "add" : "sub");
        E("uxth r11, r11");
        return 1;
    case 0x03: case 0x13: case 0x23: case 0x33:
    case 0x0B: case 0x1B: case 0x2B: case 0x3B: {
        int p = op >> 4, dec = (op & 8) != 0;
        if (p == PSP) b_sp_add(dec ? -1 : 1);
        else { E("%s %s, %s, #1", dec ? "sub" : "add", B_PAIR[p], B_PAIR[p]); E("uxth %s, %s", B_PAIR[p], B_PAIR[p]); }
        tick(4);
        return 1;
    }
    case 0x07: case 0x0F: case 0x17: case 0x1F:          /* RLCA RRCA RLA RRA */
        if (op == 0x07 || op == 0x17) E("lsr r3, r7, #7");
        else E("and r3, r7, #1");
        if (op == 0x07) { E("lsl r7, r7, #1"); E("orr r7, r7, r3"); E("and r7, r7, #0xFF"); }
        if (op == 0x0F) { E("lsr r7, r7, #1"); E("orr r7, r7, r3, lsl #7"); }
        if (op == 0x17) { E("lsl r7, r7, #1"); E("tst r8, #0x10"); E("orrne r7, r7, #1"); E("and r7, r7, #0xFF"); }
        if (op == 0x1F) { E("lsr r7, r7, #1"); E("tst r8, #0x10"); E("orrne r7, r7, #0x80"); }
        E("lsl r8, r3, #4");
        return 1;
    case 0x08:                                            /* LD (nn),SP */
        fetch16();
        addr(PW);
        E("uxtb r1, r6");
        wr(RT);
        E("add r0, r2, #1");
        E("uxth r0, r0");
        E("ubfx r1, r6, #8, #8");
        wr(RT);
        return 1;
    case 0x09: case 0x19: case 0x29: case 0x39: {         /* ADD HL,rr */
        int p = op >> 4;
        const char *src = B_PAIR[p];
        if (p == PSP) { E("uxth r3, r6"); src = "r3"; }
        E("add ip, r11, %s", src);
        E("eor lr, r11, %s", src);
        E("eor lr, lr, ip");
        E("and r8, r8, #0x80");
        E("tst lr, #0x1000");
        E("orrne r8, r8, #0x20");
        E("tst lr, #0x10000");
        E("orrne r8, r8, #0x10");
        E("uxth r11, ip");
        tick(4);
        return 1;
    }
    case 0x18: case 0x20: case 0x28: case 0x30: case 0x38:
        fetch8(RT);
        n = lab();
        if (op != 0x18) jfalse(cc, n);
        E("sxtb ip, r1");
        E("add r6, r6, ip, lsl #16");
        tick(4);
        if ((op == 0x28 || op == 0x20) && !careful) {
            int st = lab(), back = lab(), d = op == 0x28 ? 4 : 8;
            E("cmn r1, #%d", 256 - d);   /* (the offset as read: 0xFC, 0xF8) */
            E("beq L%d", st);
            S("L%d:", st);
            S("bl %s", op == 0x28 ? "Lidle" : "Lcopy");
            S("b L%d", back);
            LB("L%d", back);
        }
        LB("L%d", n);
        return 1;
    case 0x27: {                                          /* DAA */
        int l_add = lab(), l1 = lab(), l2 = lab(), l3 = lab(), l4 = lab(), done = lab();
        E("mov r3, r7");
        E("ubfx ip, r8, #4, #1");
        E("tst r8, #0x40");
        E("beq L%d", l_add);
        E("tst r8, #0x20");
        E("beq L%d", l1);
        E("sub r3, r3, #6");
        LB("L%d", l1);
        E("cmp ip, #0");
        E("beq L%d", done);
        E("sub r3, r3, #0x60");
        E("b L%d", done);
        LB("L%d", l_add);
        E("cmp ip, #0");
        E("bne L%d", l2);
        E("cmp r3, #0x99");
        E("bls L%d", l3);
        LB("L%d", l2);
        E("add r3, r3, #0x60");
        E("mov ip, #1");
        LB("L%d", l3);
        E("tst r8, #0x20");
        E("bne L%d", l4);
        E("and lr, r3, #0xF");
        E("cmp lr, #9");
        E("bls L%d", done);
        LB("L%d", l4);
        E("add r3, r3, #6");
        LB("L%d", done);
        E("and r7, r3, #0xFF");
        E("and r8, r8, #0x40");
        E("orr r8, r8, ip, lsl #4");
        E("cmp r7, #0");
        E("orreq r8, r8, #0x80");
        return 1;
    }
    case 0x2F: E("eor r7, r7, #0xFF"); E("orr r8, r8, #0x60"); return 1;
    case 0x37: E("and r8, r8, #0x80"); E("orr r8, r8, #0x10"); return 1;
    case 0x3F: E("and r8, r8, #0x90"); E("eor r8, r8, #0x10"); return 1;
    case 0xF1: pop16(); E("lsr r7, r2, #8"); E("and r8, r2, #0xF0"); return 1;
    case 0xC5: case 0xD5: case 0xE5: case 0xF5:
        tick(4);
        if (op == 0xF5) E("orr r2, r8, r7, lsl #8");
        else set_pair(PW, (op >> 4) & 3);
        push16();
        return 1;
    case 0xC4: case 0xCC: case 0xD4: case 0xDC: case 0xCD:
        fetch16();
        n = lab();
        if (op != 0xCD) jfalse(cc, n);
        tick(4);
        E("str r2, [sp, #%d]", SL_SCR + spoff);
        E("lsr r2, r6, #16");
        push16();
        E("ldr ip, [sp, #%d]", SL_SCR + spoff);
        E("pkhbt r6, r6, ip, lsl #16");
        LB("L%d", n);
        return 1;
    case 0xC7: case 0xCF: case 0xD7: case 0xDF: case 0xE7: case 0xEF: case 0xF7: case 0xFF:
        tick(4);
        E("lsr r2, r6, #16");
        push16();
        E("mov ip, #%d", op & 0x38);
        E("pkhbt r6, r6, ip, lsl #16");
        return 1;
    case 0xE0: case 0xF0: {                               /* LDH: high RAM directly (FF80-FFFE) */
        int gen = lab(), done = lab();
        fetch8(RT);
        E("cmp r1, #0x80");
        E("blo L%d", gen);
        E("cmp r1, #0xFF");
        E("beq L%d", gen);
        tick(4);
        E("ldr r3, [r4, #%d]", A32_X_HRAMB);
        E("orr ip, r1, #0xFF00");
        E(op == 0xE0 ? "strb r7, [r3, ip]" : "ldrb r7, [r3, ip]");
        E("b L%d", done);
        LB("L%d", gen);
        addr_ff(RT);
        if (op == 0xE0) wr(RA); else rd(RA);
        LB("L%d", done);
        return 1;
    }
    case 0xE8: case 0xF8:                                 /* ADD SP,e  LD HL,SP+e */
        fetch8(RT);
        E("uxtb r3, r6");
        E("add r3, r3, r1");
        E("and ip, r6, #0xF");
        E("and lr, r1, #0xF");
        E("add ip, ip, lr");
        E("ubfx r3, r3, #8, #1");
        E("ubfx ip, ip, #4, #1");
        E("lsl r8, r3, #4");
        E("orr r8, r8, ip, lsl #5");
        E("sxtb lr, r1");
        E("uxth r3, r6");
        E("add r3, r3, lr");
        if (op == 0xE8) E("pkhbt r6, r3, r6");
        else E("uxth r11, r3");
        tick(op == 0xE8 ? 8 : 4);
        return 1;
    }
    return 0;
}

/* ------------------------------------------------------------------ the routines */

static void b_routines(void)
{
    /* rd_slow: r0 the address -> r3 such that [r3 + r0] is the byte; keeps r0-r2 */
    LB("Lrd_slow");
    b_cmpk("r0", 0xFF80);
    E("blo Lrs1");
    b_cmpk("r0", 0xFFFF);
    E("beq Lrs2");
    E("ldr r3, [r4, #%d]", A32_X_HRAMB);
    E("bx lr");
    LB("Lrs1");
    b_cmpk("r0", 0xFF44);
    E("beq Lrs_ly");
    b_cmpk("r0", 0xFF41);
    E("beq Lrs_st");
    b_cmpk("r0", 0xFE00);
    E("blo Lrs2");
    b_cmpk("r0", 0xFEA0);
    E("bhs Lrs2");
    E("ldr r3, [r4, #%d]", A32_X_OAMB);
    E("bx lr");
    LB("Lrs_ly");
    E("ldrb ip, [r4, #%d]", A32_X_FROZEN);
    E("cmp ip, #0");
    E("bne Lrs2");
    b_addk("r3", "r4", A32_X_FF44);
    E("sub r3, r3, r0");
    E("bx lr");
    LB("Lrs_st");
    E("ldrb ip, [r4, #%d]", A32_X_FROZEN);
    E("cmp ip, #0");
    E("bne Lrs2");
    b_addk("r3", "r4", A32_X_FF41);
    E("sub r3, r3, r0");
    E("bx lr");
    LB("Lrs2");
    E("push {r0, r1, r2, lr}");
    spoff = 16;
    b_flush();
    E("ldr r0, [sp, #%d]", SL_G + spoff);
    E("ldr r1, [sp]");
    E("bl gbc_read");
    E("strb r0, [r4, #%d]", A32_X_TMP);
    b_reload();
    spoff = 0;
    E("pop {r0, r1, r2, lr}");
    b_addk("r3", "r4", A32_X_TMP);
    E("sub r3, r3, r0");
    E("bx lr");

    /* wr_slow: r0 the address, r3 the value; keeps r0-r2 */
    LB("Lwr_slow");
    E("push {r1, r2}");
    b_cmpk("r0", 0xFF80);
    E("blo Lws1");
    b_cmpk("r0", 0xFFFF);
    E("beq Lws9");
    E("ldr ip, [r4, #%d]", A32_X_HRAMB);
    E("strb r3, [ip, r0]");
    E("pop {r1, r2}");
    E("bx lr");
    LB("Lws1");
    b_cmpk("r0", 0xFE00);
    E("blo Lws2");
    b_cmpk("r0", 0xFEA0);
    E("bhs Lws9");
    E("ldr ip, [r4, #%d]", A32_X_OAMB);
    E("strb r3, [ip, r0]");
    E("pop {r1, r2}");
    E("bx lr");
    LB("Lws2");
    E("and ip, r0, #0xE000");
    E("cmp ip, #0x8000");
    E("beq Lws_v");
    E("cmp ip, #0x2000");
    E("beq Lws_m");
    E("cmp ip, #0xC000");
    E("bne Lws9");
    E("lsr r1, r0, #12");
    E("add r1, r4, r1, lsl #2");
    E("ldr r1, [r1, #%d]", A32_X_WR);
    E("cmp r1, #0");
    E("beq Lws9");
    E("ubfx r2, r0, #0, #13");
    E("ldr ip, [r4, #%d]", A32_X_WATCH);
    E("ldrb ip, [ip, r2]");
    E("cmp ip, #0");
    E("bne Lws9");
    E("strb r3, [r1, r0]");
    E("pop {r1, r2}");
    E("bx lr");
    LB("Lws_v");                          /* video memory (vram_write of gbc_exec.c) */
    E("ldrb ip, [r4, #%d]", A32_X_VFAST);
    E("cmp ip, #0");
    E("beq Lws9");
    E("ldr r1, [r4, #%d]", A32_X_VLO);
    E("ldr r2, [r4, #%d]", A32_X_VMIR_LO);
    b_cmpk("r0", 0x9C00);
    E("blo Lws_v1");
    E("ldr r1, [r4, #%d]", A32_X_VHI);
    E("ldr r2, [r4, #%d]", A32_X_VMIR_HI);
    LB("Lws_v1");
    E("strb r3, [r1, r0]");
    E("cmp r2, #0");
    E("beq Lws_v2");
    E("ldr ip, [r4, #%d]", A32_X_VMIR_A0);
    E("cmp r0, ip");
    E("blo Lws_v2");
    E("ldr ip, [r4, #%d]", A32_X_VMIR_A1);
    E("cmp r0, ip");
    E("bhs Lws_v2");
    E("strb r3, [r2, r0]");
    LB("Lws_v2");
    E("pop {r1, r2}");
    E("bx lr");
    LB("Lws_m");                          /* ROM bank of an MBC5 (mbc5_write) */
    E("ldrb ip, [r4, #%d]", A32_X_MBC5);
    E("cmp ip, #0");
    E("beq Lws9");
    E("ldr r2, [sp, #%d]", SL_G + 8);
    E("ldrh r1, [r2, #%d]", A32_S_ROM_BANK);
    b_cmpk("r0", 0x3000);
    E("bhs Lws_m1");
    E("and r1, r1, #0x100");
    E("and ip, r3, #0xFF");
    E("orr r1, r1, ip");
    E("b Lws_m2");
    LB("Lws_m1");
    E("and r1, r1, #0xFF");
    E("and ip, r3, #1");
    E("orr r1, r1, ip, lsl #8");
    LB("Lws_m2");
    E("strh r1, [r2, #%d]", A32_S_ROM_BANK);
    E("ldr ip, [r2, #%d]", A32_ROM_MASK);
    E("and r1, r1, ip");
    E("ldr ip, [r2, #%d]", A32_ROM);
    E("add ip, ip, r1, lsl #14");
    E("sub ip, ip, #0x4000");
    E("str ip, [r4, #%d]", A32_X_RD + 16);
    E("str ip, [r4, #%d]", A32_X_RD + 20);
    E("str ip, [r4, #%d]", A32_X_RD + 24);
    E("str ip, [r4, #%d]", A32_X_RD + 28);
    E("pop {r1, r2}");
    E("bx lr");
    LB("Lws9");
    E("pop {r1, r2}");
    E("push {r0, r1, r2, r3, ip, lr}");
    spoff = 24;
    b_flush();
    E("ldr r0, [sp, #%d]", SL_G + spoff);
    E("ldr r1, [sp]");
    E("ldrb r2, [sp, #12]");
    E("bl gbc_asm_write");
    b_reload();
    spoff = 0;
    E("pop {r0, r1, r2, r3, ip, lr}");
    E("bx lr");

    for (int t = 4; t <= 8; t += 4) {
        LB("Ltick_slow%d", t);
        E("add r5, r5, #%d", t);
        E("push {r0, r1, r2, lr}");
        spoff = 16;
        b_flush();
        E("ldr r0, [sp, #%d]", SL_G + spoff);
        E("mov r1, #%d", t);
        E("bl gbc_asm_tick");
        b_reload();
        spoff = 0;
        E("pop {r0, r1, r2, lr}");
        E("bx lr");
    }

    /* idle: the wait loop "ld a,[hl] / and a / jr z,-4" with [hl] = 0 (see the x64 version): its
     * next whole iterations before the deadline and the end of the frame, within the budget, at
     * once: 3 steps, 24 cycles each. The cycles left (min(deadline, frame_end) - 1 - cycles) are
     * REM - max(DTH, FTH) - 1 (base-relative events, see above). Called with bl from a fast step:
     * r0-r3, ip free, lr the return. */
    LB("Lidle");
    E("cmp r7, #0");
    E("bxne lr");
    E("cmp r8, #0xA0");
    E("bxne lr");
    E("lsr r0, r6, #16");                 /* PC */
    E("mov r1, r0, lsl #20");
    b_cmpk("r1", 0xFFC00000u);            /* (PC & 0xFFF) <= 0xFFC: the 3 bytes and 1 more in the page */
    E("bxhi lr");
    E("lsr r1, r0, #12");
    E("ldr r1, [r4, r1, lsl #2]");
    E("cmp r1, #0");
    E("bxeq lr");
    E("ldr r1, [r1, r0]");
    b_mov32("r2", 0xFC28A77Eu);
    E("cmp r1, r2");
    E("bxne lr");
    E("ldr r1, [sp, #%d]", SL_HOOKS);
    E("ldr r1, [r1, r0]");
    E("bic r1, r1, #0xFF000000");
    b_mov32("r2", 0x03030303u);
    E("tst r1, r2");                      /* hooks or the stop address on the 3 instructions */
    E("bxne lr");
    E("lsr r1, r11, #12");
    E("ldr r1, [r4, r1, lsl #2]");
    E("cmp r1, #0");
    E("bne Lid_m");
    b_cmpk("r11", 0xFF80);
    E("bxlo lr");
    b_cmpk("r11", 0xFFFF);
    E("bxeq lr");
    E("ldr r1, [r4, #%d]", A32_X_HRAMB);
    LB("Lid_m");
    E("ldrb r1, [r1, r11]");
    E("cmp r1, #0");
    E("bxne lr");
    E("ldr r1, [sp, #%d]", SL_DTH);
    E("ldr r2, [sp, #%d]", SL_FTH);
    E("cmp r1, r2");
    E("movlt r1, r2");
    E("sub r0, r5, r1");
    E("subs r0, r0, #1");                 /* cycles left before the end, minus 1 */
    E("bxle lr");
    b_mov32("r1", 0xAAAAAAABu);           /* / 24: * 0xAAAAAAAB >> 36 */
    E("umull r2, r3, r0, r1");
    E("lsr r0, r3, #4");                  /* whole iterations before the end */
    E("ldr r2, [sp, #%d]", SL_BUD);
    E("cmp r2, #0");
    E("movlt r2, #0");
    E("umull ip, r3, r2, r1");
    E("lsr r3, r3, #1");                  /* budget / 3 */
    E("cmp r0, r3");
    E("movhi r0, r3");
    E("add r1, r0, r0, lsl #1");          /* steps */
    E("ldr r2, [sp, #%d]", SL_BUD);
    E("sub r2, r2, r1");
    E("str r2, [sp, #%d]", SL_BUD);
    E("sub r5, r5, r1, lsl #3");          /* 8 cycles a step */
    E("bx lr");

    /* copy: the copy loop "ld a,[hl+] / ld [de],a / inc de / dec bc / ld a,c / or b / jr nz,-8"
     * (see the x64 version): its next whole iterations (7 steps, 52 cycles) before the deadline,
     * the end of the frame, within the budget, but the last one, byte by byte while both bytes are
     * in the tables; then A = C | B, F = 0 */
    LB("Lcopy");
    E("lsr r0, r6, #16");
    E("cmp r0, #0x8000");
    E("bxhs lr");
    E("mov r1, r0, lsl #20");
    b_cmpk("r1", 0xFF800000u);            /* (PC & 0xFFF) <= 0xFF8 */
    E("bxhi lr");
    E("lsr r1, r0, #12");
    E("ldr r1, [r4, r1, lsl #2]");
    E("cmp r1, #0");
    E("bxeq lr");
    E("add r1, r1, r0");
    E("ldr r2, [r1]");
    b_mov32("r3", 0x0B13122Au);
    E("cmp r2, r3");
    E("bxne lr");
    E("ldr r2, [r1, #4]");
    b_mov32("r3", 0xF820B079u);
    E("cmp r2, r3");
    E("bxne lr");
    E("ldr r1, [sp, #%d]", SL_HOOKS);
    E("add r1, r1, r0");
    E("ldr r2, [r1]");
    b_mov32("r3", 0x03030303u);
    E("tst r2, r3");                      /* hooks or the stop address on the 7 instructions */
    E("bxne lr");
    E("ldr r2, [r1, #4]");
    b_mov32("r3", 0x00030303u);
    E("tst r2, r3");
    E("bxne lr");
    E("ldr r1, [sp, #%d]", SL_DTH);
    E("ldr r2, [sp, #%d]", SL_FTH);
    E("cmp r1, r2");
    E("movlt r1, r2");
    E("sub r0, r5, r1");
    E("subs r0, r0, #1");
    E("bxle lr");
    E("push {r4, lr}");
    b_mov32("r1", 0x4EC4EC4Fu);           /* / 52: * 0x4EC4EC4F >> 36 (exact below 2^31) */
    E("umull r2, r3, r0, r1");
    E("lsr r3, r3, #4");                  /* iterations before the end */
    E("ldr r2, [sp, #%d]", SL_BUD + 8);
    E("cmp r2, #0");
    E("movlt r2, #0");
    b_mov32("r1", 0x92492493u);           /* / 7: * 0x92492493 >> 34 (exact below 2^31) */
    E("umull ip, lr, r2, r1");
    E("lsr lr, lr, #2");
    E("cmp lr, r3");
    E("movlo r3, lr");                    /* within the budget */
    E("sub r2, r9, #1");
    E("uxth r2, r2");
    E("cmp r2, r3");
    E("movlo r3, r2");                    /* but the last one */
    E("mov lr, #0");
    LB("Lcp_loop");
    E("cmp lr, r3");
    E("bhs Lcp_end");
    E("lsr r0, r11, #12");
    E("ldr r0, [r4, r0, lsl #2]");
    E("cmp r0, #0");
    E("beq Lcp_end");
    E("ldrb r1, [r0, r11]");
    E("lsr r0, r10, #8");
    E("add r0, r4, r0, lsl #2");
    E("ldr r0, [r0, #%d]", A32_X_WRF);
    E("cmp r0, #0");
    E("beq Lcp_end");
    E("strb r1, [r0, r10]");
    E("add r11, r11, #1");
    E("uxth r11, r11");
    E("add r10, r10, #1");
    E("uxth r10, r10");
    E("sub r9, r9, #1");
    E("uxth r9, r9");
    E("add lr, lr, #1");
    E("b Lcp_loop");
    LB("Lcp_end");
    E("cmp lr, #0");
    E("beq Lcp_ret");
    E("orr r7, r9, r9, lsr #8");
    E("and r7, r7, #0xFF");               /* A = C | B, F = 0 */
    E("mov r8, #0");
    E("rsb r0, lr, lr, lsl #3");          /* 7 steps each */
    E("ldr r2, [sp, #%d]", SL_BUD + 8);
    E("sub r2, r2, r0");
    E("str r2, [sp, #%d]", SL_BUD + 8);
    E("mov r1, #52");
    E("mls r5, lr, r1, r5");              /* 52 cycles each */
    LB("Lcp_ret");
    E("pop {r4, pc}");

    /* before a step, when the cycle counter reached the limit or a byte of the hooks is set: the
     * checks of gbc_exec_c in its order */
    LB("Lslow_top");
    E("ldr ip, [sp, #%d]", SL_FTH);
    E("cmp r5, ip");
    E("ble Lexit_done");
    E("ldrb ip, [r4, #%d]", A32_X_SPECIAL);
    E("cmp ip, #0");
    E("bne Lexit_more");
    E("ldr ip, [sp, #%d]", SL_HOOKS);
    E("ldrb ip, [ip, r6, lsr #16]");
    E("tst ip, #1");
    E("bne Lexit_more");
    E("ldr ip, [r4, #%d]", A32_X_STOP_PC);
    E("cmp ip, r6, lsr #16");
    E("bne Lst1");
    E("ldr ip, [r4, #%d]", A32_X_STOP_SP);
    E("uxth lr, r6");
    E("cmp lr, ip");
    E("beq Lexit_done");
    LB("Lst1");
    E("ldr ip, [sp, #%d]", SL_BUD);
    E("subs ip, ip, #1");
    E("str ip, [sp, #%d]", SL_BUD);
    E("bmi Lexit_budget");
    E("ldr ip, [sp, #%d]", SL_D24TH);
    E("cmp r5, ip");
    E("bgt Lfast_fetch");
    LB("Lcareful_fetch");
    careful = 1; wrote = 0;
    tick(4);
    fetch_dispatch("Ljt_c");
    careful = 0;
    flush_stubs();

    LB("Lnext");
    E("cmp r5, #0");
    E("ble Lslow_top");
    E("ldr ip, [sp, #%d]", SL_HOOKS);
    E("ldrb ip, [ip, r6, lsr #16]");
    E("cmp ip, #0");
    E("bne Lslow_top");
    E("ldr ip, [sp, #%d]", SL_BUD);
    E("subs ip, ip, #1");
    E("str ip, [sp, #%d]", SL_BUD);
    E("bmi Lexit_budget");
    LB("Lfast_fetch");
    E("sub r5, r5, #4");
    fetch_dispatch("Ljt_f");
    flush_stubs();

    static const char *ex[] = { "Lexit_budget", "Lexit_done", "Lexit_more" };
    static const int code[] = { 0, 1, 3 };
    for (int i = 0; i < 3; i++) {
        LB("%s", ex[i]);
        b_flush();
        E("mov r0, #%d", code[i]);
        E("b Lepilogue");
    }
    LB("Lepilogue");
    /* *budget -= the steps counted here */
    E("ldr r1, [sp, #%d]", SL_BUDP);
    E("ldr r2, [r1]");
    E("ldr r3, [r1, #4]");
    E("ldr ip, [sp, #%d]", SL_BUD0);
    E("ldr lr, [sp, #%d]", SL_BUD);
    E("sub ip, ip, lr");
    E("subs r2, r2, ip");
    E("sbc r3, r3, ip, asr #31");
    E("str r2, [r1]");
    E("str r3, [r1, #4]");
    E("add sp, sp, #%d", A32_FRAME);
    E("pop {r4-r11, pc}");
}

static void b_prologue(void)
{
    E("push {r4-r11, lr}");
    E("sub sp, sp, #%d", A32_FRAME);
    E("str r0, [sp, #%d]", SL_G);
    b_mov32("ip", A32_FAST);
    E("add r4, r0, ip");
    E("ldr ip, [r4, #%d]", A32_X_HOOKS);
    E("str ip, [sp, #%d]", SL_HOOKS);
    E("str r1, [sp, #%d]", SL_BUDP);
    /* the budget, clamped to 32 bits (a negative one: -1, it ends at the first step) */
    E("ldr r2, [r1]");
    E("ldr r3, [r1, #4]");
    E("cmp r3, #0");
    E("mvnlt r2, #0");
    E("blt Lpro1");
    E("mvnne r2, #0x80000000");
    E("cmp r2, #0");
    E("mvnlt r2, #0x80000000");
    LB("Lpro1");
    E("str r2, [sp, #%d]", SL_BUD);
    E("str r2, [sp, #%d]", SL_BUD0);
    /* the tables of handlers (position-independent) */
    static const char *t[] = { "f", "c", "fcb", "ccb" };
    static const int sl[] = { SL_JTF, SL_JTC, SL_JTFCB, SL_JTCCB };
    for (int i = 0; i < 4; i++) {
        E("ldr ip, Lpt_%s", t[i]);
        LB("Lpp_%s", t[i]);
        E("add ip, pc, ip");
        E("str ip, [sp, #%d]", sl[i]);
    }
    spoff = 0;
    b_reload();
    E("b Lnext");
    for (int i = 0; i < 4; i++) {
        LB("Lpt_%s", t[i]);
        E(".word Ljt_%s - (Lpp_%s + 8)", t[i], t[i]);
    }
}
