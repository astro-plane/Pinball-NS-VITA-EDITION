// cpu_a32.S - the fast interpreter of the SM83 for 32-bit ARM (PS Vita, Cortex-A9, ARM state),
// written by tools/gencpu.c from its description of the instructions: do not edit, see that
// file (and gencpu_a32.inc). int gbc_cpu_run(GBC *g, int64_t *budget): see gbc_exec_asm.

    .syntax unified
    .arch armv7-a
    .arm
    .text
    .p2align 4
    .globl gbc_cpu_run
    .hidden gbc_cpu_run
    .type gbc_cpu_run, %function
gbc_cpu_run:
    push {r4-r11, lr}
    sub sp, sp, #68
    str r0, [sp, #0]
    movw ip, #47488
    movt ip, #8
    add r4, r0, ip
    ldr ip, [r4, #144]
    str ip, [sp, #4]
    str r1, [sp, #24]
    ldr r2, [r1]
    ldr r3, [r1, #4]
    cmp r3, #0
    mvnlt r2, #0
    blt Lpro1
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
Lpro1:
    str r2, [sp, #28]
    str r2, [sp, #32]
    ldr ip, Lpt_f
Lpp_f:
    add ip, pc, ip
    str ip, [sp, #8]
    ldr ip, Lpt_c
Lpp_c:
    add ip, pc, ip
    str ip, [sp, #12]
    ldr ip, Lpt_fcb
Lpp_fcb:
    add ip, pc, ip
    str ip, [sp, #16]
    ldr ip, Lpt_ccb
Lpp_ccb:
    add ip, pc, ip
    str ip, [sp, #20]
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L1
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L1:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L3
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L3:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L4
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L4:
    sub r2, r5, r2
    str r2, [sp, #56]
    b Lnext
Lpt_f:
    .word Ljt_f - (Lpp_f + 8)
Lpt_c:
    .word Ljt_c - (Lpp_c + 8)
Lpt_fcb:
    .word Ljt_fcb - (Lpp_fcb + 8)
Lpt_ccb:
    .word Ljt_ccb - (Lpp_ccb + 8)
Lrd_slow:
    movw ip, #65408
    cmp r0, ip
    blo Lrs1
    movw ip, #65535
    cmp r0, ip
    beq Lrs2
    ldr r3, [r4, #136]
    bx lr
Lrs1:
    movw ip, #65348
    cmp r0, ip
    beq Lrs_ly
    movw ip, #65345
    cmp r0, ip
    beq Lrs_st
    cmp r0, #65024
    blo Lrs2
    movw ip, #65184
    cmp r0, ip
    bhs Lrs2
    ldr r3, [r4, #132]
    bx lr
Lrs_ly:
    ldrb ip, [r4, #211]
    cmp ip, #0
    bne Lrs2
    add r3, r4, #217
    sub r3, r3, r0
    bx lr
Lrs_st:
    ldrb ip, [r4, #211]
    cmp ip, #0
    bne Lrs2
    add r3, r4, #216
    sub r3, r3, r0
    bx lr
Lrs2:
    push {r0, r1, r2, lr}
    ldr ip, [sp, #16]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L5
    ldr r3, [sp, #60]
    sub r3, r3, r5
    ldr lr, [sp, #52]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #56]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L5:
    ldr r0, [sp, #16]
    ldr r1, [sp]
    bl gbc_read
    strb r0, [r4, #212]
    ldr ip, [sp, #16]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #52]
    str r1, [sp, #56]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L6
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L6:
    str r2, [sp, #60]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L7
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L7:
    sub r2, r5, r2
    str r2, [sp, #64]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L8
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L8:
    sub r2, r5, r2
    str r2, [sp, #68]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L9
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L9:
    sub r2, r5, r2
    str r2, [sp, #72]
    pop {r0, r1, r2, lr}
    add r3, r4, #212
    sub r3, r3, r0
    bx lr
Lwr_slow:
    push {r1, r2}
    movw ip, #65408
    cmp r0, ip
    blo Lws1
    movw ip, #65535
    cmp r0, ip
    beq Lws9
    ldr ip, [r4, #136]
    strb r3, [ip, r0]
    pop {r1, r2}
    bx lr
Lws1:
    cmp r0, #65024
    blo Lws2
    movw ip, #65184
    cmp r0, ip
    bhs Lws9
    ldr ip, [r4, #132]
    strb r3, [ip, r0]
    pop {r1, r2}
    bx lr
Lws2:
    and ip, r0, #0xE000
    cmp ip, #0x8000
    beq Lws_v
    cmp ip, #0x2000
    beq Lws_m
    cmp ip, #0xC000
    bne Lws9
    lsr r1, r0, #12
    add r1, r4, r1, lsl #2
    ldr r1, [r1, #64]
    cmp r1, #0
    beq Lws9
    ubfx r2, r0, #0, #13
    ldr ip, [r4, #140]
    ldrb ip, [ip, r2]
    cmp ip, #0
    bne Lws9
    strb r3, [r1, r0]
    pop {r1, r2}
    bx lr
Lws_v:
    ldrb ip, [r4, #214]
    cmp ip, #0
    beq Lws9
    ldr r1, [r4, #184]
    ldr r2, [r4, #192]
    cmp r0, #39936
    blo Lws_v1
    ldr r1, [r4, #188]
    ldr r2, [r4, #196]
Lws_v1:
    strb r3, [r1, r0]
    cmp r2, #0
    beq Lws_v2
    ldr ip, [r4, #200]
    cmp r0, ip
    blo Lws_v2
    ldr ip, [r4, #204]
    cmp r0, ip
    bhs Lws_v2
    strb r3, [r2, r0]
Lws_v2:
    pop {r1, r2}
    bx lr
Lws_m:
    ldrb ip, [r4, #215]
    cmp ip, #0
    beq Lws9
    ldr r2, [sp, #8]
    ldrh r1, [r2, #40]
    cmp r0, #12288
    bhs Lws_m1
    and r1, r1, #0x100
    and ip, r3, #0xFF
    orr r1, r1, ip
    b Lws_m2
Lws_m1:
    and r1, r1, #0xFF
    and ip, r3, #1
    orr r1, r1, ip, lsl #8
Lws_m2:
    strh r1, [r2, #40]
    ldr ip, [r2, #12]
    and r1, r1, ip
    ldr ip, [r2, #0]
    add ip, ip, r1, lsl #14
    sub ip, ip, #0x4000
    str ip, [r4, #16]
    str ip, [r4, #20]
    str ip, [r4, #24]
    str ip, [r4, #28]
    pop {r1, r2}
    bx lr
Lws9:
    pop {r1, r2}
    push {r0, r1, r2, r3, ip, lr}
    ldr ip, [sp, #24]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L10
    ldr r3, [sp, #68]
    sub r3, r3, r5
    ldr lr, [sp, #60]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #64]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L10:
    ldr r0, [sp, #24]
    ldr r1, [sp]
    ldrb r2, [sp, #12]
    bl gbc_asm_write
    ldr ip, [sp, #24]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #60]
    str r1, [sp, #64]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L11
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L11:
    str r2, [sp, #68]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L12
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L12:
    sub r2, r5, r2
    str r2, [sp, #72]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L13
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L13:
    sub r2, r5, r2
    str r2, [sp, #76]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L14
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L14:
    sub r2, r5, r2
    str r2, [sp, #80]
    pop {r0, r1, r2, r3, ip, lr}
    bx lr
Ltick_slow4:
    add r5, r5, #4
    push {r0, r1, r2, lr}
    ldr ip, [sp, #16]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L15
    ldr r3, [sp, #60]
    sub r3, r3, r5
    ldr lr, [sp, #52]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #56]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L15:
    ldr r0, [sp, #16]
    mov r1, #4
    bl gbc_asm_tick
    ldr ip, [sp, #16]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #52]
    str r1, [sp, #56]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L16
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L16:
    str r2, [sp, #60]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L17
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L17:
    sub r2, r5, r2
    str r2, [sp, #64]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L18
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L18:
    sub r2, r5, r2
    str r2, [sp, #68]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L19
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L19:
    sub r2, r5, r2
    str r2, [sp, #72]
    pop {r0, r1, r2, lr}
    bx lr
Ltick_slow8:
    add r5, r5, #8
    push {r0, r1, r2, lr}
    ldr ip, [sp, #16]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L20
    ldr r3, [sp, #60]
    sub r3, r3, r5
    ldr lr, [sp, #52]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #56]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L20:
    ldr r0, [sp, #16]
    mov r1, #8
    bl gbc_asm_tick
    ldr ip, [sp, #16]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #52]
    str r1, [sp, #56]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L21
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L21:
    str r2, [sp, #60]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L22
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L22:
    sub r2, r5, r2
    str r2, [sp, #64]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L23
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L23:
    sub r2, r5, r2
    str r2, [sp, #68]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L24
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L24:
    sub r2, r5, r2
    str r2, [sp, #72]
    pop {r0, r1, r2, lr}
    bx lr
Lidle:
    cmp r7, #0
    bxne lr
    cmp r8, #0xA0
    bxne lr
    lsr r0, r6, #16
    mov r1, r0, lsl #20
    movw ip, #0
    movt ip, #65472
    cmp r1, ip
    bxhi lr
    lsr r1, r0, #12
    ldr r1, [r4, r1, lsl #2]
    cmp r1, #0
    bxeq lr
    ldr r1, [r1, r0]
    movw r2, #42878
    movt r2, #64552
    cmp r1, r2
    bxne lr
    ldr r1, [sp, #4]
    ldr r1, [r1, r0]
    bic r1, r1, #0xFF000000
    movw r2, #771
    movt r2, #771
    tst r1, r2
    bxne lr
    lsr r1, r11, #12
    ldr r1, [r4, r1, lsl #2]
    cmp r1, #0
    bne Lid_m
    movw ip, #65408
    cmp r11, ip
    bxlo lr
    movw ip, #65535
    cmp r11, ip
    bxeq lr
    ldr r1, [r4, #136]
Lid_m:
    ldrb r1, [r1, r11]
    cmp r1, #0
    bxne lr
    ldr r1, [sp, #48]
    ldr r2, [sp, #52]
    cmp r1, r2
    movlt r1, r2
    sub r0, r5, r1
    subs r0, r0, #1
    bxle lr
    movw r1, #43691
    movt r1, #43690
    umull r2, r3, r0, r1
    lsr r0, r3, #4
    ldr r2, [sp, #28]
    cmp r2, #0
    movlt r2, #0
    umull ip, r3, r2, r1
    lsr r3, r3, #1
    cmp r0, r3
    movhi r0, r3
    add r1, r0, r0, lsl #1
    ldr r2, [sp, #28]
    sub r2, r2, r1
    str r2, [sp, #28]
    sub r5, r5, r1, lsl #3
    bx lr
Lcopy:
    lsr r0, r6, #16
    cmp r0, #0x8000
    bxhs lr
    mov r1, r0, lsl #20
    movw ip, #0
    movt ip, #65408
    cmp r1, ip
    bxhi lr
    lsr r1, r0, #12
    ldr r1, [r4, r1, lsl #2]
    cmp r1, #0
    bxeq lr
    add r1, r1, r0
    ldr r2, [r1]
    movw r3, #4650
    movt r3, #2835
    cmp r2, r3
    bxne lr
    ldr r2, [r1, #4]
    movw r3, #45177
    movt r3, #63520
    cmp r2, r3
    bxne lr
    ldr r1, [sp, #4]
    add r1, r1, r0
    ldr r2, [r1]
    movw r3, #771
    movt r3, #771
    tst r2, r3
    bxne lr
    ldr r2, [r1, #4]
    movw r3, #771
    movt r3, #3
    tst r2, r3
    bxne lr
    ldr r1, [sp, #48]
    ldr r2, [sp, #52]
    cmp r1, r2
    movlt r1, r2
    sub r0, r5, r1
    subs r0, r0, #1
    bxle lr
    push {r4, lr}
    movw r1, #60495
    movt r1, #20164
    umull r2, r3, r0, r1
    lsr r3, r3, #4
    ldr r2, [sp, #36]
    cmp r2, #0
    movlt r2, #0
    movw r1, #9363
    movt r1, #37449
    umull ip, lr, r2, r1
    lsr lr, lr, #2
    cmp lr, r3
    movlo r3, lr
    sub r2, r9, #1
    uxth r2, r2
    cmp r2, r3
    movlo r3, r2
    mov lr, #0
Lcp_loop:
    cmp lr, r3
    bhs Lcp_end
    lsr r0, r11, #12
    ldr r0, [r4, r0, lsl #2]
    cmp r0, #0
    beq Lcp_end
    ldrb r1, [r0, r11]
    lsr r0, r10, #8
    add r0, r4, r0, lsl #2
    ldr r0, [r0, #1784]
    cmp r0, #0
    beq Lcp_end
    strb r1, [r0, r10]
    add r11, r11, #1
    uxth r11, r11
    add r10, r10, #1
    uxth r10, r10
    sub r9, r9, #1
    uxth r9, r9
    add lr, lr, #1
    b Lcp_loop
Lcp_end:
    cmp lr, #0
    beq Lcp_ret
    orr r7, r9, r9, lsr #8
    and r7, r7, #0xFF
    mov r8, #0
    rsb r0, lr, lr, lsl #3
    ldr r2, [sp, #36]
    sub r2, r2, r0
    str r2, [sp, #36]
    mov r1, #52
    mls r5, lr, r1, r5
Lcp_ret:
    pop {r4, pc}
Lslow_top:
    ldr ip, [sp, #52]
    cmp r5, ip
    ble Lexit_done
    ldrb ip, [r4, #210]
    cmp ip, #0
    bne Lexit_more
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    tst ip, #1
    bne Lexit_more
    ldr ip, [r4, #224]
    cmp ip, r6, lsr #16
    bne Lst1
    ldr ip, [r4, #228]
    uxth lr, r6
    cmp lr, ip
    beq Lexit_done
Lst1:
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    ldr ip, [sp, #56]
    cmp r5, ip
    bgt Lfast_fetch
Lcareful_fetch:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L25
L26:
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L27
L28:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #12]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L25:
    bl Ltick_slow4
    b L26
L27:
    lsr r0, r6, #16
    bl Lrd_slow
    b L28
Lnext:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
Lfast_fetch:
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L29
L30:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L29:
    lsr r0, r6, #16
    bl Lrd_slow
    b L30
Lexit_budget:
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L31
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L31:
    mov r0, #0
    b Lepilogue
Lexit_done:
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L32
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L32:
    mov r0, #1
    b Lepilogue
Lexit_more:
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L33
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L33:
    mov r0, #3
    b Lepilogue
Lepilogue:
    ldr r1, [sp, #24]
    ldr r2, [r1]
    ldr r3, [r1, #4]
    ldr ip, [sp, #32]
    ldr lr, [sp, #28]
    sub ip, ip, lr
    subs r2, r2, ip
    sbc r3, r3, ip, asr #31
    str r2, [r1]
    str r3, [r1, #4]
    add sp, sp, #68
    pop {r4-r11, pc}
    .p2align 4
Lf_00:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L34
L35:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L34:
    lsr r0, r6, #16
    bl Lrd_slow
    b L35
    .p2align 4
Lf_01:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L36
L37:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L38
L39:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r9, r2
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L40
L41:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L36:
    bl Lrd_slow
    b L37
L38:
    bl Lrd_slow
    b L39
L40:
    lsr r0, r6, #16
    bl Lrd_slow
    b L41
    .p2align 4
Lf_02:
    mov r0, r9
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L42
    strb r7, [ip, r0]
L43:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L44
L45:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L42:
    mov r3, r7
    bl Lwr_slow
    b L43
L44:
    lsr r0, r6, #16
    bl Lrd_slow
    b L45
    .p2align 4
Lf_03:
    add r9, r9, #1
    uxth r9, r9
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L46
L47:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L46:
    lsr r0, r6, #16
    bl Lrd_slow
    b L47
    .p2align 4
Lf_04:
    lsr r3, r9, #8
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L48
L49:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L48:
    lsr r0, r6, #16
    bl Lrd_slow
    b L49
    .p2align 4
Lf_05:
    lsr r3, r9, #8
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L50
L51:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L50:
    lsr r0, r6, #16
    bl Lrd_slow
    b L51
    .p2align 4
Lf_06:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L52
L53:
    ldrb ip, [r3, r0]
    bfi r9, ip, #8, #8
    add r6, r6, #0x10000
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L54
L55:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L52:
    bl Lrd_slow
    b L53
L54:
    lsr r0, r6, #16
    bl Lrd_slow
    b L55
    .p2align 4
Lf_07:
    lsr r3, r7, #7
    lsl r7, r7, #1
    orr r7, r7, r3
    and r7, r7, #0xFF
    lsl r8, r3, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L56
L57:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L56:
    lsr r0, r6, #16
    bl Lrd_slow
    b L57
    .p2align 4
Lf_08:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L58
L59:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L60
L61:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r0, r2
    uxtb r1, r6
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L62
    strb r1, [ip, r0]
L63:
    add r0, r2, #1
    uxth r0, r0
    ubfx r1, r6, #8, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L64
L65:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L66
    strb r1, [ip, r0]
L67:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L68
L69:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L58:
    bl Lrd_slow
    b L59
L60:
    bl Lrd_slow
    b L61
L62:
    mov r3, r1
    bl Lwr_slow
    b L63
L64:
    bl Ltick_slow4
    b L65
L66:
    mov r3, r1
    bl Lwr_slow
    b L67
L68:
    lsr r0, r6, #16
    bl Lrd_slow
    b L69
    .p2align 4
Lf_09:
    add ip, r11, r9
    eor lr, r11, r9
    eor lr, lr, ip
    and r8, r8, #0x80
    tst lr, #0x1000
    orrne r8, r8, #0x20
    tst lr, #0x10000
    orrne r8, r8, #0x10
    uxth r11, ip
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L70
L71:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L70:
    lsr r0, r6, #16
    bl Lrd_slow
    b L71
    .p2align 4
Lf_0A:
    mov r0, r9
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L72
L73:
    ldrb r7, [r3, r0]
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L74
L75:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L72:
    bl Lrd_slow
    b L73
L74:
    lsr r0, r6, #16
    bl Lrd_slow
    b L75
    .p2align 4
Lf_0B:
    sub r9, r9, #1
    uxth r9, r9
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L76
L77:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L76:
    lsr r0, r6, #16
    bl Lrd_slow
    b L77
    .p2align 4
Lf_0C:
    uxtb r3, r9
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L78
L79:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L78:
    lsr r0, r6, #16
    bl Lrd_slow
    b L79
    .p2align 4
Lf_0D:
    uxtb r3, r9
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L80
L81:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L80:
    lsr r0, r6, #16
    bl Lrd_slow
    b L81
    .p2align 4
Lf_0E:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L82
L83:
    ldrb ip, [r3, r0]
    bfi r9, ip, #0, #8
    add r6, r6, #0x10000
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L84
L85:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L82:
    bl Lrd_slow
    b L83
L84:
    lsr r0, r6, #16
    bl Lrd_slow
    b L85
    .p2align 4
Lf_0F:
    and r3, r7, #1
    lsr r7, r7, #1
    orr r7, r7, r3, lsl #7
    lsl r8, r3, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L86
L87:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L86:
    lsr r0, r6, #16
    bl Lrd_slow
    b L87
    .p2align 4
Lf_10:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L88
L89:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L90
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L90:
    ldr r0, [sp, #0]
    mov r1, #16
    bl gbc_asm_op
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L91
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L91:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L92
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L92:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L93
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L93:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L94
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L94:
    sub r2, r5, r2
    str r2, [sp, #56]
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L95
L96:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L88:
    bl Lrd_slow
    b L89
L95:
    lsr r0, r6, #16
    bl Lrd_slow
    b L96
    .p2align 4
Lf_11:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L97
L98:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L99
L100:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r10, r2
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L101
L102:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L97:
    bl Lrd_slow
    b L98
L99:
    bl Lrd_slow
    b L100
L101:
    lsr r0, r6, #16
    bl Lrd_slow
    b L102
    .p2align 4
Lf_12:
    mov r0, r10
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L103
    strb r7, [ip, r0]
L104:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L105
L106:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L103:
    mov r3, r7
    bl Lwr_slow
    b L104
L105:
    lsr r0, r6, #16
    bl Lrd_slow
    b L106
    .p2align 4
Lf_13:
    add r10, r10, #1
    uxth r10, r10
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L107
L108:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L107:
    lsr r0, r6, #16
    bl Lrd_slow
    b L108
    .p2align 4
Lf_14:
    lsr r3, r10, #8
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L109
L110:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L109:
    lsr r0, r6, #16
    bl Lrd_slow
    b L110
    .p2align 4
Lf_15:
    lsr r3, r10, #8
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L111
L112:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L111:
    lsr r0, r6, #16
    bl Lrd_slow
    b L112
    .p2align 4
Lf_16:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L113
L114:
    ldrb ip, [r3, r0]
    bfi r10, ip, #8, #8
    add r6, r6, #0x10000
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L115
L116:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L113:
    bl Lrd_slow
    b L114
L115:
    lsr r0, r6, #16
    bl Lrd_slow
    b L116
    .p2align 4
Lf_17:
    lsr r3, r7, #7
    lsl r7, r7, #1
    tst r8, #0x10
    orrne r7, r7, #1
    and r7, r7, #0xFF
    lsl r8, r3, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L117
L118:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L117:
    lsr r0, r6, #16
    bl Lrd_slow
    b L118
    .p2align 4
Lf_18:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L119
L120:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    sxtb ip, r1
    add r6, r6, ip, lsl #16
    sub r5, r5, #4
L121:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L122
L123:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L119:
    bl Lrd_slow
    b L120
L122:
    lsr r0, r6, #16
    bl Lrd_slow
    b L123
    .p2align 4
Lf_19:
    add ip, r11, r10
    eor lr, r11, r10
    eor lr, lr, ip
    and r8, r8, #0x80
    tst lr, #0x1000
    orrne r8, r8, #0x20
    tst lr, #0x10000
    orrne r8, r8, #0x10
    uxth r11, ip
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L124
L125:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L124:
    lsr r0, r6, #16
    bl Lrd_slow
    b L125
    .p2align 4
Lf_1A:
    mov r0, r10
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L126
L127:
    ldrb r7, [r3, r0]
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L128
L129:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L126:
    bl Lrd_slow
    b L127
L128:
    lsr r0, r6, #16
    bl Lrd_slow
    b L129
    .p2align 4
Lf_1B:
    sub r10, r10, #1
    uxth r10, r10
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L130
L131:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L130:
    lsr r0, r6, #16
    bl Lrd_slow
    b L131
    .p2align 4
Lf_1C:
    uxtb r3, r10
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L132
L133:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L132:
    lsr r0, r6, #16
    bl Lrd_slow
    b L133
    .p2align 4
Lf_1D:
    uxtb r3, r10
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L134
L135:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L134:
    lsr r0, r6, #16
    bl Lrd_slow
    b L135
    .p2align 4
Lf_1E:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L136
L137:
    ldrb ip, [r3, r0]
    bfi r10, ip, #0, #8
    add r6, r6, #0x10000
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L138
L139:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L136:
    bl Lrd_slow
    b L137
L138:
    lsr r0, r6, #16
    bl Lrd_slow
    b L139
    .p2align 4
Lf_1F:
    and r3, r7, #1
    lsr r7, r7, #1
    tst r8, #0x10
    orrne r7, r7, #0x80
    lsl r8, r3, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L140
L141:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L140:
    lsr r0, r6, #16
    bl Lrd_slow
    b L141
    .p2align 4
Lf_20:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L142
L143:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    tst r8, #128
    bne L144
    sxtb ip, r1
    add r6, r6, ip, lsl #16
    sub r5, r5, #4
    cmn r1, #248
    beq L145
L146:
L144:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L147
L148:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L142:
    bl Lrd_slow
    b L143
L145:
    bl Lcopy
    b L146
L147:
    lsr r0, r6, #16
    bl Lrd_slow
    b L148
    .p2align 4
Lf_21:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L149
L150:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L151
L152:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r11, r2
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L153
L154:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L149:
    bl Lrd_slow
    b L150
L151:
    bl Lrd_slow
    b L152
L153:
    lsr r0, r6, #16
    bl Lrd_slow
    b L154
    .p2align 4
Lf_22:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L155
    strb r7, [ip, r0]
L156:
    add r11, r0, #1
    uxth r11, r11
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L157
L158:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L155:
    mov r3, r7
    bl Lwr_slow
    b L156
L157:
    lsr r0, r6, #16
    bl Lrd_slow
    b L158
    .p2align 4
Lf_23:
    add r11, r11, #1
    uxth r11, r11
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L159
L160:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L159:
    lsr r0, r6, #16
    bl Lrd_slow
    b L160
    .p2align 4
Lf_24:
    lsr r3, r11, #8
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L161
L162:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L161:
    lsr r0, r6, #16
    bl Lrd_slow
    b L162
    .p2align 4
Lf_25:
    lsr r3, r11, #8
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L163
L164:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L163:
    lsr r0, r6, #16
    bl Lrd_slow
    b L164
    .p2align 4
Lf_26:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L165
L166:
    ldrb ip, [r3, r0]
    bfi r11, ip, #8, #8
    add r6, r6, #0x10000
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L167
L168:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L165:
    bl Lrd_slow
    b L166
L167:
    lsr r0, r6, #16
    bl Lrd_slow
    b L168
    .p2align 4
Lf_27:
    mov r3, r7
    ubfx ip, r8, #4, #1
    tst r8, #0x40
    beq L169
    tst r8, #0x20
    beq L170
    sub r3, r3, #6
L170:
    cmp ip, #0
    beq L174
    sub r3, r3, #0x60
    b L174
L169:
    cmp ip, #0
    bne L171
    cmp r3, #0x99
    bls L172
L171:
    add r3, r3, #0x60
    mov ip, #1
L172:
    tst r8, #0x20
    bne L173
    and lr, r3, #0xF
    cmp lr, #9
    bls L174
L173:
    add r3, r3, #6
L174:
    and r7, r3, #0xFF
    and r8, r8, #0x40
    orr r8, r8, ip, lsl #4
    cmp r7, #0
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L175
L176:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L175:
    lsr r0, r6, #16
    bl Lrd_slow
    b L176
    .p2align 4
Lf_28:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L177
L178:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    tst r8, #128
    beq L179
    sxtb ip, r1
    add r6, r6, ip, lsl #16
    sub r5, r5, #4
    cmn r1, #252
    beq L180
L181:
L179:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L182
L183:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L177:
    bl Lrd_slow
    b L178
L180:
    bl Lidle
    b L181
L182:
    lsr r0, r6, #16
    bl Lrd_slow
    b L183
    .p2align 4
Lf_29:
    add ip, r11, r11
    eor lr, r11, r11
    eor lr, lr, ip
    and r8, r8, #0x80
    tst lr, #0x1000
    orrne r8, r8, #0x20
    tst lr, #0x10000
    orrne r8, r8, #0x10
    uxth r11, ip
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L184
L185:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L184:
    lsr r0, r6, #16
    bl Lrd_slow
    b L185
    .p2align 4
Lf_2A:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L186
L187:
    ldrb r7, [r3, r0]
    add r11, r0, #1
    uxth r11, r11
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L188
L189:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L186:
    bl Lrd_slow
    b L187
L188:
    lsr r0, r6, #16
    bl Lrd_slow
    b L189
    .p2align 4
Lf_2B:
    sub r11, r11, #1
    uxth r11, r11
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L190
L191:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L190:
    lsr r0, r6, #16
    bl Lrd_slow
    b L191
    .p2align 4
Lf_2C:
    uxtb r3, r11
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L192
L193:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L192:
    lsr r0, r6, #16
    bl Lrd_slow
    b L193
    .p2align 4
Lf_2D:
    uxtb r3, r11
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L194
L195:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L194:
    lsr r0, r6, #16
    bl Lrd_slow
    b L195
    .p2align 4
Lf_2E:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L196
L197:
    ldrb ip, [r3, r0]
    bfi r11, ip, #0, #8
    add r6, r6, #0x10000
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L198
L199:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L196:
    bl Lrd_slow
    b L197
L198:
    lsr r0, r6, #16
    bl Lrd_slow
    b L199
    .p2align 4
Lf_2F:
    eor r7, r7, #0xFF
    orr r8, r8, #0x60
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L200
L201:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L200:
    lsr r0, r6, #16
    bl Lrd_slow
    b L201
    .p2align 4
Lf_30:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L202
L203:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    tst r8, #16
    bne L204
    sxtb ip, r1
    add r6, r6, ip, lsl #16
    sub r5, r5, #4
L204:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L205
L206:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L202:
    bl Lrd_slow
    b L203
L205:
    lsr r0, r6, #16
    bl Lrd_slow
    b L206
    .p2align 4
Lf_31:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L207
L208:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L209
L210:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    pkhbt r6, r2, r6
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L211
L212:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L207:
    bl Lrd_slow
    b L208
L209:
    bl Lrd_slow
    b L210
L211:
    lsr r0, r6, #16
    bl Lrd_slow
    b L212
    .p2align 4
Lf_32:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L213
    strb r7, [ip, r0]
L214:
    sub r11, r0, #1
    uxth r11, r11
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L215
L216:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L213:
    mov r3, r7
    bl Lwr_slow
    b L214
L215:
    lsr r0, r6, #16
    bl Lrd_slow
    b L216
    .p2align 4
Lf_33:
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L217
L218:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L217:
    lsr r0, r6, #16
    bl Lrd_slow
    b L218
    .p2align 4
Lf_34:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L219
L220:
    ldrb r1, [r3, r0]
    add ip, r1, #1
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L221
    strb r1, [ip, r0]
L222:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L223
L224:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L219:
    bl Lrd_slow
    b L220
L221:
    mov r3, r1
    bl Lwr_slow
    b L222
L223:
    lsr r0, r6, #16
    bl Lrd_slow
    b L224
    .p2align 4
Lf_35:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L225
L226:
    ldrb r1, [r3, r0]
    sub ip, r1, #1
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L227
    strb r1, [ip, r0]
L228:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L229
L230:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L225:
    bl Lrd_slow
    b L226
L227:
    mov r3, r1
    bl Lwr_slow
    b L228
L229:
    lsr r0, r6, #16
    bl Lrd_slow
    b L230
    .p2align 4
Lf_36:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L231
L232:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L233
    strb r1, [ip, r0]
L234:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L235
L236:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L231:
    bl Lrd_slow
    b L232
L233:
    mov r3, r1
    bl Lwr_slow
    b L234
L235:
    lsr r0, r6, #16
    bl Lrd_slow
    b L236
    .p2align 4
Lf_37:
    and r8, r8, #0x80
    orr r8, r8, #0x10
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L237
L238:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L237:
    lsr r0, r6, #16
    bl Lrd_slow
    b L238
    .p2align 4
Lf_38:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L239
L240:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    tst r8, #16
    beq L241
    sxtb ip, r1
    add r6, r6, ip, lsl #16
    sub r5, r5, #4
L241:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L242
L243:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L239:
    bl Lrd_slow
    b L240
L242:
    lsr r0, r6, #16
    bl Lrd_slow
    b L243
    .p2align 4
Lf_39:
    uxth r3, r6
    add ip, r11, r3
    eor lr, r11, r3
    eor lr, lr, ip
    and r8, r8, #0x80
    tst lr, #0x1000
    orrne r8, r8, #0x20
    tst lr, #0x10000
    orrne r8, r8, #0x10
    uxth r11, ip
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L244
L245:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L244:
    lsr r0, r6, #16
    bl Lrd_slow
    b L245
    .p2align 4
Lf_3A:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L246
L247:
    ldrb r7, [r3, r0]
    sub r11, r0, #1
    uxth r11, r11
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L248
L249:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L246:
    bl Lrd_slow
    b L247
L248:
    lsr r0, r6, #16
    bl Lrd_slow
    b L249
    .p2align 4
Lf_3B:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L250
L251:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L250:
    lsr r0, r6, #16
    bl Lrd_slow
    b L251
    .p2align 4
Lf_3C:
    add ip, r7, #1
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L252
L253:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L252:
    lsr r0, r6, #16
    bl Lrd_slow
    b L253
    .p2align 4
Lf_3D:
    sub ip, r7, #1
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L254
L255:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L254:
    lsr r0, r6, #16
    bl Lrd_slow
    b L255
    .p2align 4
Lf_3E:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L256
L257:
    ldrb r7, [r3, r0]
    add r6, r6, #0x10000
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L258
L259:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L256:
    bl Lrd_slow
    b L257
L258:
    lsr r0, r6, #16
    bl Lrd_slow
    b L259
    .p2align 4
Lf_3F:
    and r8, r8, #0x90
    eor r8, r8, #0x10
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L260
L261:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L260:
    lsr r0, r6, #16
    bl Lrd_slow
    b L261
    .p2align 4
Lf_40:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L262
L263:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L262:
    lsr r0, r6, #16
    bl Lrd_slow
    b L263
    .p2align 4
Lf_41:
    uxtb r3, r9
    bfi r9, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L264
L265:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L264:
    lsr r0, r6, #16
    bl Lrd_slow
    b L265
    .p2align 4
Lf_42:
    lsr r3, r10, #8
    bfi r9, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L266
L267:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L266:
    lsr r0, r6, #16
    bl Lrd_slow
    b L267
    .p2align 4
Lf_43:
    uxtb r3, r10
    bfi r9, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L268
L269:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L268:
    lsr r0, r6, #16
    bl Lrd_slow
    b L269
    .p2align 4
Lf_44:
    lsr r3, r11, #8
    bfi r9, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L270
L271:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L270:
    lsr r0, r6, #16
    bl Lrd_slow
    b L271
    .p2align 4
Lf_45:
    uxtb r3, r11
    bfi r9, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L272
L273:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L272:
    lsr r0, r6, #16
    bl Lrd_slow
    b L273
    .p2align 4
Lf_46:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L274
L275:
    ldrb ip, [r3, r0]
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L276
L277:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L274:
    bl Lrd_slow
    b L275
L276:
    lsr r0, r6, #16
    bl Lrd_slow
    b L277
    .p2align 4
Lf_47:
    bfi r9, r7, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L278
L279:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L278:
    lsr r0, r6, #16
    bl Lrd_slow
    b L279
    .p2align 4
Lf_48:
    lsr r3, r9, #8
    bfi r9, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L280
L281:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L280:
    lsr r0, r6, #16
    bl Lrd_slow
    b L281
    .p2align 4
Lf_49:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L282
L283:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L282:
    lsr r0, r6, #16
    bl Lrd_slow
    b L283
    .p2align 4
Lf_4A:
    lsr r3, r10, #8
    bfi r9, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L284
L285:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L284:
    lsr r0, r6, #16
    bl Lrd_slow
    b L285
    .p2align 4
Lf_4B:
    uxtb r3, r10
    bfi r9, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L286
L287:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L286:
    lsr r0, r6, #16
    bl Lrd_slow
    b L287
    .p2align 4
Lf_4C:
    lsr r3, r11, #8
    bfi r9, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L288
L289:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L288:
    lsr r0, r6, #16
    bl Lrd_slow
    b L289
    .p2align 4
Lf_4D:
    uxtb r3, r11
    bfi r9, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L290
L291:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L290:
    lsr r0, r6, #16
    bl Lrd_slow
    b L291
    .p2align 4
Lf_4E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L292
L293:
    ldrb ip, [r3, r0]
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L294
L295:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L292:
    bl Lrd_slow
    b L293
L294:
    lsr r0, r6, #16
    bl Lrd_slow
    b L295
    .p2align 4
Lf_4F:
    bfi r9, r7, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L296
L297:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L296:
    lsr r0, r6, #16
    bl Lrd_slow
    b L297
    .p2align 4
Lf_50:
    lsr r3, r9, #8
    bfi r10, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L298
L299:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L298:
    lsr r0, r6, #16
    bl Lrd_slow
    b L299
    .p2align 4
Lf_51:
    uxtb r3, r9
    bfi r10, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L300
L301:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L300:
    lsr r0, r6, #16
    bl Lrd_slow
    b L301
    .p2align 4
Lf_52:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L302
L303:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L302:
    lsr r0, r6, #16
    bl Lrd_slow
    b L303
    .p2align 4
Lf_53:
    uxtb r3, r10
    bfi r10, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L304
L305:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L304:
    lsr r0, r6, #16
    bl Lrd_slow
    b L305
    .p2align 4
Lf_54:
    lsr r3, r11, #8
    bfi r10, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L306
L307:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L306:
    lsr r0, r6, #16
    bl Lrd_slow
    b L307
    .p2align 4
Lf_55:
    uxtb r3, r11
    bfi r10, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L308
L309:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L308:
    lsr r0, r6, #16
    bl Lrd_slow
    b L309
    .p2align 4
Lf_56:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L310
L311:
    ldrb ip, [r3, r0]
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L312
L313:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L310:
    bl Lrd_slow
    b L311
L312:
    lsr r0, r6, #16
    bl Lrd_slow
    b L313
    .p2align 4
Lf_57:
    bfi r10, r7, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L314
L315:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L314:
    lsr r0, r6, #16
    bl Lrd_slow
    b L315
    .p2align 4
Lf_58:
    lsr r3, r9, #8
    bfi r10, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L316
L317:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L316:
    lsr r0, r6, #16
    bl Lrd_slow
    b L317
    .p2align 4
Lf_59:
    uxtb r3, r9
    bfi r10, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L318
L319:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L318:
    lsr r0, r6, #16
    bl Lrd_slow
    b L319
    .p2align 4
Lf_5A:
    lsr r3, r10, #8
    bfi r10, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L320
L321:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L320:
    lsr r0, r6, #16
    bl Lrd_slow
    b L321
    .p2align 4
Lf_5B:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L322
L323:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L322:
    lsr r0, r6, #16
    bl Lrd_slow
    b L323
    .p2align 4
Lf_5C:
    lsr r3, r11, #8
    bfi r10, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L324
L325:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L324:
    lsr r0, r6, #16
    bl Lrd_slow
    b L325
    .p2align 4
Lf_5D:
    uxtb r3, r11
    bfi r10, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L326
L327:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L326:
    lsr r0, r6, #16
    bl Lrd_slow
    b L327
    .p2align 4
Lf_5E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L328
L329:
    ldrb ip, [r3, r0]
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L330
L331:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L328:
    bl Lrd_slow
    b L329
L330:
    lsr r0, r6, #16
    bl Lrd_slow
    b L331
    .p2align 4
Lf_5F:
    bfi r10, r7, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L332
L333:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L332:
    lsr r0, r6, #16
    bl Lrd_slow
    b L333
    .p2align 4
Lf_60:
    lsr r3, r9, #8
    bfi r11, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L334
L335:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L334:
    lsr r0, r6, #16
    bl Lrd_slow
    b L335
    .p2align 4
Lf_61:
    uxtb r3, r9
    bfi r11, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L336
L337:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L336:
    lsr r0, r6, #16
    bl Lrd_slow
    b L337
    .p2align 4
Lf_62:
    lsr r3, r10, #8
    bfi r11, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L338
L339:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L338:
    lsr r0, r6, #16
    bl Lrd_slow
    b L339
    .p2align 4
Lf_63:
    uxtb r3, r10
    bfi r11, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L340
L341:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L340:
    lsr r0, r6, #16
    bl Lrd_slow
    b L341
    .p2align 4
Lf_64:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L342
L343:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L342:
    lsr r0, r6, #16
    bl Lrd_slow
    b L343
    .p2align 4
Lf_65:
    uxtb r3, r11
    bfi r11, r3, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L344
L345:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L344:
    lsr r0, r6, #16
    bl Lrd_slow
    b L345
    .p2align 4
Lf_66:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L346
L347:
    ldrb ip, [r3, r0]
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L348
L349:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L346:
    bl Lrd_slow
    b L347
L348:
    lsr r0, r6, #16
    bl Lrd_slow
    b L349
    .p2align 4
Lf_67:
    bfi r11, r7, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L350
L351:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L350:
    lsr r0, r6, #16
    bl Lrd_slow
    b L351
    .p2align 4
Lf_68:
    lsr r3, r9, #8
    bfi r11, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L352
L353:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L352:
    lsr r0, r6, #16
    bl Lrd_slow
    b L353
    .p2align 4
Lf_69:
    uxtb r3, r9
    bfi r11, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L354
L355:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L354:
    lsr r0, r6, #16
    bl Lrd_slow
    b L355
    .p2align 4
Lf_6A:
    lsr r3, r10, #8
    bfi r11, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L356
L357:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L356:
    lsr r0, r6, #16
    bl Lrd_slow
    b L357
    .p2align 4
Lf_6B:
    uxtb r3, r10
    bfi r11, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L358
L359:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L358:
    lsr r0, r6, #16
    bl Lrd_slow
    b L359
    .p2align 4
Lf_6C:
    lsr r3, r11, #8
    bfi r11, r3, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L360
L361:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L360:
    lsr r0, r6, #16
    bl Lrd_slow
    b L361
    .p2align 4
Lf_6D:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L362
L363:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L362:
    lsr r0, r6, #16
    bl Lrd_slow
    b L363
    .p2align 4
Lf_6E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L364
L365:
    ldrb ip, [r3, r0]
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L366
L367:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L364:
    bl Lrd_slow
    b L365
L366:
    lsr r0, r6, #16
    bl Lrd_slow
    b L367
    .p2align 4
Lf_6F:
    bfi r11, r7, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L368
L369:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L368:
    lsr r0, r6, #16
    bl Lrd_slow
    b L369
    .p2align 4
Lf_70:
    mov r0, r11
    sub r5, r5, #4
    lsr r3, r9, #8
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L370
    strb r3, [ip, r0]
L371:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L372
L373:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L370:
    bl Lwr_slow
    b L371
L372:
    lsr r0, r6, #16
    bl Lrd_slow
    b L373
    .p2align 4
Lf_71:
    mov r0, r11
    sub r5, r5, #4
    uxtb r3, r9
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L374
    strb r3, [ip, r0]
L375:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L376
L377:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L374:
    bl Lwr_slow
    b L375
L376:
    lsr r0, r6, #16
    bl Lrd_slow
    b L377
    .p2align 4
Lf_72:
    mov r0, r11
    sub r5, r5, #4
    lsr r3, r10, #8
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L378
    strb r3, [ip, r0]
L379:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L380
L381:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L378:
    bl Lwr_slow
    b L379
L380:
    lsr r0, r6, #16
    bl Lrd_slow
    b L381
    .p2align 4
Lf_73:
    mov r0, r11
    sub r5, r5, #4
    uxtb r3, r10
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L382
    strb r3, [ip, r0]
L383:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L384
L385:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L382:
    bl Lwr_slow
    b L383
L384:
    lsr r0, r6, #16
    bl Lrd_slow
    b L385
    .p2align 4
Lf_74:
    mov r0, r11
    sub r5, r5, #4
    lsr r3, r11, #8
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L386
    strb r3, [ip, r0]
L387:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L388
L389:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L386:
    bl Lwr_slow
    b L387
L388:
    lsr r0, r6, #16
    bl Lrd_slow
    b L389
    .p2align 4
Lf_75:
    mov r0, r11
    sub r5, r5, #4
    uxtb r3, r11
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L390
    strb r3, [ip, r0]
L391:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L392
L393:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L390:
    bl Lwr_slow
    b L391
L392:
    lsr r0, r6, #16
    bl Lrd_slow
    b L393
    .p2align 4
Lf_76:
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L394
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L394:
    ldr r0, [sp, #0]
    mov r1, #118
    bl gbc_asm_op
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L395
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L395:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L396
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L396:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L397
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L397:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L398
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L398:
    sub r2, r5, r2
    str r2, [sp, #56]
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L399
L400:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L399:
    lsr r0, r6, #16
    bl Lrd_slow
    b L400
    .p2align 4
Lf_77:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L401
    strb r7, [ip, r0]
L402:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L403
L404:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L401:
    mov r3, r7
    bl Lwr_slow
    b L402
L403:
    lsr r0, r6, #16
    bl Lrd_slow
    b L404
    .p2align 4
Lf_78:
    lsr r7, r9, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L405
L406:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L405:
    lsr r0, r6, #16
    bl Lrd_slow
    b L406
    .p2align 4
Lf_79:
    uxtb r7, r9
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L407
L408:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L407:
    lsr r0, r6, #16
    bl Lrd_slow
    b L408
    .p2align 4
Lf_7A:
    lsr r7, r10, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L409
L410:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L409:
    lsr r0, r6, #16
    bl Lrd_slow
    b L410
    .p2align 4
Lf_7B:
    uxtb r7, r10
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L411
L412:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L411:
    lsr r0, r6, #16
    bl Lrd_slow
    b L412
    .p2align 4
Lf_7C:
    lsr r7, r11, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L413
L414:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L413:
    lsr r0, r6, #16
    bl Lrd_slow
    b L414
    .p2align 4
Lf_7D:
    uxtb r7, r11
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L415
L416:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L415:
    lsr r0, r6, #16
    bl Lrd_slow
    b L416
    .p2align 4
Lf_7E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L417
L418:
    ldrb r7, [r3, r0]
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L419
L420:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L417:
    bl Lrd_slow
    b L418
L419:
    lsr r0, r6, #16
    bl Lrd_slow
    b L420
    .p2align 4
Lf_7F:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L421
L422:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L421:
    lsr r0, r6, #16
    bl Lrd_slow
    b L422
    .p2align 4
Lf_80:
    lsr r3, r9, #8
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L423
L424:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L423:
    lsr r0, r6, #16
    bl Lrd_slow
    b L424
    .p2align 4
Lf_81:
    uxtb r3, r9
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L425
L426:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L425:
    lsr r0, r6, #16
    bl Lrd_slow
    b L426
    .p2align 4
Lf_82:
    lsr r3, r10, #8
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L427
L428:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L427:
    lsr r0, r6, #16
    bl Lrd_slow
    b L428
    .p2align 4
Lf_83:
    uxtb r3, r10
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L429
L430:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L429:
    lsr r0, r6, #16
    bl Lrd_slow
    b L430
    .p2align 4
Lf_84:
    lsr r3, r11, #8
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L431
L432:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L431:
    lsr r0, r6, #16
    bl Lrd_slow
    b L432
    .p2align 4
Lf_85:
    uxtb r3, r11
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L433
L434:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L433:
    lsr r0, r6, #16
    bl Lrd_slow
    b L434
    .p2align 4
Lf_86:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L435
L436:
    ldrb r1, [r3, r0]
    add ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L437
L438:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L435:
    bl Lrd_slow
    b L436
L437:
    lsr r0, r6, #16
    bl Lrd_slow
    b L438
    .p2align 4
Lf_87:
    add ip, r7, r7
    eor lr, r7, r7
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L439
L440:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L439:
    lsr r0, r6, #16
    bl Lrd_slow
    b L440
    .p2align 4
Lf_88:
    lsr r3, r9, #8
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L441
L442:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L441:
    lsr r0, r6, #16
    bl Lrd_slow
    b L442
    .p2align 4
Lf_89:
    uxtb r3, r9
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L443
L444:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L443:
    lsr r0, r6, #16
    bl Lrd_slow
    b L444
    .p2align 4
Lf_8A:
    lsr r3, r10, #8
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L445
L446:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L445:
    lsr r0, r6, #16
    bl Lrd_slow
    b L446
    .p2align 4
Lf_8B:
    uxtb r3, r10
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L447
L448:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L447:
    lsr r0, r6, #16
    bl Lrd_slow
    b L448
    .p2align 4
Lf_8C:
    lsr r3, r11, #8
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L449
L450:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L449:
    lsr r0, r6, #16
    bl Lrd_slow
    b L450
    .p2align 4
Lf_8D:
    uxtb r3, r11
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L451
L452:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L451:
    lsr r0, r6, #16
    bl Lrd_slow
    b L452
    .p2align 4
Lf_8E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L453
L454:
    ldrb r1, [r3, r0]
    and lr, r8, #0x10
    add ip, r7, r1
    add ip, ip, lr, lsr #4
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L455
L456:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L453:
    bl Lrd_slow
    b L454
L455:
    lsr r0, r6, #16
    bl Lrd_slow
    b L456
    .p2align 4
Lf_8F:
    and lr, r8, #0x10
    add ip, r7, r7
    add ip, ip, lr, lsr #4
    eor lr, r7, r7
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L457
L458:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L457:
    lsr r0, r6, #16
    bl Lrd_slow
    b L458
    .p2align 4
Lf_90:
    lsr r3, r9, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L459
L460:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L459:
    lsr r0, r6, #16
    bl Lrd_slow
    b L460
    .p2align 4
Lf_91:
    uxtb r3, r9
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L461
L462:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L461:
    lsr r0, r6, #16
    bl Lrd_slow
    b L462
    .p2align 4
Lf_92:
    lsr r3, r10, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L463
L464:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L463:
    lsr r0, r6, #16
    bl Lrd_slow
    b L464
    .p2align 4
Lf_93:
    uxtb r3, r10
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L465
L466:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L465:
    lsr r0, r6, #16
    bl Lrd_slow
    b L466
    .p2align 4
Lf_94:
    lsr r3, r11, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L467
L468:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L467:
    lsr r0, r6, #16
    bl Lrd_slow
    b L468
    .p2align 4
Lf_95:
    uxtb r3, r11
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L469
L470:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L469:
    lsr r0, r6, #16
    bl Lrd_slow
    b L470
    .p2align 4
Lf_96:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L471
L472:
    ldrb r1, [r3, r0]
    sub ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L473
L474:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L471:
    bl Lrd_slow
    b L472
L473:
    lsr r0, r6, #16
    bl Lrd_slow
    b L474
    .p2align 4
Lf_97:
    sub ip, r7, r7
    eor lr, r7, r7
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L475
L476:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L475:
    lsr r0, r6, #16
    bl Lrd_slow
    b L476
    .p2align 4
Lf_98:
    lsr r3, r9, #8
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L477
L478:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L477:
    lsr r0, r6, #16
    bl Lrd_slow
    b L478
    .p2align 4
Lf_99:
    uxtb r3, r9
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L479
L480:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L479:
    lsr r0, r6, #16
    bl Lrd_slow
    b L480
    .p2align 4
Lf_9A:
    lsr r3, r10, #8
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L481
L482:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L481:
    lsr r0, r6, #16
    bl Lrd_slow
    b L482
    .p2align 4
Lf_9B:
    uxtb r3, r10
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L483
L484:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L483:
    lsr r0, r6, #16
    bl Lrd_slow
    b L484
    .p2align 4
Lf_9C:
    lsr r3, r11, #8
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L485
L486:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L485:
    lsr r0, r6, #16
    bl Lrd_slow
    b L486
    .p2align 4
Lf_9D:
    uxtb r3, r11
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L487
L488:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L487:
    lsr r0, r6, #16
    bl Lrd_slow
    b L488
    .p2align 4
Lf_9E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L489
L490:
    ldrb r1, [r3, r0]
    and lr, r8, #0x10
    sub ip, r7, r1
    sub ip, ip, lr, lsr #4
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L491
L492:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L489:
    bl Lrd_slow
    b L490
L491:
    lsr r0, r6, #16
    bl Lrd_slow
    b L492
    .p2align 4
Lf_9F:
    and lr, r8, #0x10
    sub ip, r7, r7
    sub ip, ip, lr, lsr #4
    eor lr, r7, r7
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L493
L494:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L493:
    lsr r0, r6, #16
    bl Lrd_slow
    b L494
    .p2align 4
Lf_A0:
    lsr r3, r9, #8
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L495
L496:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L495:
    lsr r0, r6, #16
    bl Lrd_slow
    b L496
    .p2align 4
Lf_A1:
    uxtb r3, r9
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L497
L498:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L497:
    lsr r0, r6, #16
    bl Lrd_slow
    b L498
    .p2align 4
Lf_A2:
    lsr r3, r10, #8
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L499
L500:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L499:
    lsr r0, r6, #16
    bl Lrd_slow
    b L500
    .p2align 4
Lf_A3:
    uxtb r3, r10
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L501
L502:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L501:
    lsr r0, r6, #16
    bl Lrd_slow
    b L502
    .p2align 4
Lf_A4:
    lsr r3, r11, #8
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L503
L504:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L503:
    lsr r0, r6, #16
    bl Lrd_slow
    b L504
    .p2align 4
Lf_A5:
    uxtb r3, r11
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L505
L506:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L505:
    lsr r0, r6, #16
    bl Lrd_slow
    b L506
    .p2align 4
Lf_A6:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L507
L508:
    ldrb r1, [r3, r0]
    ands r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L509
L510:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L507:
    bl Lrd_slow
    b L508
L509:
    lsr r0, r6, #16
    bl Lrd_slow
    b L510
    .p2align 4
Lf_A7:
    ands r7, r7, r7
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L511
L512:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L511:
    lsr r0, r6, #16
    bl Lrd_slow
    b L512
    .p2align 4
Lf_A8:
    lsr r3, r9, #8
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L513
L514:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L513:
    lsr r0, r6, #16
    bl Lrd_slow
    b L514
    .p2align 4
Lf_A9:
    uxtb r3, r9
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L515
L516:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L515:
    lsr r0, r6, #16
    bl Lrd_slow
    b L516
    .p2align 4
Lf_AA:
    lsr r3, r10, #8
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L517
L518:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L517:
    lsr r0, r6, #16
    bl Lrd_slow
    b L518
    .p2align 4
Lf_AB:
    uxtb r3, r10
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L519
L520:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L519:
    lsr r0, r6, #16
    bl Lrd_slow
    b L520
    .p2align 4
Lf_AC:
    lsr r3, r11, #8
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L521
L522:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L521:
    lsr r0, r6, #16
    bl Lrd_slow
    b L522
    .p2align 4
Lf_AD:
    uxtb r3, r11
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L523
L524:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L523:
    lsr r0, r6, #16
    bl Lrd_slow
    b L524
    .p2align 4
Lf_AE:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L525
L526:
    ldrb r1, [r3, r0]
    eors r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L527
L528:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L525:
    bl Lrd_slow
    b L526
L527:
    lsr r0, r6, #16
    bl Lrd_slow
    b L528
    .p2align 4
Lf_AF:
    eors r7, r7, r7
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L529
L530:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L529:
    lsr r0, r6, #16
    bl Lrd_slow
    b L530
    .p2align 4
Lf_B0:
    lsr r3, r9, #8
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L531
L532:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L531:
    lsr r0, r6, #16
    bl Lrd_slow
    b L532
    .p2align 4
Lf_B1:
    uxtb r3, r9
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L533
L534:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L533:
    lsr r0, r6, #16
    bl Lrd_slow
    b L534
    .p2align 4
Lf_B2:
    lsr r3, r10, #8
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L535
L536:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L535:
    lsr r0, r6, #16
    bl Lrd_slow
    b L536
    .p2align 4
Lf_B3:
    uxtb r3, r10
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L537
L538:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L537:
    lsr r0, r6, #16
    bl Lrd_slow
    b L538
    .p2align 4
Lf_B4:
    lsr r3, r11, #8
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L539
L540:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L539:
    lsr r0, r6, #16
    bl Lrd_slow
    b L540
    .p2align 4
Lf_B5:
    uxtb r3, r11
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L541
L542:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L541:
    lsr r0, r6, #16
    bl Lrd_slow
    b L542
    .p2align 4
Lf_B6:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L543
L544:
    ldrb r1, [r3, r0]
    orrs r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L545
L546:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L543:
    bl Lrd_slow
    b L544
L545:
    lsr r0, r6, #16
    bl Lrd_slow
    b L546
    .p2align 4
Lf_B7:
    orrs r7, r7, r7
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L547
L548:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L547:
    lsr r0, r6, #16
    bl Lrd_slow
    b L548
    .p2align 4
Lf_B8:
    lsr r3, r9, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L549
L550:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L549:
    lsr r0, r6, #16
    bl Lrd_slow
    b L550
    .p2align 4
Lf_B9:
    uxtb r3, r9
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L551
L552:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L551:
    lsr r0, r6, #16
    bl Lrd_slow
    b L552
    .p2align 4
Lf_BA:
    lsr r3, r10, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L553
L554:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L553:
    lsr r0, r6, #16
    bl Lrd_slow
    b L554
    .p2align 4
Lf_BB:
    uxtb r3, r10
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L555
L556:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L555:
    lsr r0, r6, #16
    bl Lrd_slow
    b L556
    .p2align 4
Lf_BC:
    lsr r3, r11, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L557
L558:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L557:
    lsr r0, r6, #16
    bl Lrd_slow
    b L558
    .p2align 4
Lf_BD:
    uxtb r3, r11
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L559
L560:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L559:
    lsr r0, r6, #16
    bl Lrd_slow
    b L560
    .p2align 4
Lf_BE:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L561
L562:
    ldrb r1, [r3, r0]
    sub ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L563
L564:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L561:
    bl Lrd_slow
    b L562
L563:
    lsr r0, r6, #16
    bl Lrd_slow
    b L564
    .p2align 4
Lf_BF:
    sub ip, r7, r7
    eor lr, r7, r7
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L565
L566:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L565:
    lsr r0, r6, #16
    bl Lrd_slow
    b L566
    .p2align 4
Lf_C0:
    sub r5, r5, #4
    tst r8, #128
    bne L567
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L568
L569:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L570
L571:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
L567:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L572
L573:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L568:
    bl Lrd_slow
    b L569
L570:
    bl Lrd_slow
    b L571
L572:
    lsr r0, r6, #16
    bl Lrd_slow
    b L573
    .p2align 4
Lf_C1:
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L574
L575:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L576
L577:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    mov r9, r2
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L578
L579:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L574:
    bl Lrd_slow
    b L575
L576:
    bl Lrd_slow
    b L577
L578:
    lsr r0, r6, #16
    bl Lrd_slow
    b L579
    .p2align 4
Lf_C2:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L580
L581:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L582
L583:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #128
    bne L584
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
L584:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L585
L586:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L580:
    bl Lrd_slow
    b L581
L582:
    bl Lrd_slow
    b L583
L585:
    lsr r0, r6, #16
    bl Lrd_slow
    b L586
    .p2align 4
Lf_C3:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L587
L588:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L589
L590:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
L591:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L592
L593:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L587:
    bl Lrd_slow
    b L588
L589:
    bl Lrd_slow
    b L590
L592:
    lsr r0, r6, #16
    bl Lrd_slow
    b L593
    .p2align 4
Lf_C4:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L594
L595:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L596
L597:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #128
    bne L598
    sub r5, r5, #4
    str r2, [sp, #60]
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L599
    strb r1, [ip, r0]
L600:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L601
L602:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L603
    strb r2, [ip, r0]
L604:
    ldr ip, [sp, #60]
    pkhbt r6, r6, ip, lsl #16
L598:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L605
L606:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L594:
    bl Lrd_slow
    b L595
L596:
    bl Lrd_slow
    b L597
L599:
    mov r3, r1
    bl Lwr_slow
    b L600
L601:
    bl Ltick_slow4
    b L602
L603:
    mov r3, r2
    bl Lwr_slow
    b L604
L605:
    lsr r0, r6, #16
    bl Lrd_slow
    b L606
    .p2align 4
Lf_C5:
    sub r5, r5, #4
    mov r2, r9
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L607
    strb r1, [ip, r0]
L608:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L609
L610:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L611
    strb r2, [ip, r0]
L612:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L613
L614:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L607:
    mov r3, r1
    bl Lwr_slow
    b L608
L609:
    bl Ltick_slow4
    b L610
L611:
    mov r3, r2
    bl Lwr_slow
    b L612
L613:
    lsr r0, r6, #16
    bl Lrd_slow
    b L614
    .p2align 4
Lf_C6:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L615
L616:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    add ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L617
L618:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L615:
    bl Lrd_slow
    b L616
L617:
    lsr r0, r6, #16
    bl Lrd_slow
    b L618
    .p2align 4
Lf_C7:
    sub r5, r5, #4
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L619
    strb r1, [ip, r0]
L620:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L621
L622:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L623
    strb r2, [ip, r0]
L624:
    mov ip, #0
    pkhbt r6, r6, ip, lsl #16
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L625
L626:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L619:
    mov r3, r1
    bl Lwr_slow
    b L620
L621:
    bl Ltick_slow4
    b L622
L623:
    mov r3, r2
    bl Lwr_slow
    b L624
L625:
    lsr r0, r6, #16
    bl Lrd_slow
    b L626
    .p2align 4
Lf_C8:
    sub r5, r5, #4
    tst r8, #128
    beq L627
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L628
L629:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L630
L631:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
L627:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L632
L633:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L628:
    bl Lrd_slow
    b L629
L630:
    bl Lrd_slow
    b L631
L632:
    lsr r0, r6, #16
    bl Lrd_slow
    b L633
    .p2align 4
Lf_C9:
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L634
L635:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L636
L637:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L638
L639:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L634:
    bl Lrd_slow
    b L635
L636:
    bl Lrd_slow
    b L637
L638:
    lsr r0, r6, #16
    bl Lrd_slow
    b L639
    .p2align 4
Lf_CA:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L640
L641:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L642
L643:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #128
    beq L644
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
L644:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L645
L646:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L640:
    bl Lrd_slow
    b L641
L642:
    bl Lrd_slow
    b L643
L645:
    lsr r0, r6, #16
    bl Lrd_slow
    b L646
    .p2align 4
Lf_CB:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L647
L648:
    ldrb r0, [r3, r0]
    add r6, r6, #0x10000
    ldr ip, [sp, #16]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L647:
    bl Lrd_slow
    b L648
    .p2align 4
Lf_CC:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L649
L650:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L651
L652:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #128
    beq L653
    sub r5, r5, #4
    str r2, [sp, #60]
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L654
    strb r1, [ip, r0]
L655:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L656
L657:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L658
    strb r2, [ip, r0]
L659:
    ldr ip, [sp, #60]
    pkhbt r6, r6, ip, lsl #16
L653:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L660
L661:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L649:
    bl Lrd_slow
    b L650
L651:
    bl Lrd_slow
    b L652
L654:
    mov r3, r1
    bl Lwr_slow
    b L655
L656:
    bl Ltick_slow4
    b L657
L658:
    mov r3, r2
    bl Lwr_slow
    b L659
L660:
    lsr r0, r6, #16
    bl Lrd_slow
    b L661
    .p2align 4
Lf_CD:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L662
L663:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L664
L665:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    sub r5, r5, #4
    str r2, [sp, #60]
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L667
    strb r1, [ip, r0]
L668:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L669
L670:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L671
    strb r2, [ip, r0]
L672:
    ldr ip, [sp, #60]
    pkhbt r6, r6, ip, lsl #16
L666:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L673
L674:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L662:
    bl Lrd_slow
    b L663
L664:
    bl Lrd_slow
    b L665
L667:
    mov r3, r1
    bl Lwr_slow
    b L668
L669:
    bl Ltick_slow4
    b L670
L671:
    mov r3, r2
    bl Lwr_slow
    b L672
L673:
    lsr r0, r6, #16
    bl Lrd_slow
    b L674
    .p2align 4
Lf_CE:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L675
L676:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    and lr, r8, #0x10
    add ip, r7, r1
    add ip, ip, lr, lsr #4
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L677
L678:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L675:
    bl Lrd_slow
    b L676
L677:
    lsr r0, r6, #16
    bl Lrd_slow
    b L678
    .p2align 4
Lf_CF:
    sub r5, r5, #4
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L679
    strb r1, [ip, r0]
L680:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L681
L682:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L683
    strb r2, [ip, r0]
L684:
    mov ip, #8
    pkhbt r6, r6, ip, lsl #16
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L685
L686:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L679:
    mov r3, r1
    bl Lwr_slow
    b L680
L681:
    bl Ltick_slow4
    b L682
L683:
    mov r3, r2
    bl Lwr_slow
    b L684
L685:
    lsr r0, r6, #16
    bl Lrd_slow
    b L686
    .p2align 4
Lf_D0:
    sub r5, r5, #4
    tst r8, #16
    bne L687
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L688
L689:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L690
L691:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
L687:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L692
L693:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L688:
    bl Lrd_slow
    b L689
L690:
    bl Lrd_slow
    b L691
L692:
    lsr r0, r6, #16
    bl Lrd_slow
    b L693
    .p2align 4
Lf_D1:
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L694
L695:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L696
L697:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    mov r10, r2
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L698
L699:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L694:
    bl Lrd_slow
    b L695
L696:
    bl Lrd_slow
    b L697
L698:
    lsr r0, r6, #16
    bl Lrd_slow
    b L699
    .p2align 4
Lf_D2:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L700
L701:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L702
L703:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #16
    bne L704
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
L704:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L705
L706:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L700:
    bl Lrd_slow
    b L701
L702:
    bl Lrd_slow
    b L703
L705:
    lsr r0, r6, #16
    bl Lrd_slow
    b L706
    .p2align 4
Lf_D3:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L707
L708:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L707:
    lsr r0, r6, #16
    bl Lrd_slow
    b L708
    .p2align 4
Lf_D4:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L709
L710:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L711
L712:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #16
    bne L713
    sub r5, r5, #4
    str r2, [sp, #60]
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L714
    strb r1, [ip, r0]
L715:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L716
L717:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L718
    strb r2, [ip, r0]
L719:
    ldr ip, [sp, #60]
    pkhbt r6, r6, ip, lsl #16
L713:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L720
L721:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L709:
    bl Lrd_slow
    b L710
L711:
    bl Lrd_slow
    b L712
L714:
    mov r3, r1
    bl Lwr_slow
    b L715
L716:
    bl Ltick_slow4
    b L717
L718:
    mov r3, r2
    bl Lwr_slow
    b L719
L720:
    lsr r0, r6, #16
    bl Lrd_slow
    b L721
    .p2align 4
Lf_D5:
    sub r5, r5, #4
    mov r2, r10
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L722
    strb r1, [ip, r0]
L723:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L724
L725:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L726
    strb r2, [ip, r0]
L727:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L728
L729:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L722:
    mov r3, r1
    bl Lwr_slow
    b L723
L724:
    bl Ltick_slow4
    b L725
L726:
    mov r3, r2
    bl Lwr_slow
    b L727
L728:
    lsr r0, r6, #16
    bl Lrd_slow
    b L729
    .p2align 4
Lf_D6:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L730
L731:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    sub ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L732
L733:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L730:
    bl Lrd_slow
    b L731
L732:
    lsr r0, r6, #16
    bl Lrd_slow
    b L733
    .p2align 4
Lf_D7:
    sub r5, r5, #4
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L734
    strb r1, [ip, r0]
L735:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L736
L737:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L738
    strb r2, [ip, r0]
L739:
    mov ip, #16
    pkhbt r6, r6, ip, lsl #16
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L740
L741:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L734:
    mov r3, r1
    bl Lwr_slow
    b L735
L736:
    bl Ltick_slow4
    b L737
L738:
    mov r3, r2
    bl Lwr_slow
    b L739
L740:
    lsr r0, r6, #16
    bl Lrd_slow
    b L741
    .p2align 4
Lf_D8:
    sub r5, r5, #4
    tst r8, #16
    beq L742
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L743
L744:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L745
L746:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
L742:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L747
L748:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L743:
    bl Lrd_slow
    b L744
L745:
    bl Lrd_slow
    b L746
L747:
    lsr r0, r6, #16
    bl Lrd_slow
    b L748
    .p2align 4
Lf_D9:
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L749
L750:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L751
L752:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L753
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L753:
    ldr r0, [sp, #0]
    mov r1, #217
    bl gbc_asm_op
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L754
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L754:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L755
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L755:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L756
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L756:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L757
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L757:
    sub r2, r5, r2
    str r2, [sp, #56]
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L758
L759:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L749:
    bl Lrd_slow
    b L750
L751:
    bl Lrd_slow
    b L752
L758:
    lsr r0, r6, #16
    bl Lrd_slow
    b L759
    .p2align 4
Lf_DA:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L760
L761:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L762
L763:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #16
    beq L764
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
L764:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L765
L766:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L760:
    bl Lrd_slow
    b L761
L762:
    bl Lrd_slow
    b L763
L765:
    lsr r0, r6, #16
    bl Lrd_slow
    b L766
    .p2align 4
Lf_DB:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L767
L768:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L767:
    lsr r0, r6, #16
    bl Lrd_slow
    b L768
    .p2align 4
Lf_DC:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L769
L770:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L771
L772:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #16
    beq L773
    sub r5, r5, #4
    str r2, [sp, #60]
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L774
    strb r1, [ip, r0]
L775:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L776
L777:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L778
    strb r2, [ip, r0]
L779:
    ldr ip, [sp, #60]
    pkhbt r6, r6, ip, lsl #16
L773:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L780
L781:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L769:
    bl Lrd_slow
    b L770
L771:
    bl Lrd_slow
    b L772
L774:
    mov r3, r1
    bl Lwr_slow
    b L775
L776:
    bl Ltick_slow4
    b L777
L778:
    mov r3, r2
    bl Lwr_slow
    b L779
L780:
    lsr r0, r6, #16
    bl Lrd_slow
    b L781
    .p2align 4
Lf_DD:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L782
L783:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L782:
    lsr r0, r6, #16
    bl Lrd_slow
    b L783
    .p2align 4
Lf_DE:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L784
L785:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    and lr, r8, #0x10
    sub ip, r7, r1
    sub ip, ip, lr, lsr #4
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L786
L787:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L784:
    bl Lrd_slow
    b L785
L786:
    lsr r0, r6, #16
    bl Lrd_slow
    b L787
    .p2align 4
Lf_DF:
    sub r5, r5, #4
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L788
    strb r1, [ip, r0]
L789:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L790
L791:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L792
    strb r2, [ip, r0]
L793:
    mov ip, #24
    pkhbt r6, r6, ip, lsl #16
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L794
L795:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L788:
    mov r3, r1
    bl Lwr_slow
    b L789
L790:
    bl Ltick_slow4
    b L791
L792:
    mov r3, r2
    bl Lwr_slow
    b L793
L794:
    lsr r0, r6, #16
    bl Lrd_slow
    b L795
    .p2align 4
Lf_E0:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L798
L799:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    cmp r1, #0x80
    blo L796
    cmp r1, #0xFF
    beq L796
    sub r5, r5, #4
    ldr r3, [r4, #136]
    orr ip, r1, #0xFF00
    strb r7, [r3, ip]
    b L797
L796:
    mov r0, r1
    orr r0, r0, #0xFF00
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L800
    strb r7, [ip, r0]
L801:
L797:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L802
L803:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L798:
    bl Lrd_slow
    b L799
L800:
    mov r3, r7
    bl Lwr_slow
    b L801
L802:
    lsr r0, r6, #16
    bl Lrd_slow
    b L803
    .p2align 4
Lf_E1:
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L804
L805:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L806
L807:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    mov r11, r2
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L808
L809:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L804:
    bl Lrd_slow
    b L805
L806:
    bl Lrd_slow
    b L807
L808:
    lsr r0, r6, #16
    bl Lrd_slow
    b L809
    .p2align 4
Lf_E2:
    uxtb r0, r9
    orr r0, r0, #0xFF00
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L810
    strb r7, [ip, r0]
L811:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L812
L813:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L810:
    mov r3, r7
    bl Lwr_slow
    b L811
L812:
    lsr r0, r6, #16
    bl Lrd_slow
    b L813
    .p2align 4
Lf_E3:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L814
L815:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L814:
    lsr r0, r6, #16
    bl Lrd_slow
    b L815
    .p2align 4
Lf_E4:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L816
L817:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L816:
    lsr r0, r6, #16
    bl Lrd_slow
    b L817
    .p2align 4
Lf_E5:
    sub r5, r5, #4
    mov r2, r11
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L818
    strb r1, [ip, r0]
L819:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L820
L821:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L822
    strb r2, [ip, r0]
L823:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L824
L825:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L818:
    mov r3, r1
    bl Lwr_slow
    b L819
L820:
    bl Ltick_slow4
    b L821
L822:
    mov r3, r2
    bl Lwr_slow
    b L823
L824:
    lsr r0, r6, #16
    bl Lrd_slow
    b L825
    .p2align 4
Lf_E6:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L826
L827:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    ands r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L828
L829:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L826:
    bl Lrd_slow
    b L827
L828:
    lsr r0, r6, #16
    bl Lrd_slow
    b L829
    .p2align 4
Lf_E7:
    sub r5, r5, #4
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L830
    strb r1, [ip, r0]
L831:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L832
L833:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L834
    strb r2, [ip, r0]
L835:
    mov ip, #32
    pkhbt r6, r6, ip, lsl #16
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L836
L837:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L830:
    mov r3, r1
    bl Lwr_slow
    b L831
L832:
    bl Ltick_slow4
    b L833
L834:
    mov r3, r2
    bl Lwr_slow
    b L835
L836:
    lsr r0, r6, #16
    bl Lrd_slow
    b L837
    .p2align 4
Lf_E8:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L838
L839:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    uxtb r3, r6
    add r3, r3, r1
    and ip, r6, #0xF
    and lr, r1, #0xF
    add ip, ip, lr
    ubfx r3, r3, #8, #1
    ubfx ip, ip, #4, #1
    lsl r8, r3, #4
    orr r8, r8, ip, lsl #5
    sxtb lr, r1
    uxth r3, r6
    add r3, r3, lr
    pkhbt r6, r3, r6
    sub r5, r5, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L840
L841:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L838:
    bl Lrd_slow
    b L839
L840:
    lsr r0, r6, #16
    bl Lrd_slow
    b L841
    .p2align 4
Lf_E9:
    pkhbt r6, r6, r11, lsl #16
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L842
L843:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L842:
    lsr r0, r6, #16
    bl Lrd_slow
    b L843
    .p2align 4
Lf_EA:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L844
L845:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L846
L847:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r0, r2
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L848
    strb r7, [ip, r0]
L849:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L850
L851:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L844:
    bl Lrd_slow
    b L845
L846:
    bl Lrd_slow
    b L847
L848:
    mov r3, r7
    bl Lwr_slow
    b L849
L850:
    lsr r0, r6, #16
    bl Lrd_slow
    b L851
    .p2align 4
Lf_EB:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L852
L853:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L852:
    lsr r0, r6, #16
    bl Lrd_slow
    b L853
    .p2align 4
Lf_EC:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L854
L855:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L854:
    lsr r0, r6, #16
    bl Lrd_slow
    b L855
    .p2align 4
Lf_ED:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L856
L857:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L856:
    lsr r0, r6, #16
    bl Lrd_slow
    b L857
    .p2align 4
Lf_EE:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L858
L859:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    eors r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L860
L861:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L858:
    bl Lrd_slow
    b L859
L860:
    lsr r0, r6, #16
    bl Lrd_slow
    b L861
    .p2align 4
Lf_EF:
    sub r5, r5, #4
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L862
    strb r1, [ip, r0]
L863:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L864
L865:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L866
    strb r2, [ip, r0]
L867:
    mov ip, #40
    pkhbt r6, r6, ip, lsl #16
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L868
L869:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L862:
    mov r3, r1
    bl Lwr_slow
    b L863
L864:
    bl Ltick_slow4
    b L865
L866:
    mov r3, r2
    bl Lwr_slow
    b L867
L868:
    lsr r0, r6, #16
    bl Lrd_slow
    b L869
    .p2align 4
Lf_F0:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L872
L873:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    cmp r1, #0x80
    blo L870
    cmp r1, #0xFF
    beq L870
    sub r5, r5, #4
    ldr r3, [r4, #136]
    orr ip, r1, #0xFF00
    ldrb r7, [r3, ip]
    b L871
L870:
    mov r0, r1
    orr r0, r0, #0xFF00
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L874
L875:
    ldrb r7, [r3, r0]
L871:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L876
L877:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L872:
    bl Lrd_slow
    b L873
L874:
    bl Lrd_slow
    b L875
L876:
    lsr r0, r6, #16
    bl Lrd_slow
    b L877
    .p2align 4
Lf_F1:
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L878
L879:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L880
L881:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    lsr r7, r2, #8
    and r8, r2, #0xF0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L882
L883:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L878:
    bl Lrd_slow
    b L879
L880:
    bl Lrd_slow
    b L881
L882:
    lsr r0, r6, #16
    bl Lrd_slow
    b L883
    .p2align 4
Lf_F2:
    uxtb r0, r9
    orr r0, r0, #0xFF00
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L884
L885:
    ldrb r7, [r3, r0]
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L886
L887:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L884:
    bl Lrd_slow
    b L885
L886:
    lsr r0, r6, #16
    bl Lrd_slow
    b L887
    .p2align 4
Lf_F3:
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L888
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L888:
    ldr r0, [sp, #0]
    mov r1, #243
    bl gbc_asm_op
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L889
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L889:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L890
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L890:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L891
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L891:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L892
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L892:
    sub r2, r5, r2
    str r2, [sp, #56]
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L893
L894:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L893:
    lsr r0, r6, #16
    bl Lrd_slow
    b L894
    .p2align 4
Lf_F4:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L895
L896:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L895:
    lsr r0, r6, #16
    bl Lrd_slow
    b L896
    .p2align 4
Lf_F5:
    sub r5, r5, #4
    orr r2, r8, r7, lsl #8
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L897
    strb r1, [ip, r0]
L898:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L899
L900:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L901
    strb r2, [ip, r0]
L902:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L903
L904:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L897:
    mov r3, r1
    bl Lwr_slow
    b L898
L899:
    bl Ltick_slow4
    b L900
L901:
    mov r3, r2
    bl Lwr_slow
    b L902
L903:
    lsr r0, r6, #16
    bl Lrd_slow
    b L904
    .p2align 4
Lf_F6:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L905
L906:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    orrs r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L907
L908:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L905:
    bl Lrd_slow
    b L906
L907:
    lsr r0, r6, #16
    bl Lrd_slow
    b L908
    .p2align 4
Lf_F7:
    sub r5, r5, #4
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L909
    strb r1, [ip, r0]
L910:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L911
L912:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L913
    strb r2, [ip, r0]
L914:
    mov ip, #48
    pkhbt r6, r6, ip, lsl #16
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L915
L916:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L909:
    mov r3, r1
    bl Lwr_slow
    b L910
L911:
    bl Ltick_slow4
    b L912
L913:
    mov r3, r2
    bl Lwr_slow
    b L914
L915:
    lsr r0, r6, #16
    bl Lrd_slow
    b L916
    .p2align 4
Lf_F8:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L917
L918:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    uxtb r3, r6
    add r3, r3, r1
    and ip, r6, #0xF
    and lr, r1, #0xF
    add ip, ip, lr
    ubfx r3, r3, #8, #1
    ubfx ip, ip, #4, #1
    lsl r8, r3, #4
    orr r8, r8, ip, lsl #5
    sxtb lr, r1
    uxth r3, r6
    add r3, r3, lr
    uxth r11, r3
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L919
L920:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L917:
    bl Lrd_slow
    b L918
L919:
    lsr r0, r6, #16
    bl Lrd_slow
    b L920
    .p2align 4
Lf_F9:
    pkhbt r6, r11, r6
    sub r5, r5, #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L921
L922:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L921:
    lsr r0, r6, #16
    bl Lrd_slow
    b L922
    .p2align 4
Lf_FA:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L923
L924:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L925
L926:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r0, r2
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L927
L928:
    ldrb r7, [r3, r0]
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L929
L930:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L923:
    bl Lrd_slow
    b L924
L925:
    bl Lrd_slow
    b L926
L927:
    bl Lrd_slow
    b L928
L929:
    lsr r0, r6, #16
    bl Lrd_slow
    b L930
    .p2align 4
Lf_FB:
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L931
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L931:
    ldr r0, [sp, #0]
    mov r1, #251
    bl gbc_asm_op
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L932
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L932:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L933
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L933:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L934
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L934:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L935
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L935:
    sub r2, r5, r2
    str r2, [sp, #56]
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L936
L937:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L936:
    lsr r0, r6, #16
    bl Lrd_slow
    b L937
    .p2align 4
Lf_FC:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L938
L939:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L938:
    lsr r0, r6, #16
    bl Lrd_slow
    b L939
    .p2align 4
Lf_FD:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L940
L941:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L940:
    lsr r0, r6, #16
    bl Lrd_slow
    b L941
    .p2align 4
Lf_FE:
    lsr r0, r6, #16
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L942
L943:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    sub ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L944
L945:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L942:
    bl Lrd_slow
    b L943
L944:
    lsr r0, r6, #16
    bl Lrd_slow
    b L945
    .p2align 4
Lf_FF:
    sub r5, r5, #4
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L946
    strb r1, [ip, r0]
L947:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L948
L949:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L950
    strb r2, [ip, r0]
L951:
    mov ip, #56
    pkhbt r6, r6, ip, lsl #16
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L952
L953:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L946:
    mov r3, r1
    bl Lwr_slow
    b L947
L948:
    bl Ltick_slow4
    b L949
L950:
    mov r3, r2
    bl Lwr_slow
    b L951
L952:
    lsr r0, r6, #16
    bl Lrd_slow
    b L953
    .p2align 4
Lfcb_00:
    lsr r3, r9, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L954
L955:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L954:
    lsr r0, r6, #16
    bl Lrd_slow
    b L955
    .p2align 4
Lfcb_01:
    uxtb r3, r9
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L956
L957:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L956:
    lsr r0, r6, #16
    bl Lrd_slow
    b L957
    .p2align 4
Lfcb_02:
    lsr r3, r10, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L958
L959:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L958:
    lsr r0, r6, #16
    bl Lrd_slow
    b L959
    .p2align 4
Lfcb_03:
    uxtb r3, r10
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L960
L961:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L960:
    lsr r0, r6, #16
    bl Lrd_slow
    b L961
    .p2align 4
Lfcb_04:
    lsr r3, r11, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L962
L963:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L962:
    lsr r0, r6, #16
    bl Lrd_slow
    b L963
    .p2align 4
Lfcb_05:
    uxtb r3, r11
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L964
L965:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L964:
    lsr r0, r6, #16
    bl Lrd_slow
    b L965
    .p2align 4
Lfcb_06:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L966
L967:
    ldrb r1, [r3, r0]
    lsr lr, r1, #7
    lsl ip, r1, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L968
    strb r1, [ip, r0]
L969:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L970
L971:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L966:
    bl Lrd_slow
    b L967
L968:
    mov r3, r1
    bl Lwr_slow
    b L969
L970:
    lsr r0, r6, #16
    bl Lrd_slow
    b L971
    .p2align 4
Lfcb_07:
    lsr lr, r7, #7
    lsl ip, r7, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L972
L973:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L972:
    lsr r0, r6, #16
    bl Lrd_slow
    b L973
    .p2align 4
Lfcb_08:
    lsr r3, r9, #8
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L974
L975:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L974:
    lsr r0, r6, #16
    bl Lrd_slow
    b L975
    .p2align 4
Lfcb_09:
    uxtb r3, r9
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L976
L977:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L976:
    lsr r0, r6, #16
    bl Lrd_slow
    b L977
    .p2align 4
Lfcb_0A:
    lsr r3, r10, #8
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L978
L979:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L978:
    lsr r0, r6, #16
    bl Lrd_slow
    b L979
    .p2align 4
Lfcb_0B:
    uxtb r3, r10
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L980
L981:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L980:
    lsr r0, r6, #16
    bl Lrd_slow
    b L981
    .p2align 4
Lfcb_0C:
    lsr r3, r11, #8
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L982
L983:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L982:
    lsr r0, r6, #16
    bl Lrd_slow
    b L983
    .p2align 4
Lfcb_0D:
    uxtb r3, r11
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L984
L985:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L984:
    lsr r0, r6, #16
    bl Lrd_slow
    b L985
    .p2align 4
Lfcb_0E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L986
L987:
    ldrb r1, [r3, r0]
    and lr, r1, #1
    lsr ip, r1, #1
    orr ip, ip, lr, lsl #7
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L988
    strb r1, [ip, r0]
L989:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L990
L991:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L986:
    bl Lrd_slow
    b L987
L988:
    mov r3, r1
    bl Lwr_slow
    b L989
L990:
    lsr r0, r6, #16
    bl Lrd_slow
    b L991
    .p2align 4
Lfcb_0F:
    and lr, r7, #1
    lsr ip, r7, #1
    orr ip, ip, lr, lsl #7
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L992
L993:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L992:
    lsr r0, r6, #16
    bl Lrd_slow
    b L993
    .p2align 4
Lfcb_10:
    lsr r3, r9, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L994
L995:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L994:
    lsr r0, r6, #16
    bl Lrd_slow
    b L995
    .p2align 4
Lfcb_11:
    uxtb r3, r9
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L996
L997:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L996:
    lsr r0, r6, #16
    bl Lrd_slow
    b L997
    .p2align 4
Lfcb_12:
    lsr r3, r10, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L998
L999:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L998:
    lsr r0, r6, #16
    bl Lrd_slow
    b L999
    .p2align 4
Lfcb_13:
    uxtb r3, r10
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1000
L1001:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1000:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1001
    .p2align 4
Lfcb_14:
    lsr r3, r11, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1002
L1003:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1002:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1003
    .p2align 4
Lfcb_15:
    uxtb r3, r11
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1004
L1005:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1004:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1005
    .p2align 4
Lfcb_16:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1006
L1007:
    ldrb r1, [r3, r0]
    lsr lr, r1, #7
    lsl ip, r1, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1008
    strb r1, [ip, r0]
L1009:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1010
L1011:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1006:
    bl Lrd_slow
    b L1007
L1008:
    mov r3, r1
    bl Lwr_slow
    b L1009
L1010:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1011
    .p2align 4
Lfcb_17:
    lsr lr, r7, #7
    lsl ip, r7, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1012
L1013:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1012:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1013
    .p2align 4
Lfcb_18:
    lsr r3, r9, #8
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1014
L1015:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1014:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1015
    .p2align 4
Lfcb_19:
    uxtb r3, r9
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1016
L1017:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1016:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1017
    .p2align 4
Lfcb_1A:
    lsr r3, r10, #8
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1018
L1019:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1018:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1019
    .p2align 4
Lfcb_1B:
    uxtb r3, r10
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1020
L1021:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1020:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1021
    .p2align 4
Lfcb_1C:
    lsr r3, r11, #8
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1022
L1023:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1022:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1023
    .p2align 4
Lfcb_1D:
    uxtb r3, r11
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1024
L1025:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1024:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1025
    .p2align 4
Lfcb_1E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1026
L1027:
    ldrb r1, [r3, r0]
    and lr, r1, #1
    lsr ip, r1, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1028
    strb r1, [ip, r0]
L1029:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1030
L1031:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1026:
    bl Lrd_slow
    b L1027
L1028:
    mov r3, r1
    bl Lwr_slow
    b L1029
L1030:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1031
    .p2align 4
Lfcb_1F:
    and lr, r7, #1
    lsr ip, r7, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1032
L1033:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1032:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1033
    .p2align 4
Lfcb_20:
    lsr r3, r9, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1034
L1035:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1034:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1035
    .p2align 4
Lfcb_21:
    uxtb r3, r9
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1036
L1037:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1036:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1037
    .p2align 4
Lfcb_22:
    lsr r3, r10, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1038
L1039:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1038:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1039
    .p2align 4
Lfcb_23:
    uxtb r3, r10
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1040
L1041:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1040:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1041
    .p2align 4
Lfcb_24:
    lsr r3, r11, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1042
L1043:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1042:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1043
    .p2align 4
Lfcb_25:
    uxtb r3, r11
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1044
L1045:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1044:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1045
    .p2align 4
Lfcb_26:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1046
L1047:
    ldrb r1, [r3, r0]
    lsr lr, r1, #7
    lsl ip, r1, #1
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1048
    strb r1, [ip, r0]
L1049:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1050
L1051:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1046:
    bl Lrd_slow
    b L1047
L1048:
    mov r3, r1
    bl Lwr_slow
    b L1049
L1050:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1051
    .p2align 4
Lfcb_27:
    lsr lr, r7, #7
    lsl ip, r7, #1
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1052
L1053:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1052:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1053
    .p2align 4
Lfcb_28:
    lsr r3, r9, #8
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1054
L1055:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1054:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1055
    .p2align 4
Lfcb_29:
    uxtb r3, r9
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1056
L1057:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1056:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1057
    .p2align 4
Lfcb_2A:
    lsr r3, r10, #8
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1058
L1059:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1058:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1059
    .p2align 4
Lfcb_2B:
    uxtb r3, r10
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1060
L1061:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1060:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1061
    .p2align 4
Lfcb_2C:
    lsr r3, r11, #8
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1062
L1063:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1062:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1063
    .p2align 4
Lfcb_2D:
    uxtb r3, r11
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1064
L1065:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1064:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1065
    .p2align 4
Lfcb_2E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1066
L1067:
    ldrb r1, [r3, r0]
    and lr, r1, #1
    and ip, r1, #0x80
    orr ip, ip, r1, lsr #1
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1068
    strb r1, [ip, r0]
L1069:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1070
L1071:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1066:
    bl Lrd_slow
    b L1067
L1068:
    mov r3, r1
    bl Lwr_slow
    b L1069
L1070:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1071
    .p2align 4
Lfcb_2F:
    and lr, r7, #1
    and ip, r7, #0x80
    orr ip, ip, r7, lsr #1
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1072
L1073:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1072:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1073
    .p2align 4
Lfcb_30:
    lsr r3, r9, #8
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1074
L1075:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1074:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1075
    .p2align 4
Lfcb_31:
    uxtb r3, r9
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1076
L1077:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1076:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1077
    .p2align 4
Lfcb_32:
    lsr r3, r10, #8
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1078
L1079:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1078:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1079
    .p2align 4
Lfcb_33:
    uxtb r3, r10
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1080
L1081:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1080:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1081
    .p2align 4
Lfcb_34:
    lsr r3, r11, #8
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1082
L1083:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1082:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1083
    .p2align 4
Lfcb_35:
    uxtb r3, r11
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1084
L1085:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1084:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1085
    .p2align 4
Lfcb_36:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1086
L1087:
    ldrb r1, [r3, r0]
    mov lr, #0
    lsl ip, r1, #4
    orr ip, ip, r1, lsr #4
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1088
    strb r1, [ip, r0]
L1089:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1090
L1091:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1086:
    bl Lrd_slow
    b L1087
L1088:
    mov r3, r1
    bl Lwr_slow
    b L1089
L1090:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1091
    .p2align 4
Lfcb_37:
    mov lr, #0
    lsl ip, r7, #4
    orr ip, ip, r7, lsr #4
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1092
L1093:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1092:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1093
    .p2align 4
Lfcb_38:
    lsr r3, r9, #8
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1094
L1095:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1094:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1095
    .p2align 4
Lfcb_39:
    uxtb r3, r9
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1096
L1097:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1096:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1097
    .p2align 4
Lfcb_3A:
    lsr r3, r10, #8
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1098
L1099:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1098:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1099
    .p2align 4
Lfcb_3B:
    uxtb r3, r10
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1100
L1101:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1100:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1101
    .p2align 4
Lfcb_3C:
    lsr r3, r11, #8
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1102
L1103:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1102:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1103
    .p2align 4
Lfcb_3D:
    uxtb r3, r11
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1104
L1105:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1104:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1105
    .p2align 4
Lfcb_3E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1106
L1107:
    ldrb r1, [r3, r0]
    and lr, r1, #1
    lsr ip, r1, #1
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1108
    strb r1, [ip, r0]
L1109:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1110
L1111:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1106:
    bl Lrd_slow
    b L1107
L1108:
    mov r3, r1
    bl Lwr_slow
    b L1109
L1110:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1111
    .p2align 4
Lfcb_3F:
    and lr, r7, #1
    lsr ip, r7, #1
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1112
L1113:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1112:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1113
    .p2align 4
Lfcb_40:
    lsr r3, r9, #8
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1114
L1115:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1114:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1115
    .p2align 4
Lfcb_41:
    uxtb r3, r9
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1116
L1117:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1116:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1117
    .p2align 4
Lfcb_42:
    lsr r3, r10, #8
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1118
L1119:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1118:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1119
    .p2align 4
Lfcb_43:
    uxtb r3, r10
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1120
L1121:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1120:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1121
    .p2align 4
Lfcb_44:
    lsr r3, r11, #8
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1122
L1123:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1122:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1123
    .p2align 4
Lfcb_45:
    uxtb r3, r11
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1124
L1125:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1124:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1125
    .p2align 4
Lfcb_46:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1126
L1127:
    ldrb r1, [r3, r0]
    tst r1, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1128
L1129:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1126:
    bl Lrd_slow
    b L1127
L1128:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1129
    .p2align 4
Lfcb_47:
    tst r7, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1130
L1131:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1130:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1131
    .p2align 4
Lfcb_48:
    lsr r3, r9, #8
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1132
L1133:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1132:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1133
    .p2align 4
Lfcb_49:
    uxtb r3, r9
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1134
L1135:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1134:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1135
    .p2align 4
Lfcb_4A:
    lsr r3, r10, #8
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1136
L1137:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1136:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1137
    .p2align 4
Lfcb_4B:
    uxtb r3, r10
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1138
L1139:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1138:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1139
    .p2align 4
Lfcb_4C:
    lsr r3, r11, #8
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1140
L1141:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1140:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1141
    .p2align 4
Lfcb_4D:
    uxtb r3, r11
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1142
L1143:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1142:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1143
    .p2align 4
Lfcb_4E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1144
L1145:
    ldrb r1, [r3, r0]
    tst r1, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1146
L1147:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1144:
    bl Lrd_slow
    b L1145
L1146:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1147
    .p2align 4
Lfcb_4F:
    tst r7, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1148
L1149:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1148:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1149
    .p2align 4
Lfcb_50:
    lsr r3, r9, #8
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1150
L1151:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1150:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1151
    .p2align 4
Lfcb_51:
    uxtb r3, r9
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1152
L1153:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1152:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1153
    .p2align 4
Lfcb_52:
    lsr r3, r10, #8
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1154
L1155:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1154:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1155
    .p2align 4
Lfcb_53:
    uxtb r3, r10
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1156
L1157:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1156:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1157
    .p2align 4
Lfcb_54:
    lsr r3, r11, #8
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1158
L1159:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1158:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1159
    .p2align 4
Lfcb_55:
    uxtb r3, r11
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1160
L1161:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1160:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1161
    .p2align 4
Lfcb_56:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1162
L1163:
    ldrb r1, [r3, r0]
    tst r1, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1164
L1165:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1162:
    bl Lrd_slow
    b L1163
L1164:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1165
    .p2align 4
Lfcb_57:
    tst r7, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1166
L1167:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1166:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1167
    .p2align 4
Lfcb_58:
    lsr r3, r9, #8
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1168
L1169:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1168:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1169
    .p2align 4
Lfcb_59:
    uxtb r3, r9
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1170
L1171:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1170:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1171
    .p2align 4
Lfcb_5A:
    lsr r3, r10, #8
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1172
L1173:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1172:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1173
    .p2align 4
Lfcb_5B:
    uxtb r3, r10
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1174
L1175:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1174:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1175
    .p2align 4
Lfcb_5C:
    lsr r3, r11, #8
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1176
L1177:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1176:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1177
    .p2align 4
Lfcb_5D:
    uxtb r3, r11
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1178
L1179:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1178:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1179
    .p2align 4
Lfcb_5E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1180
L1181:
    ldrb r1, [r3, r0]
    tst r1, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1182
L1183:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1180:
    bl Lrd_slow
    b L1181
L1182:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1183
    .p2align 4
Lfcb_5F:
    tst r7, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1184
L1185:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1184:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1185
    .p2align 4
Lfcb_60:
    lsr r3, r9, #8
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1186
L1187:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1186:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1187
    .p2align 4
Lfcb_61:
    uxtb r3, r9
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1188
L1189:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1188:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1189
    .p2align 4
Lfcb_62:
    lsr r3, r10, #8
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1190
L1191:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1190:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1191
    .p2align 4
Lfcb_63:
    uxtb r3, r10
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1192
L1193:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1192:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1193
    .p2align 4
Lfcb_64:
    lsr r3, r11, #8
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1194
L1195:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1194:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1195
    .p2align 4
Lfcb_65:
    uxtb r3, r11
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1196
L1197:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1196:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1197
    .p2align 4
Lfcb_66:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1198
L1199:
    ldrb r1, [r3, r0]
    tst r1, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1200
L1201:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1198:
    bl Lrd_slow
    b L1199
L1200:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1201
    .p2align 4
Lfcb_67:
    tst r7, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1202
L1203:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1202:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1203
    .p2align 4
Lfcb_68:
    lsr r3, r9, #8
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1204
L1205:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1204:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1205
    .p2align 4
Lfcb_69:
    uxtb r3, r9
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1206
L1207:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1206:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1207
    .p2align 4
Lfcb_6A:
    lsr r3, r10, #8
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1208
L1209:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1208:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1209
    .p2align 4
Lfcb_6B:
    uxtb r3, r10
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1210
L1211:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1210:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1211
    .p2align 4
Lfcb_6C:
    lsr r3, r11, #8
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1212
L1213:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1212:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1213
    .p2align 4
Lfcb_6D:
    uxtb r3, r11
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1214
L1215:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1214:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1215
    .p2align 4
Lfcb_6E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1216
L1217:
    ldrb r1, [r3, r0]
    tst r1, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1218
L1219:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1216:
    bl Lrd_slow
    b L1217
L1218:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1219
    .p2align 4
Lfcb_6F:
    tst r7, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1220
L1221:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1220:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1221
    .p2align 4
Lfcb_70:
    lsr r3, r9, #8
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1222
L1223:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1222:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1223
    .p2align 4
Lfcb_71:
    uxtb r3, r9
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1224
L1225:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1224:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1225
    .p2align 4
Lfcb_72:
    lsr r3, r10, #8
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1226
L1227:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1226:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1227
    .p2align 4
Lfcb_73:
    uxtb r3, r10
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1228
L1229:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1228:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1229
    .p2align 4
Lfcb_74:
    lsr r3, r11, #8
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1230
L1231:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1230:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1231
    .p2align 4
Lfcb_75:
    uxtb r3, r11
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1232
L1233:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1232:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1233
    .p2align 4
Lfcb_76:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1234
L1235:
    ldrb r1, [r3, r0]
    tst r1, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1236
L1237:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1234:
    bl Lrd_slow
    b L1235
L1236:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1237
    .p2align 4
Lfcb_77:
    tst r7, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1238
L1239:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1238:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1239
    .p2align 4
Lfcb_78:
    lsr r3, r9, #8
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1240
L1241:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1240:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1241
    .p2align 4
Lfcb_79:
    uxtb r3, r9
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1242
L1243:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1242:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1243
    .p2align 4
Lfcb_7A:
    lsr r3, r10, #8
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1244
L1245:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1244:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1245
    .p2align 4
Lfcb_7B:
    uxtb r3, r10
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1246
L1247:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1246:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1247
    .p2align 4
Lfcb_7C:
    lsr r3, r11, #8
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1248
L1249:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1248:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1249
    .p2align 4
Lfcb_7D:
    uxtb r3, r11
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1250
L1251:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1250:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1251
    .p2align 4
Lfcb_7E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1252
L1253:
    ldrb r1, [r3, r0]
    tst r1, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1254
L1255:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1252:
    bl Lrd_slow
    b L1253
L1254:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1255
    .p2align 4
Lfcb_7F:
    tst r7, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1256
L1257:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1256:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1257
    .p2align 4
Lfcb_80:
    lsr r3, r9, #8
    bic ip, r3, #1
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1258
L1259:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1258:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1259
    .p2align 4
Lfcb_81:
    uxtb r3, r9
    bic ip, r3, #1
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1260
L1261:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1260:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1261
    .p2align 4
Lfcb_82:
    lsr r3, r10, #8
    bic ip, r3, #1
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1262
L1263:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1262:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1263
    .p2align 4
Lfcb_83:
    uxtb r3, r10
    bic ip, r3, #1
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1264
L1265:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1264:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1265
    .p2align 4
Lfcb_84:
    lsr r3, r11, #8
    bic ip, r3, #1
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1266
L1267:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1266:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1267
    .p2align 4
Lfcb_85:
    uxtb r3, r11
    bic ip, r3, #1
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1268
L1269:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1268:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1269
    .p2align 4
Lfcb_86:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1270
L1271:
    ldrb r1, [r3, r0]
    bic ip, r1, #1
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1272
    strb r1, [ip, r0]
L1273:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1274
L1275:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1270:
    bl Lrd_slow
    b L1271
L1272:
    mov r3, r1
    bl Lwr_slow
    b L1273
L1274:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1275
    .p2align 4
Lfcb_87:
    bic ip, r7, #1
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1276
L1277:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1276:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1277
    .p2align 4
Lfcb_88:
    lsr r3, r9, #8
    bic ip, r3, #2
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1278
L1279:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1278:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1279
    .p2align 4
Lfcb_89:
    uxtb r3, r9
    bic ip, r3, #2
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1280
L1281:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1280:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1281
    .p2align 4
Lfcb_8A:
    lsr r3, r10, #8
    bic ip, r3, #2
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1282
L1283:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1282:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1283
    .p2align 4
Lfcb_8B:
    uxtb r3, r10
    bic ip, r3, #2
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1284
L1285:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1284:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1285
    .p2align 4
Lfcb_8C:
    lsr r3, r11, #8
    bic ip, r3, #2
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1286
L1287:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1286:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1287
    .p2align 4
Lfcb_8D:
    uxtb r3, r11
    bic ip, r3, #2
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1288
L1289:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1288:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1289
    .p2align 4
Lfcb_8E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1290
L1291:
    ldrb r1, [r3, r0]
    bic ip, r1, #2
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1292
    strb r1, [ip, r0]
L1293:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1294
L1295:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1290:
    bl Lrd_slow
    b L1291
L1292:
    mov r3, r1
    bl Lwr_slow
    b L1293
L1294:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1295
    .p2align 4
Lfcb_8F:
    bic ip, r7, #2
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1296
L1297:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1296:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1297
    .p2align 4
Lfcb_90:
    lsr r3, r9, #8
    bic ip, r3, #4
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1298
L1299:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1298:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1299
    .p2align 4
Lfcb_91:
    uxtb r3, r9
    bic ip, r3, #4
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1300
L1301:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1300:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1301
    .p2align 4
Lfcb_92:
    lsr r3, r10, #8
    bic ip, r3, #4
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1302
L1303:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1302:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1303
    .p2align 4
Lfcb_93:
    uxtb r3, r10
    bic ip, r3, #4
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1304
L1305:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1304:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1305
    .p2align 4
Lfcb_94:
    lsr r3, r11, #8
    bic ip, r3, #4
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1306
L1307:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1306:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1307
    .p2align 4
Lfcb_95:
    uxtb r3, r11
    bic ip, r3, #4
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1308
L1309:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1308:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1309
    .p2align 4
Lfcb_96:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1310
L1311:
    ldrb r1, [r3, r0]
    bic ip, r1, #4
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1312
    strb r1, [ip, r0]
L1313:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1314
L1315:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1310:
    bl Lrd_slow
    b L1311
L1312:
    mov r3, r1
    bl Lwr_slow
    b L1313
L1314:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1315
    .p2align 4
Lfcb_97:
    bic ip, r7, #4
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1316
L1317:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1316:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1317
    .p2align 4
Lfcb_98:
    lsr r3, r9, #8
    bic ip, r3, #8
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1318
L1319:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1318:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1319
    .p2align 4
Lfcb_99:
    uxtb r3, r9
    bic ip, r3, #8
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1320
L1321:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1320:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1321
    .p2align 4
Lfcb_9A:
    lsr r3, r10, #8
    bic ip, r3, #8
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1322
L1323:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1322:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1323
    .p2align 4
Lfcb_9B:
    uxtb r3, r10
    bic ip, r3, #8
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1324
L1325:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1324:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1325
    .p2align 4
Lfcb_9C:
    lsr r3, r11, #8
    bic ip, r3, #8
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1326
L1327:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1326:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1327
    .p2align 4
Lfcb_9D:
    uxtb r3, r11
    bic ip, r3, #8
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1328
L1329:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1328:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1329
    .p2align 4
Lfcb_9E:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1330
L1331:
    ldrb r1, [r3, r0]
    bic ip, r1, #8
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1332
    strb r1, [ip, r0]
L1333:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1334
L1335:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1330:
    bl Lrd_slow
    b L1331
L1332:
    mov r3, r1
    bl Lwr_slow
    b L1333
L1334:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1335
    .p2align 4
Lfcb_9F:
    bic ip, r7, #8
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1336
L1337:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1336:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1337
    .p2align 4
Lfcb_A0:
    lsr r3, r9, #8
    bic ip, r3, #16
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1338
L1339:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1338:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1339
    .p2align 4
Lfcb_A1:
    uxtb r3, r9
    bic ip, r3, #16
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1340
L1341:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1340:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1341
    .p2align 4
Lfcb_A2:
    lsr r3, r10, #8
    bic ip, r3, #16
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1342
L1343:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1342:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1343
    .p2align 4
Lfcb_A3:
    uxtb r3, r10
    bic ip, r3, #16
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1344
L1345:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1344:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1345
    .p2align 4
Lfcb_A4:
    lsr r3, r11, #8
    bic ip, r3, #16
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1346
L1347:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1346:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1347
    .p2align 4
Lfcb_A5:
    uxtb r3, r11
    bic ip, r3, #16
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1348
L1349:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1348:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1349
    .p2align 4
Lfcb_A6:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1350
L1351:
    ldrb r1, [r3, r0]
    bic ip, r1, #16
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1352
    strb r1, [ip, r0]
L1353:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1354
L1355:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1350:
    bl Lrd_slow
    b L1351
L1352:
    mov r3, r1
    bl Lwr_slow
    b L1353
L1354:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1355
    .p2align 4
Lfcb_A7:
    bic ip, r7, #16
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1356
L1357:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1356:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1357
    .p2align 4
Lfcb_A8:
    lsr r3, r9, #8
    bic ip, r3, #32
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1358
L1359:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1358:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1359
    .p2align 4
Lfcb_A9:
    uxtb r3, r9
    bic ip, r3, #32
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1360
L1361:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1360:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1361
    .p2align 4
Lfcb_AA:
    lsr r3, r10, #8
    bic ip, r3, #32
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1362
L1363:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1362:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1363
    .p2align 4
Lfcb_AB:
    uxtb r3, r10
    bic ip, r3, #32
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1364
L1365:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1364:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1365
    .p2align 4
Lfcb_AC:
    lsr r3, r11, #8
    bic ip, r3, #32
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1366
L1367:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1366:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1367
    .p2align 4
Lfcb_AD:
    uxtb r3, r11
    bic ip, r3, #32
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1368
L1369:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1368:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1369
    .p2align 4
Lfcb_AE:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1370
L1371:
    ldrb r1, [r3, r0]
    bic ip, r1, #32
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1372
    strb r1, [ip, r0]
L1373:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1374
L1375:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1370:
    bl Lrd_slow
    b L1371
L1372:
    mov r3, r1
    bl Lwr_slow
    b L1373
L1374:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1375
    .p2align 4
Lfcb_AF:
    bic ip, r7, #32
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1376
L1377:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1376:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1377
    .p2align 4
Lfcb_B0:
    lsr r3, r9, #8
    bic ip, r3, #64
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1378
L1379:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1378:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1379
    .p2align 4
Lfcb_B1:
    uxtb r3, r9
    bic ip, r3, #64
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1380
L1381:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1380:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1381
    .p2align 4
Lfcb_B2:
    lsr r3, r10, #8
    bic ip, r3, #64
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1382
L1383:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1382:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1383
    .p2align 4
Lfcb_B3:
    uxtb r3, r10
    bic ip, r3, #64
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1384
L1385:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1384:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1385
    .p2align 4
Lfcb_B4:
    lsr r3, r11, #8
    bic ip, r3, #64
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1386
L1387:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1386:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1387
    .p2align 4
Lfcb_B5:
    uxtb r3, r11
    bic ip, r3, #64
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1388
L1389:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1388:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1389
    .p2align 4
Lfcb_B6:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1390
L1391:
    ldrb r1, [r3, r0]
    bic ip, r1, #64
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1392
    strb r1, [ip, r0]
L1393:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1394
L1395:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1390:
    bl Lrd_slow
    b L1391
L1392:
    mov r3, r1
    bl Lwr_slow
    b L1393
L1394:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1395
    .p2align 4
Lfcb_B7:
    bic ip, r7, #64
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1396
L1397:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1396:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1397
    .p2align 4
Lfcb_B8:
    lsr r3, r9, #8
    bic ip, r3, #128
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1398
L1399:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1398:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1399
    .p2align 4
Lfcb_B9:
    uxtb r3, r9
    bic ip, r3, #128
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1400
L1401:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1400:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1401
    .p2align 4
Lfcb_BA:
    lsr r3, r10, #8
    bic ip, r3, #128
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1402
L1403:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1402:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1403
    .p2align 4
Lfcb_BB:
    uxtb r3, r10
    bic ip, r3, #128
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1404
L1405:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1404:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1405
    .p2align 4
Lfcb_BC:
    lsr r3, r11, #8
    bic ip, r3, #128
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1406
L1407:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1406:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1407
    .p2align 4
Lfcb_BD:
    uxtb r3, r11
    bic ip, r3, #128
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1408
L1409:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1408:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1409
    .p2align 4
Lfcb_BE:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1410
L1411:
    ldrb r1, [r3, r0]
    bic ip, r1, #128
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1412
    strb r1, [ip, r0]
L1413:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1414
L1415:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1410:
    bl Lrd_slow
    b L1411
L1412:
    mov r3, r1
    bl Lwr_slow
    b L1413
L1414:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1415
    .p2align 4
Lfcb_BF:
    bic ip, r7, #128
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1416
L1417:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1416:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1417
    .p2align 4
Lfcb_C0:
    lsr r3, r9, #8
    orr ip, r3, #1
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1418
L1419:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1418:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1419
    .p2align 4
Lfcb_C1:
    uxtb r3, r9
    orr ip, r3, #1
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1420
L1421:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1420:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1421
    .p2align 4
Lfcb_C2:
    lsr r3, r10, #8
    orr ip, r3, #1
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1422
L1423:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1422:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1423
    .p2align 4
Lfcb_C3:
    uxtb r3, r10
    orr ip, r3, #1
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1424
L1425:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1424:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1425
    .p2align 4
Lfcb_C4:
    lsr r3, r11, #8
    orr ip, r3, #1
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1426
L1427:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1426:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1427
    .p2align 4
Lfcb_C5:
    uxtb r3, r11
    orr ip, r3, #1
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1428
L1429:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1428:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1429
    .p2align 4
Lfcb_C6:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1430
L1431:
    ldrb r1, [r3, r0]
    orr ip, r1, #1
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1432
    strb r1, [ip, r0]
L1433:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1434
L1435:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1430:
    bl Lrd_slow
    b L1431
L1432:
    mov r3, r1
    bl Lwr_slow
    b L1433
L1434:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1435
    .p2align 4
Lfcb_C7:
    orr ip, r7, #1
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1436
L1437:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1436:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1437
    .p2align 4
Lfcb_C8:
    lsr r3, r9, #8
    orr ip, r3, #2
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1438
L1439:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1438:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1439
    .p2align 4
Lfcb_C9:
    uxtb r3, r9
    orr ip, r3, #2
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1440
L1441:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1440:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1441
    .p2align 4
Lfcb_CA:
    lsr r3, r10, #8
    orr ip, r3, #2
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1442
L1443:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1442:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1443
    .p2align 4
Lfcb_CB:
    uxtb r3, r10
    orr ip, r3, #2
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1444
L1445:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1444:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1445
    .p2align 4
Lfcb_CC:
    lsr r3, r11, #8
    orr ip, r3, #2
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1446
L1447:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1446:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1447
    .p2align 4
Lfcb_CD:
    uxtb r3, r11
    orr ip, r3, #2
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1448
L1449:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1448:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1449
    .p2align 4
Lfcb_CE:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1450
L1451:
    ldrb r1, [r3, r0]
    orr ip, r1, #2
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1452
    strb r1, [ip, r0]
L1453:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1454
L1455:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1450:
    bl Lrd_slow
    b L1451
L1452:
    mov r3, r1
    bl Lwr_slow
    b L1453
L1454:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1455
    .p2align 4
Lfcb_CF:
    orr ip, r7, #2
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1456
L1457:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1456:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1457
    .p2align 4
Lfcb_D0:
    lsr r3, r9, #8
    orr ip, r3, #4
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1458
L1459:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1458:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1459
    .p2align 4
Lfcb_D1:
    uxtb r3, r9
    orr ip, r3, #4
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1460
L1461:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1460:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1461
    .p2align 4
Lfcb_D2:
    lsr r3, r10, #8
    orr ip, r3, #4
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1462
L1463:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1462:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1463
    .p2align 4
Lfcb_D3:
    uxtb r3, r10
    orr ip, r3, #4
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1464
L1465:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1464:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1465
    .p2align 4
Lfcb_D4:
    lsr r3, r11, #8
    orr ip, r3, #4
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1466
L1467:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1466:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1467
    .p2align 4
Lfcb_D5:
    uxtb r3, r11
    orr ip, r3, #4
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1468
L1469:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1468:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1469
    .p2align 4
Lfcb_D6:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1470
L1471:
    ldrb r1, [r3, r0]
    orr ip, r1, #4
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1472
    strb r1, [ip, r0]
L1473:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1474
L1475:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1470:
    bl Lrd_slow
    b L1471
L1472:
    mov r3, r1
    bl Lwr_slow
    b L1473
L1474:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1475
    .p2align 4
Lfcb_D7:
    orr ip, r7, #4
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1476
L1477:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1476:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1477
    .p2align 4
Lfcb_D8:
    lsr r3, r9, #8
    orr ip, r3, #8
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1478
L1479:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1478:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1479
    .p2align 4
Lfcb_D9:
    uxtb r3, r9
    orr ip, r3, #8
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1480
L1481:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1480:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1481
    .p2align 4
Lfcb_DA:
    lsr r3, r10, #8
    orr ip, r3, #8
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1482
L1483:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1482:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1483
    .p2align 4
Lfcb_DB:
    uxtb r3, r10
    orr ip, r3, #8
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1484
L1485:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1484:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1485
    .p2align 4
Lfcb_DC:
    lsr r3, r11, #8
    orr ip, r3, #8
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1486
L1487:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1486:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1487
    .p2align 4
Lfcb_DD:
    uxtb r3, r11
    orr ip, r3, #8
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1488
L1489:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1488:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1489
    .p2align 4
Lfcb_DE:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1490
L1491:
    ldrb r1, [r3, r0]
    orr ip, r1, #8
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1492
    strb r1, [ip, r0]
L1493:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1494
L1495:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1490:
    bl Lrd_slow
    b L1491
L1492:
    mov r3, r1
    bl Lwr_slow
    b L1493
L1494:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1495
    .p2align 4
Lfcb_DF:
    orr ip, r7, #8
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1496
L1497:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1496:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1497
    .p2align 4
Lfcb_E0:
    lsr r3, r9, #8
    orr ip, r3, #16
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1498
L1499:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1498:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1499
    .p2align 4
Lfcb_E1:
    uxtb r3, r9
    orr ip, r3, #16
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1500
L1501:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1500:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1501
    .p2align 4
Lfcb_E2:
    lsr r3, r10, #8
    orr ip, r3, #16
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1502
L1503:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1502:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1503
    .p2align 4
Lfcb_E3:
    uxtb r3, r10
    orr ip, r3, #16
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1504
L1505:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1504:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1505
    .p2align 4
Lfcb_E4:
    lsr r3, r11, #8
    orr ip, r3, #16
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1506
L1507:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1506:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1507
    .p2align 4
Lfcb_E5:
    uxtb r3, r11
    orr ip, r3, #16
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1508
L1509:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1508:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1509
    .p2align 4
Lfcb_E6:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1510
L1511:
    ldrb r1, [r3, r0]
    orr ip, r1, #16
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1512
    strb r1, [ip, r0]
L1513:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1514
L1515:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1510:
    bl Lrd_slow
    b L1511
L1512:
    mov r3, r1
    bl Lwr_slow
    b L1513
L1514:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1515
    .p2align 4
Lfcb_E7:
    orr ip, r7, #16
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1516
L1517:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1516:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1517
    .p2align 4
Lfcb_E8:
    lsr r3, r9, #8
    orr ip, r3, #32
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1518
L1519:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1518:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1519
    .p2align 4
Lfcb_E9:
    uxtb r3, r9
    orr ip, r3, #32
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1520
L1521:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1520:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1521
    .p2align 4
Lfcb_EA:
    lsr r3, r10, #8
    orr ip, r3, #32
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1522
L1523:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1522:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1523
    .p2align 4
Lfcb_EB:
    uxtb r3, r10
    orr ip, r3, #32
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1524
L1525:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1524:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1525
    .p2align 4
Lfcb_EC:
    lsr r3, r11, #8
    orr ip, r3, #32
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1526
L1527:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1526:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1527
    .p2align 4
Lfcb_ED:
    uxtb r3, r11
    orr ip, r3, #32
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1528
L1529:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1528:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1529
    .p2align 4
Lfcb_EE:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1530
L1531:
    ldrb r1, [r3, r0]
    orr ip, r1, #32
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1532
    strb r1, [ip, r0]
L1533:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1534
L1535:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1530:
    bl Lrd_slow
    b L1531
L1532:
    mov r3, r1
    bl Lwr_slow
    b L1533
L1534:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1535
    .p2align 4
Lfcb_EF:
    orr ip, r7, #32
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1536
L1537:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1536:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1537
    .p2align 4
Lfcb_F0:
    lsr r3, r9, #8
    orr ip, r3, #64
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1538
L1539:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1538:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1539
    .p2align 4
Lfcb_F1:
    uxtb r3, r9
    orr ip, r3, #64
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1540
L1541:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1540:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1541
    .p2align 4
Lfcb_F2:
    lsr r3, r10, #8
    orr ip, r3, #64
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1542
L1543:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1542:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1543
    .p2align 4
Lfcb_F3:
    uxtb r3, r10
    orr ip, r3, #64
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1544
L1545:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1544:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1545
    .p2align 4
Lfcb_F4:
    lsr r3, r11, #8
    orr ip, r3, #64
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1546
L1547:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1546:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1547
    .p2align 4
Lfcb_F5:
    uxtb r3, r11
    orr ip, r3, #64
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1548
L1549:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1548:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1549
    .p2align 4
Lfcb_F6:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1550
L1551:
    ldrb r1, [r3, r0]
    orr ip, r1, #64
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1552
    strb r1, [ip, r0]
L1553:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1554
L1555:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1550:
    bl Lrd_slow
    b L1551
L1552:
    mov r3, r1
    bl Lwr_slow
    b L1553
L1554:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1555
    .p2align 4
Lfcb_F7:
    orr ip, r7, #64
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1556
L1557:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1556:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1557
    .p2align 4
Lfcb_F8:
    lsr r3, r9, #8
    orr ip, r3, #128
    bfi r9, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1558
L1559:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1558:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1559
    .p2align 4
Lfcb_F9:
    uxtb r3, r9
    orr ip, r3, #128
    bfi r9, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1560
L1561:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1560:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1561
    .p2align 4
Lfcb_FA:
    lsr r3, r10, #8
    orr ip, r3, #128
    bfi r10, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1562
L1563:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1562:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1563
    .p2align 4
Lfcb_FB:
    uxtb r3, r10
    orr ip, r3, #128
    bfi r10, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1564
L1565:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1564:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1565
    .p2align 4
Lfcb_FC:
    lsr r3, r11, #8
    orr ip, r3, #128
    bfi r11, ip, #8, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1566
L1567:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1566:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1567
    .p2align 4
Lfcb_FD:
    uxtb r3, r11
    orr ip, r3, #128
    bfi r11, ip, #0, #8
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1568
L1569:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1568:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1569
    .p2align 4
Lfcb_FE:
    mov r0, r11
    sub r5, r5, #4
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1570
L1571:
    ldrb r1, [r3, r0]
    orr ip, r1, #128
    and r1, ip, #0xFF
    sub r5, r5, #4
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1572
    strb r1, [ip, r0]
L1573:
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1574
L1575:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1570:
    bl Lrd_slow
    b L1571
L1572:
    mov r3, r1
    bl Lwr_slow
    b L1573
L1574:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1575
    .p2align 4
Lfcb_FF:
    orr ip, r7, #128
    and r7, ip, #0xFF
    cmp r5, #0
    ble Lslow_top
    ldr ip, [sp, #4]
    ldrb ip, [ip, r6, lsr #16]
    cmp ip, #0
    bne Lslow_top
    ldr ip, [sp, #28]
    subs ip, ip, #1
    str ip, [sp, #28]
    bmi Lexit_budget
    sub r5, r5, #4
    lsr ip, r6, #28
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1576
L1577:
    ldrb r0, [r3, r6, lsr #16]
    add r6, r6, #0x10000
    ldr ip, [sp, #8]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1576:
    lsr r0, r6, #16
    bl Lrd_slow
    b L1577
    .p2align 4
Lc_00:
    b Lnext
    .p2align 4
Lc_01:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1578
L1579:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1580
L1581:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1582
L1583:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1584
L1585:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r9, r2
    b Lnext
L1578:
    bl Ltick_slow4
    b L1579
L1580:
    bl Lrd_slow
    b L1581
L1582:
    bl Ltick_slow4
    b L1583
L1584:
    bl Lrd_slow
    b L1585
    .p2align 4
Lc_02:
    mov r0, r9
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1586
L1587:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1588
    strb r7, [ip, r0]
L1589:
    b Lnext
L1586:
    bl Ltick_slow4
    b L1587
L1588:
    mov r3, r7
    bl Lwr_slow
    b L1589
    .p2align 4
Lc_03:
    add r9, r9, #1
    uxth r9, r9
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1590
L1591:
    b Lnext
L1590:
    bl Ltick_slow4
    b L1591
    .p2align 4
Lc_04:
    lsr r3, r9, #8
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_05:
    lsr r3, r9, #8
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_06:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1592
L1593:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1594
L1595:
    ldrb ip, [r3, r0]
    bfi r9, ip, #8, #8
    add r6, r6, #0x10000
    b Lnext
L1592:
    bl Ltick_slow4
    b L1593
L1594:
    bl Lrd_slow
    b L1595
    .p2align 4
Lc_07:
    lsr r3, r7, #7
    lsl r7, r7, #1
    orr r7, r7, r3
    and r7, r7, #0xFF
    lsl r8, r3, #4
    b Lnext
    .p2align 4
Lc_08:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1596
L1597:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1598
L1599:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1600
L1601:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1602
L1603:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r0, r2
    uxtb r1, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1604
L1605:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1606
    strb r1, [ip, r0]
L1607:
    add r0, r2, #1
    uxth r0, r0
    ubfx r1, r6, #8, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1608
L1609:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1610
    strb r1, [ip, r0]
L1611:
    b Lnext
L1596:
    bl Ltick_slow4
    b L1597
L1598:
    bl Lrd_slow
    b L1599
L1600:
    bl Ltick_slow4
    b L1601
L1602:
    bl Lrd_slow
    b L1603
L1604:
    bl Ltick_slow4
    b L1605
L1606:
    mov r3, r1
    bl Lwr_slow
    b L1607
L1608:
    bl Ltick_slow4
    b L1609
L1610:
    mov r3, r1
    bl Lwr_slow
    b L1611
    .p2align 4
Lc_09:
    add ip, r11, r9
    eor lr, r11, r9
    eor lr, lr, ip
    and r8, r8, #0x80
    tst lr, #0x1000
    orrne r8, r8, #0x20
    tst lr, #0x10000
    orrne r8, r8, #0x10
    uxth r11, ip
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1612
L1613:
    b Lnext
L1612:
    bl Ltick_slow4
    b L1613
    .p2align 4
Lc_0A:
    mov r0, r9
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1614
L1615:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1616
L1617:
    ldrb r7, [r3, r0]
    b Lnext
L1614:
    bl Ltick_slow4
    b L1615
L1616:
    bl Lrd_slow
    b L1617
    .p2align 4
Lc_0B:
    sub r9, r9, #1
    uxth r9, r9
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1618
L1619:
    b Lnext
L1618:
    bl Ltick_slow4
    b L1619
    .p2align 4
Lc_0C:
    uxtb r3, r9
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_0D:
    uxtb r3, r9
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_0E:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1620
L1621:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1622
L1623:
    ldrb ip, [r3, r0]
    bfi r9, ip, #0, #8
    add r6, r6, #0x10000
    b Lnext
L1620:
    bl Ltick_slow4
    b L1621
L1622:
    bl Lrd_slow
    b L1623
    .p2align 4
Lc_0F:
    and r3, r7, #1
    lsr r7, r7, #1
    orr r7, r7, r3, lsl #7
    lsl r8, r3, #4
    b Lnext
    .p2align 4
Lc_10:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1624
L1625:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1626
L1627:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L1628
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L1628:
    ldr r0, [sp, #0]
    mov r1, #16
    bl gbc_asm_op
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L1629
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L1629:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L1630
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L1630:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L1631
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L1631:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L1632
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L1632:
    sub r2, r5, r2
    str r2, [sp, #56]
    b Lnext
L1624:
    bl Ltick_slow4
    b L1625
L1626:
    bl Lrd_slow
    b L1627
    .p2align 4
Lc_11:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1633
L1634:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1635
L1636:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1637
L1638:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1639
L1640:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r10, r2
    b Lnext
L1633:
    bl Ltick_slow4
    b L1634
L1635:
    bl Lrd_slow
    b L1636
L1637:
    bl Ltick_slow4
    b L1638
L1639:
    bl Lrd_slow
    b L1640
    .p2align 4
Lc_12:
    mov r0, r10
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1641
L1642:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1643
    strb r7, [ip, r0]
L1644:
    b Lnext
L1641:
    bl Ltick_slow4
    b L1642
L1643:
    mov r3, r7
    bl Lwr_slow
    b L1644
    .p2align 4
Lc_13:
    add r10, r10, #1
    uxth r10, r10
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1645
L1646:
    b Lnext
L1645:
    bl Ltick_slow4
    b L1646
    .p2align 4
Lc_14:
    lsr r3, r10, #8
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_15:
    lsr r3, r10, #8
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_16:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1647
L1648:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1649
L1650:
    ldrb ip, [r3, r0]
    bfi r10, ip, #8, #8
    add r6, r6, #0x10000
    b Lnext
L1647:
    bl Ltick_slow4
    b L1648
L1649:
    bl Lrd_slow
    b L1650
    .p2align 4
Lc_17:
    lsr r3, r7, #7
    lsl r7, r7, #1
    tst r8, #0x10
    orrne r7, r7, #1
    and r7, r7, #0xFF
    lsl r8, r3, #4
    b Lnext
    .p2align 4
Lc_18:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1651
L1652:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1653
L1654:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    sxtb ip, r1
    add r6, r6, ip, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1656
L1657:
L1655:
    b Lnext
L1651:
    bl Ltick_slow4
    b L1652
L1653:
    bl Lrd_slow
    b L1654
L1656:
    bl Ltick_slow4
    b L1657
    .p2align 4
Lc_19:
    add ip, r11, r10
    eor lr, r11, r10
    eor lr, lr, ip
    and r8, r8, #0x80
    tst lr, #0x1000
    orrne r8, r8, #0x20
    tst lr, #0x10000
    orrne r8, r8, #0x10
    uxth r11, ip
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1658
L1659:
    b Lnext
L1658:
    bl Ltick_slow4
    b L1659
    .p2align 4
Lc_1A:
    mov r0, r10
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1660
L1661:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1662
L1663:
    ldrb r7, [r3, r0]
    b Lnext
L1660:
    bl Ltick_slow4
    b L1661
L1662:
    bl Lrd_slow
    b L1663
    .p2align 4
Lc_1B:
    sub r10, r10, #1
    uxth r10, r10
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1664
L1665:
    b Lnext
L1664:
    bl Ltick_slow4
    b L1665
    .p2align 4
Lc_1C:
    uxtb r3, r10
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_1D:
    uxtb r3, r10
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_1E:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1666
L1667:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1668
L1669:
    ldrb ip, [r3, r0]
    bfi r10, ip, #0, #8
    add r6, r6, #0x10000
    b Lnext
L1666:
    bl Ltick_slow4
    b L1667
L1668:
    bl Lrd_slow
    b L1669
    .p2align 4
Lc_1F:
    and r3, r7, #1
    lsr r7, r7, #1
    tst r8, #0x10
    orrne r7, r7, #0x80
    lsl r8, r3, #4
    b Lnext
    .p2align 4
Lc_20:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1670
L1671:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1672
L1673:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    tst r8, #128
    bne L1674
    sxtb ip, r1
    add r6, r6, ip, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1675
L1676:
L1674:
    b Lnext
L1670:
    bl Ltick_slow4
    b L1671
L1672:
    bl Lrd_slow
    b L1673
L1675:
    bl Ltick_slow4
    b L1676
    .p2align 4
Lc_21:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1677
L1678:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1679
L1680:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1681
L1682:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1683
L1684:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r11, r2
    b Lnext
L1677:
    bl Ltick_slow4
    b L1678
L1679:
    bl Lrd_slow
    b L1680
L1681:
    bl Ltick_slow4
    b L1682
L1683:
    bl Lrd_slow
    b L1684
    .p2align 4
Lc_22:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1685
L1686:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1687
    strb r7, [ip, r0]
L1688:
    add r11, r0, #1
    uxth r11, r11
    b Lnext
L1685:
    bl Ltick_slow4
    b L1686
L1687:
    mov r3, r7
    bl Lwr_slow
    b L1688
    .p2align 4
Lc_23:
    add r11, r11, #1
    uxth r11, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1689
L1690:
    b Lnext
L1689:
    bl Ltick_slow4
    b L1690
    .p2align 4
Lc_24:
    lsr r3, r11, #8
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_25:
    lsr r3, r11, #8
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_26:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1691
L1692:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1693
L1694:
    ldrb ip, [r3, r0]
    bfi r11, ip, #8, #8
    add r6, r6, #0x10000
    b Lnext
L1691:
    bl Ltick_slow4
    b L1692
L1693:
    bl Lrd_slow
    b L1694
    .p2align 4
Lc_27:
    mov r3, r7
    ubfx ip, r8, #4, #1
    tst r8, #0x40
    beq L1695
    tst r8, #0x20
    beq L1696
    sub r3, r3, #6
L1696:
    cmp ip, #0
    beq L1700
    sub r3, r3, #0x60
    b L1700
L1695:
    cmp ip, #0
    bne L1697
    cmp r3, #0x99
    bls L1698
L1697:
    add r3, r3, #0x60
    mov ip, #1
L1698:
    tst r8, #0x20
    bne L1699
    and lr, r3, #0xF
    cmp lr, #9
    bls L1700
L1699:
    add r3, r3, #6
L1700:
    and r7, r3, #0xFF
    and r8, r8, #0x40
    orr r8, r8, ip, lsl #4
    cmp r7, #0
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_28:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1701
L1702:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1703
L1704:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    tst r8, #128
    beq L1705
    sxtb ip, r1
    add r6, r6, ip, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1706
L1707:
L1705:
    b Lnext
L1701:
    bl Ltick_slow4
    b L1702
L1703:
    bl Lrd_slow
    b L1704
L1706:
    bl Ltick_slow4
    b L1707
    .p2align 4
Lc_29:
    add ip, r11, r11
    eor lr, r11, r11
    eor lr, lr, ip
    and r8, r8, #0x80
    tst lr, #0x1000
    orrne r8, r8, #0x20
    tst lr, #0x10000
    orrne r8, r8, #0x10
    uxth r11, ip
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1708
L1709:
    b Lnext
L1708:
    bl Ltick_slow4
    b L1709
    .p2align 4
Lc_2A:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1710
L1711:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1712
L1713:
    ldrb r7, [r3, r0]
    add r11, r0, #1
    uxth r11, r11
    b Lnext
L1710:
    bl Ltick_slow4
    b L1711
L1712:
    bl Lrd_slow
    b L1713
    .p2align 4
Lc_2B:
    sub r11, r11, #1
    uxth r11, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1714
L1715:
    b Lnext
L1714:
    bl Ltick_slow4
    b L1715
    .p2align 4
Lc_2C:
    uxtb r3, r11
    add ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_2D:
    uxtb r3, r11
    sub ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_2E:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1716
L1717:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1718
L1719:
    ldrb ip, [r3, r0]
    bfi r11, ip, #0, #8
    add r6, r6, #0x10000
    b Lnext
L1716:
    bl Ltick_slow4
    b L1717
L1718:
    bl Lrd_slow
    b L1719
    .p2align 4
Lc_2F:
    eor r7, r7, #0xFF
    orr r8, r8, #0x60
    b Lnext
    .p2align 4
Lc_30:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1720
L1721:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1722
L1723:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    tst r8, #16
    bne L1724
    sxtb ip, r1
    add r6, r6, ip, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1725
L1726:
L1724:
    b Lnext
L1720:
    bl Ltick_slow4
    b L1721
L1722:
    bl Lrd_slow
    b L1723
L1725:
    bl Ltick_slow4
    b L1726
    .p2align 4
Lc_31:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1727
L1728:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1729
L1730:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1731
L1732:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1733
L1734:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    pkhbt r6, r2, r6
    b Lnext
L1727:
    bl Ltick_slow4
    b L1728
L1729:
    bl Lrd_slow
    b L1730
L1731:
    bl Ltick_slow4
    b L1732
L1733:
    bl Lrd_slow
    b L1734
    .p2align 4
Lc_32:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1735
L1736:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1737
    strb r7, [ip, r0]
L1738:
    sub r11, r0, #1
    uxth r11, r11
    b Lnext
L1735:
    bl Ltick_slow4
    b L1736
L1737:
    mov r3, r7
    bl Lwr_slow
    b L1738
    .p2align 4
Lc_33:
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1739
L1740:
    b Lnext
L1739:
    bl Ltick_slow4
    b L1740
    .p2align 4
Lc_34:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1741
L1742:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1743
L1744:
    ldrb r1, [r3, r0]
    add ip, r1, #1
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1745
L1746:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1747
    strb r1, [ip, r0]
L1748:
    b Lnext
L1741:
    bl Ltick_slow4
    b L1742
L1743:
    bl Lrd_slow
    b L1744
L1745:
    bl Ltick_slow4
    b L1746
L1747:
    mov r3, r1
    bl Lwr_slow
    b L1748
    .p2align 4
Lc_35:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1749
L1750:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1751
L1752:
    ldrb r1, [r3, r0]
    sub ip, r1, #1
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1753
L1754:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1755
    strb r1, [ip, r0]
L1756:
    b Lnext
L1749:
    bl Ltick_slow4
    b L1750
L1751:
    bl Lrd_slow
    b L1752
L1753:
    bl Ltick_slow4
    b L1754
L1755:
    mov r3, r1
    bl Lwr_slow
    b L1756
    .p2align 4
Lc_36:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1757
L1758:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1759
L1760:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1761
L1762:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1763
    strb r1, [ip, r0]
L1764:
    b Lnext
L1757:
    bl Ltick_slow4
    b L1758
L1759:
    bl Lrd_slow
    b L1760
L1761:
    bl Ltick_slow4
    b L1762
L1763:
    mov r3, r1
    bl Lwr_slow
    b L1764
    .p2align 4
Lc_37:
    and r8, r8, #0x80
    orr r8, r8, #0x10
    b Lnext
    .p2align 4
Lc_38:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1765
L1766:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1767
L1768:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    tst r8, #16
    beq L1769
    sxtb ip, r1
    add r6, r6, ip, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1770
L1771:
L1769:
    b Lnext
L1765:
    bl Ltick_slow4
    b L1766
L1767:
    bl Lrd_slow
    b L1768
L1770:
    bl Ltick_slow4
    b L1771
    .p2align 4
Lc_39:
    uxth r3, r6
    add ip, r11, r3
    eor lr, r11, r3
    eor lr, lr, ip
    and r8, r8, #0x80
    tst lr, #0x1000
    orrne r8, r8, #0x20
    tst lr, #0x10000
    orrne r8, r8, #0x10
    uxth r11, ip
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1772
L1773:
    b Lnext
L1772:
    bl Ltick_slow4
    b L1773
    .p2align 4
Lc_3A:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1774
L1775:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1776
L1777:
    ldrb r7, [r3, r0]
    sub r11, r0, #1
    uxth r11, r11
    b Lnext
L1774:
    bl Ltick_slow4
    b L1775
L1776:
    bl Lrd_slow
    b L1777
    .p2align 4
Lc_3B:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1778
L1779:
    b Lnext
L1778:
    bl Ltick_slow4
    b L1779
    .p2align 4
Lc_3C:
    add ip, r7, #1
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    and r8, r8, #0x10
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #0
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_3D:
    sub ip, r7, #1
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    and r8, r8, #0x10
    orr r8, r8, #0x40
    cmp ip, #0
    orreq r8, r8, #0x80
    and lr, ip, #0xF
    cmp lr, #15
    orreq r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_3E:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1780
L1781:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1782
L1783:
    ldrb r7, [r3, r0]
    add r6, r6, #0x10000
    b Lnext
L1780:
    bl Ltick_slow4
    b L1781
L1782:
    bl Lrd_slow
    b L1783
    .p2align 4
Lc_3F:
    and r8, r8, #0x90
    eor r8, r8, #0x10
    b Lnext
    .p2align 4
Lc_40:
    b Lnext
    .p2align 4
Lc_41:
    uxtb r3, r9
    bfi r9, r3, #8, #8
    b Lnext
    .p2align 4
Lc_42:
    lsr r3, r10, #8
    bfi r9, r3, #8, #8
    b Lnext
    .p2align 4
Lc_43:
    uxtb r3, r10
    bfi r9, r3, #8, #8
    b Lnext
    .p2align 4
Lc_44:
    lsr r3, r11, #8
    bfi r9, r3, #8, #8
    b Lnext
    .p2align 4
Lc_45:
    uxtb r3, r11
    bfi r9, r3, #8, #8
    b Lnext
    .p2align 4
Lc_46:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1784
L1785:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1786
L1787:
    ldrb ip, [r3, r0]
    bfi r9, ip, #8, #8
    b Lnext
L1784:
    bl Ltick_slow4
    b L1785
L1786:
    bl Lrd_slow
    b L1787
    .p2align 4
Lc_47:
    bfi r9, r7, #8, #8
    b Lnext
    .p2align 4
Lc_48:
    lsr r3, r9, #8
    bfi r9, r3, #0, #8
    b Lnext
    .p2align 4
Lc_49:
    b Lnext
    .p2align 4
Lc_4A:
    lsr r3, r10, #8
    bfi r9, r3, #0, #8
    b Lnext
    .p2align 4
Lc_4B:
    uxtb r3, r10
    bfi r9, r3, #0, #8
    b Lnext
    .p2align 4
Lc_4C:
    lsr r3, r11, #8
    bfi r9, r3, #0, #8
    b Lnext
    .p2align 4
Lc_4D:
    uxtb r3, r11
    bfi r9, r3, #0, #8
    b Lnext
    .p2align 4
Lc_4E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1788
L1789:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1790
L1791:
    ldrb ip, [r3, r0]
    bfi r9, ip, #0, #8
    b Lnext
L1788:
    bl Ltick_slow4
    b L1789
L1790:
    bl Lrd_slow
    b L1791
    .p2align 4
Lc_4F:
    bfi r9, r7, #0, #8
    b Lnext
    .p2align 4
Lc_50:
    lsr r3, r9, #8
    bfi r10, r3, #8, #8
    b Lnext
    .p2align 4
Lc_51:
    uxtb r3, r9
    bfi r10, r3, #8, #8
    b Lnext
    .p2align 4
Lc_52:
    b Lnext
    .p2align 4
Lc_53:
    uxtb r3, r10
    bfi r10, r3, #8, #8
    b Lnext
    .p2align 4
Lc_54:
    lsr r3, r11, #8
    bfi r10, r3, #8, #8
    b Lnext
    .p2align 4
Lc_55:
    uxtb r3, r11
    bfi r10, r3, #8, #8
    b Lnext
    .p2align 4
Lc_56:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1792
L1793:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1794
L1795:
    ldrb ip, [r3, r0]
    bfi r10, ip, #8, #8
    b Lnext
L1792:
    bl Ltick_slow4
    b L1793
L1794:
    bl Lrd_slow
    b L1795
    .p2align 4
Lc_57:
    bfi r10, r7, #8, #8
    b Lnext
    .p2align 4
Lc_58:
    lsr r3, r9, #8
    bfi r10, r3, #0, #8
    b Lnext
    .p2align 4
Lc_59:
    uxtb r3, r9
    bfi r10, r3, #0, #8
    b Lnext
    .p2align 4
Lc_5A:
    lsr r3, r10, #8
    bfi r10, r3, #0, #8
    b Lnext
    .p2align 4
Lc_5B:
    b Lnext
    .p2align 4
Lc_5C:
    lsr r3, r11, #8
    bfi r10, r3, #0, #8
    b Lnext
    .p2align 4
Lc_5D:
    uxtb r3, r11
    bfi r10, r3, #0, #8
    b Lnext
    .p2align 4
Lc_5E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1796
L1797:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1798
L1799:
    ldrb ip, [r3, r0]
    bfi r10, ip, #0, #8
    b Lnext
L1796:
    bl Ltick_slow4
    b L1797
L1798:
    bl Lrd_slow
    b L1799
    .p2align 4
Lc_5F:
    bfi r10, r7, #0, #8
    b Lnext
    .p2align 4
Lc_60:
    lsr r3, r9, #8
    bfi r11, r3, #8, #8
    b Lnext
    .p2align 4
Lc_61:
    uxtb r3, r9
    bfi r11, r3, #8, #8
    b Lnext
    .p2align 4
Lc_62:
    lsr r3, r10, #8
    bfi r11, r3, #8, #8
    b Lnext
    .p2align 4
Lc_63:
    uxtb r3, r10
    bfi r11, r3, #8, #8
    b Lnext
    .p2align 4
Lc_64:
    b Lnext
    .p2align 4
Lc_65:
    uxtb r3, r11
    bfi r11, r3, #8, #8
    b Lnext
    .p2align 4
Lc_66:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1800
L1801:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1802
L1803:
    ldrb ip, [r3, r0]
    bfi r11, ip, #8, #8
    b Lnext
L1800:
    bl Ltick_slow4
    b L1801
L1802:
    bl Lrd_slow
    b L1803
    .p2align 4
Lc_67:
    bfi r11, r7, #8, #8
    b Lnext
    .p2align 4
Lc_68:
    lsr r3, r9, #8
    bfi r11, r3, #0, #8
    b Lnext
    .p2align 4
Lc_69:
    uxtb r3, r9
    bfi r11, r3, #0, #8
    b Lnext
    .p2align 4
Lc_6A:
    lsr r3, r10, #8
    bfi r11, r3, #0, #8
    b Lnext
    .p2align 4
Lc_6B:
    uxtb r3, r10
    bfi r11, r3, #0, #8
    b Lnext
    .p2align 4
Lc_6C:
    lsr r3, r11, #8
    bfi r11, r3, #0, #8
    b Lnext
    .p2align 4
Lc_6D:
    b Lnext
    .p2align 4
Lc_6E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1804
L1805:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1806
L1807:
    ldrb ip, [r3, r0]
    bfi r11, ip, #0, #8
    b Lnext
L1804:
    bl Ltick_slow4
    b L1805
L1806:
    bl Lrd_slow
    b L1807
    .p2align 4
Lc_6F:
    bfi r11, r7, #0, #8
    b Lnext
    .p2align 4
Lc_70:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1808
L1809:
    lsr r3, r9, #8
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1810
    strb r3, [ip, r0]
L1811:
    b Lnext
L1808:
    bl Ltick_slow4
    b L1809
L1810:
    bl Lwr_slow
    b L1811
    .p2align 4
Lc_71:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1812
L1813:
    uxtb r3, r9
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1814
    strb r3, [ip, r0]
L1815:
    b Lnext
L1812:
    bl Ltick_slow4
    b L1813
L1814:
    bl Lwr_slow
    b L1815
    .p2align 4
Lc_72:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1816
L1817:
    lsr r3, r10, #8
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1818
    strb r3, [ip, r0]
L1819:
    b Lnext
L1816:
    bl Ltick_slow4
    b L1817
L1818:
    bl Lwr_slow
    b L1819
    .p2align 4
Lc_73:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1820
L1821:
    uxtb r3, r10
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1822
    strb r3, [ip, r0]
L1823:
    b Lnext
L1820:
    bl Ltick_slow4
    b L1821
L1822:
    bl Lwr_slow
    b L1823
    .p2align 4
Lc_74:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1824
L1825:
    lsr r3, r11, #8
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1826
    strb r3, [ip, r0]
L1827:
    b Lnext
L1824:
    bl Ltick_slow4
    b L1825
L1826:
    bl Lwr_slow
    b L1827
    .p2align 4
Lc_75:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1828
L1829:
    uxtb r3, r11
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1830
    strb r3, [ip, r0]
L1831:
    b Lnext
L1828:
    bl Ltick_slow4
    b L1829
L1830:
    bl Lwr_slow
    b L1831
    .p2align 4
Lc_76:
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L1832
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L1832:
    ldr r0, [sp, #0]
    mov r1, #118
    bl gbc_asm_op
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L1833
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L1833:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L1834
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L1834:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L1835
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L1835:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L1836
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L1836:
    sub r2, r5, r2
    str r2, [sp, #56]
    b Lnext
    .p2align 4
Lc_77:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1837
L1838:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1839
    strb r7, [ip, r0]
L1840:
    b Lnext
L1837:
    bl Ltick_slow4
    b L1838
L1839:
    mov r3, r7
    bl Lwr_slow
    b L1840
    .p2align 4
Lc_78:
    lsr r7, r9, #8
    b Lnext
    .p2align 4
Lc_79:
    uxtb r7, r9
    b Lnext
    .p2align 4
Lc_7A:
    lsr r7, r10, #8
    b Lnext
    .p2align 4
Lc_7B:
    uxtb r7, r10
    b Lnext
    .p2align 4
Lc_7C:
    lsr r7, r11, #8
    b Lnext
    .p2align 4
Lc_7D:
    uxtb r7, r11
    b Lnext
    .p2align 4
Lc_7E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1841
L1842:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1843
L1844:
    ldrb r7, [r3, r0]
    b Lnext
L1841:
    bl Ltick_slow4
    b L1842
L1843:
    bl Lrd_slow
    b L1844
    .p2align 4
Lc_7F:
    b Lnext
    .p2align 4
Lc_80:
    lsr r3, r9, #8
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_81:
    uxtb r3, r9
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_82:
    lsr r3, r10, #8
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_83:
    uxtb r3, r10
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_84:
    lsr r3, r11, #8
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_85:
    uxtb r3, r11
    add ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_86:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1845
L1846:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1847
L1848:
    ldrb r1, [r3, r0]
    add ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
L1845:
    bl Ltick_slow4
    b L1846
L1847:
    bl Lrd_slow
    b L1848
    .p2align 4
Lc_87:
    add ip, r7, r7
    eor lr, r7, r7
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_88:
    lsr r3, r9, #8
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_89:
    uxtb r3, r9
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_8A:
    lsr r3, r10, #8
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_8B:
    uxtb r3, r10
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_8C:
    lsr r3, r11, #8
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_8D:
    uxtb r3, r11
    and lr, r8, #0x10
    add ip, r7, r3
    add ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_8E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1849
L1850:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1851
L1852:
    ldrb r1, [r3, r0]
    and lr, r8, #0x10
    add ip, r7, r1
    add ip, ip, lr, lsr #4
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
L1849:
    bl Ltick_slow4
    b L1850
L1851:
    bl Lrd_slow
    b L1852
    .p2align 4
Lc_8F:
    and lr, r8, #0x10
    add ip, r7, r7
    add ip, ip, lr, lsr #4
    eor lr, r7, r7
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lc_90:
    lsr r3, r9, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_91:
    uxtb r3, r9
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_92:
    lsr r3, r10, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_93:
    uxtb r3, r10
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_94:
    lsr r3, r11, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_95:
    uxtb r3, r11
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_96:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1853
L1854:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1855
L1856:
    ldrb r1, [r3, r0]
    sub ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
L1853:
    bl Ltick_slow4
    b L1854
L1855:
    bl Lrd_slow
    b L1856
    .p2align 4
Lc_97:
    sub ip, r7, r7
    eor lr, r7, r7
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_98:
    lsr r3, r9, #8
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_99:
    uxtb r3, r9
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_9A:
    lsr r3, r10, #8
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_9B:
    uxtb r3, r10
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_9C:
    lsr r3, r11, #8
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_9D:
    uxtb r3, r11
    and lr, r8, #0x10
    sub ip, r7, r3
    sub ip, ip, lr, lsr #4
    eor lr, r7, r3
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_9E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1857
L1858:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1859
L1860:
    ldrb r1, [r3, r0]
    and lr, r8, #0x10
    sub ip, r7, r1
    sub ip, ip, lr, lsr #4
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
L1857:
    bl Ltick_slow4
    b L1858
L1859:
    bl Lrd_slow
    b L1860
    .p2align 4
Lc_9F:
    and lr, r8, #0x10
    sub ip, r7, r7
    sub ip, ip, lr, lsr #4
    eor lr, r7, r7
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_A0:
    lsr r3, r9, #8
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_A1:
    uxtb r3, r9
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_A2:
    lsr r3, r10, #8
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_A3:
    uxtb r3, r10
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_A4:
    lsr r3, r11, #8
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_A5:
    uxtb r3, r11
    ands r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_A6:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1861
L1862:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1863
L1864:
    ldrb r1, [r3, r0]
    ands r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    b Lnext
L1861:
    bl Ltick_slow4
    b L1862
L1863:
    bl Lrd_slow
    b L1864
    .p2align 4
Lc_A7:
    ands r7, r7, r7
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    b Lnext
    .p2align 4
Lc_A8:
    lsr r3, r9, #8
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_A9:
    uxtb r3, r9
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_AA:
    lsr r3, r10, #8
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_AB:
    uxtb r3, r10
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_AC:
    lsr r3, r11, #8
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_AD:
    uxtb r3, r11
    eors r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_AE:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1865
L1866:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1867
L1868:
    ldrb r1, [r3, r0]
    eors r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    b Lnext
L1865:
    bl Ltick_slow4
    b L1866
L1867:
    bl Lrd_slow
    b L1868
    .p2align 4
Lc_AF:
    eors r7, r7, r7
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_B0:
    lsr r3, r9, #8
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_B1:
    uxtb r3, r9
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_B2:
    lsr r3, r10, #8
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_B3:
    uxtb r3, r10
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_B4:
    lsr r3, r11, #8
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_B5:
    uxtb r3, r11
    orrs r7, r7, r3
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_B6:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1869
L1870:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1871
L1872:
    ldrb r1, [r3, r0]
    orrs r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    b Lnext
L1869:
    bl Ltick_slow4
    b L1870
L1871:
    bl Lrd_slow
    b L1872
    .p2align 4
Lc_B7:
    orrs r7, r7, r7
    moveq r8, #0x80
    movne r8, #0
    b Lnext
    .p2align 4
Lc_B8:
    lsr r3, r9, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_B9:
    uxtb r3, r9
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_BA:
    lsr r3, r10, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_BB:
    uxtb r3, r10
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_BC:
    lsr r3, r11, #8
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_BD:
    uxtb r3, r11
    sub ip, r7, r3
    eor lr, r7, r3
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_BE:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1873
L1874:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1875
L1876:
    ldrb r1, [r3, r0]
    sub ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
L1873:
    bl Ltick_slow4
    b L1874
L1875:
    bl Lrd_slow
    b L1876
    .p2align 4
Lc_BF:
    sub ip, r7, r7
    eor lr, r7, r7
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
    .p2align 4
Lc_C0:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1877
L1878:
    tst r8, #128
    bne L1879
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1880
L1881:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1882
L1883:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1884
L1885:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1886
L1887:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1888
L1889:
L1879:
    b Lnext
L1877:
    bl Ltick_slow4
    b L1878
L1880:
    bl Ltick_slow4
    b L1881
L1882:
    bl Lrd_slow
    b L1883
L1884:
    bl Ltick_slow4
    b L1885
L1886:
    bl Lrd_slow
    b L1887
L1888:
    bl Ltick_slow4
    b L1889
    .p2align 4
Lc_C1:
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1890
L1891:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1892
L1893:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1894
L1895:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1896
L1897:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    mov r9, r2
    b Lnext
L1890:
    bl Ltick_slow4
    b L1891
L1892:
    bl Lrd_slow
    b L1893
L1894:
    bl Ltick_slow4
    b L1895
L1896:
    bl Lrd_slow
    b L1897
    .p2align 4
Lc_C2:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1898
L1899:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1900
L1901:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1902
L1903:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1904
L1905:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #128
    bne L1906
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1907
L1908:
L1906:
    b Lnext
L1898:
    bl Ltick_slow4
    b L1899
L1900:
    bl Lrd_slow
    b L1901
L1902:
    bl Ltick_slow4
    b L1903
L1904:
    bl Lrd_slow
    b L1905
L1907:
    bl Ltick_slow4
    b L1908
    .p2align 4
Lc_C3:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1909
L1910:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1911
L1912:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1913
L1914:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1915
L1916:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1918
L1919:
L1917:
    b Lnext
L1909:
    bl Ltick_slow4
    b L1910
L1911:
    bl Lrd_slow
    b L1912
L1913:
    bl Ltick_slow4
    b L1914
L1915:
    bl Lrd_slow
    b L1916
L1918:
    bl Ltick_slow4
    b L1919
    .p2align 4
Lc_C4:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1920
L1921:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1922
L1923:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1924
L1925:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1926
L1927:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #128
    bne L1928
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1929
L1930:
    str r2, [sp, #60]
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1931
L1932:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1933
    strb r1, [ip, r0]
L1934:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1935
L1936:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1937
    strb r2, [ip, r0]
L1938:
    ldr ip, [sp, #60]
    pkhbt r6, r6, ip, lsl #16
L1928:
    b Lnext
L1920:
    bl Ltick_slow4
    b L1921
L1922:
    bl Lrd_slow
    b L1923
L1924:
    bl Ltick_slow4
    b L1925
L1926:
    bl Lrd_slow
    b L1927
L1929:
    bl Ltick_slow4
    b L1930
L1931:
    bl Ltick_slow4
    b L1932
L1933:
    mov r3, r1
    bl Lwr_slow
    b L1934
L1935:
    bl Ltick_slow4
    b L1936
L1937:
    mov r3, r2
    bl Lwr_slow
    b L1938
    .p2align 4
Lc_C5:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1939
L1940:
    mov r2, r9
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1941
L1942:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1943
    strb r1, [ip, r0]
L1944:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1945
L1946:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1947
    strb r2, [ip, r0]
L1948:
    b Lnext
L1939:
    bl Ltick_slow4
    b L1940
L1941:
    bl Ltick_slow4
    b L1942
L1943:
    mov r3, r1
    bl Lwr_slow
    b L1944
L1945:
    bl Ltick_slow4
    b L1946
L1947:
    mov r3, r2
    bl Lwr_slow
    b L1948
    .p2align 4
Lc_C6:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1949
L1950:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1951
L1952:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    add ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
L1949:
    bl Ltick_slow4
    b L1950
L1951:
    bl Lrd_slow
    b L1952
    .p2align 4
Lc_C7:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1953
L1954:
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1955
L1956:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1957
    strb r1, [ip, r0]
L1958:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1959
L1960:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L1961
    strb r2, [ip, r0]
L1962:
    mov ip, #0
    pkhbt r6, r6, ip, lsl #16
    b Lnext
L1953:
    bl Ltick_slow4
    b L1954
L1955:
    bl Ltick_slow4
    b L1956
L1957:
    mov r3, r1
    bl Lwr_slow
    b L1958
L1959:
    bl Ltick_slow4
    b L1960
L1961:
    mov r3, r2
    bl Lwr_slow
    b L1962
    .p2align 4
Lc_C8:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1963
L1964:
    tst r8, #128
    beq L1965
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1966
L1967:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1968
L1969:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1970
L1971:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1972
L1973:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1974
L1975:
L1965:
    b Lnext
L1963:
    bl Ltick_slow4
    b L1964
L1966:
    bl Ltick_slow4
    b L1967
L1968:
    bl Lrd_slow
    b L1969
L1970:
    bl Ltick_slow4
    b L1971
L1972:
    bl Lrd_slow
    b L1973
L1974:
    bl Ltick_slow4
    b L1975
    .p2align 4
Lc_C9:
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1976
L1977:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1978
L1979:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1980
L1981:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1982
L1983:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1984
L1985:
    b Lnext
L1976:
    bl Ltick_slow4
    b L1977
L1978:
    bl Lrd_slow
    b L1979
L1980:
    bl Ltick_slow4
    b L1981
L1982:
    bl Lrd_slow
    b L1983
L1984:
    bl Ltick_slow4
    b L1985
    .p2align 4
Lc_CA:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1986
L1987:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1988
L1989:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1990
L1991:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1992
L1993:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #128
    beq L1994
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1995
L1996:
L1994:
    b Lnext
L1986:
    bl Ltick_slow4
    b L1987
L1988:
    bl Lrd_slow
    b L1989
L1990:
    bl Ltick_slow4
    b L1991
L1992:
    bl Lrd_slow
    b L1993
L1995:
    bl Ltick_slow4
    b L1996
    .p2align 4
Lc_CB:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L1997
L1998:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L1999
L2000:
    ldrb r0, [r3, r0]
    add r6, r6, #0x10000
    ldr ip, [sp, #20]
    ldr lr, [ip, r0, lsl #2]
    add pc, ip, lr
L1997:
    bl Ltick_slow4
    b L1998
L1999:
    bl Lrd_slow
    b L2000
    .p2align 4
Lc_CC:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2001
L2002:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2003
L2004:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2005
L2006:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2007
L2008:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #128
    beq L2009
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2010
L2011:
    str r2, [sp, #60]
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2012
L2013:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2014
    strb r1, [ip, r0]
L2015:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2016
L2017:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2018
    strb r2, [ip, r0]
L2019:
    ldr ip, [sp, #60]
    pkhbt r6, r6, ip, lsl #16
L2009:
    b Lnext
L2001:
    bl Ltick_slow4
    b L2002
L2003:
    bl Lrd_slow
    b L2004
L2005:
    bl Ltick_slow4
    b L2006
L2007:
    bl Lrd_slow
    b L2008
L2010:
    bl Ltick_slow4
    b L2011
L2012:
    bl Ltick_slow4
    b L2013
L2014:
    mov r3, r1
    bl Lwr_slow
    b L2015
L2016:
    bl Ltick_slow4
    b L2017
L2018:
    mov r3, r2
    bl Lwr_slow
    b L2019
    .p2align 4
Lc_CD:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2020
L2021:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2022
L2023:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2024
L2025:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2026
L2027:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2029
L2030:
    str r2, [sp, #60]
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2031
L2032:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2033
    strb r1, [ip, r0]
L2034:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2035
L2036:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2037
    strb r2, [ip, r0]
L2038:
    ldr ip, [sp, #60]
    pkhbt r6, r6, ip, lsl #16
L2028:
    b Lnext
L2020:
    bl Ltick_slow4
    b L2021
L2022:
    bl Lrd_slow
    b L2023
L2024:
    bl Ltick_slow4
    b L2025
L2026:
    bl Lrd_slow
    b L2027
L2029:
    bl Ltick_slow4
    b L2030
L2031:
    bl Ltick_slow4
    b L2032
L2033:
    mov r3, r1
    bl Lwr_slow
    b L2034
L2035:
    bl Ltick_slow4
    b L2036
L2037:
    mov r3, r2
    bl Lwr_slow
    b L2038
    .p2align 4
Lc_CE:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2039
L2040:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2041
L2042:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    and lr, r8, #0x10
    add ip, r7, r1
    add ip, ip, lr, lsr #4
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    b Lnext
L2039:
    bl Ltick_slow4
    b L2040
L2041:
    bl Lrd_slow
    b L2042
    .p2align 4
Lc_CF:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2043
L2044:
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2045
L2046:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2047
    strb r1, [ip, r0]
L2048:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2049
L2050:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2051
    strb r2, [ip, r0]
L2052:
    mov ip, #8
    pkhbt r6, r6, ip, lsl #16
    b Lnext
L2043:
    bl Ltick_slow4
    b L2044
L2045:
    bl Ltick_slow4
    b L2046
L2047:
    mov r3, r1
    bl Lwr_slow
    b L2048
L2049:
    bl Ltick_slow4
    b L2050
L2051:
    mov r3, r2
    bl Lwr_slow
    b L2052
    .p2align 4
Lc_D0:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2053
L2054:
    tst r8, #16
    bne L2055
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2056
L2057:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2058
L2059:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2060
L2061:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2062
L2063:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2064
L2065:
L2055:
    b Lnext
L2053:
    bl Ltick_slow4
    b L2054
L2056:
    bl Ltick_slow4
    b L2057
L2058:
    bl Lrd_slow
    b L2059
L2060:
    bl Ltick_slow4
    b L2061
L2062:
    bl Lrd_slow
    b L2063
L2064:
    bl Ltick_slow4
    b L2065
    .p2align 4
Lc_D1:
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2066
L2067:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2068
L2069:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2070
L2071:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2072
L2073:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    mov r10, r2
    b Lnext
L2066:
    bl Ltick_slow4
    b L2067
L2068:
    bl Lrd_slow
    b L2069
L2070:
    bl Ltick_slow4
    b L2071
L2072:
    bl Lrd_slow
    b L2073
    .p2align 4
Lc_D2:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2074
L2075:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2076
L2077:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2078
L2079:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2080
L2081:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #16
    bne L2082
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2083
L2084:
L2082:
    b Lnext
L2074:
    bl Ltick_slow4
    b L2075
L2076:
    bl Lrd_slow
    b L2077
L2078:
    bl Ltick_slow4
    b L2079
L2080:
    bl Lrd_slow
    b L2081
L2083:
    bl Ltick_slow4
    b L2084
    .p2align 4
Lc_D3:
    b Lnext
    .p2align 4
Lc_D4:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2085
L2086:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2087
L2088:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2089
L2090:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2091
L2092:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #16
    bne L2093
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2094
L2095:
    str r2, [sp, #60]
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2096
L2097:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2098
    strb r1, [ip, r0]
L2099:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2100
L2101:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2102
    strb r2, [ip, r0]
L2103:
    ldr ip, [sp, #60]
    pkhbt r6, r6, ip, lsl #16
L2093:
    b Lnext
L2085:
    bl Ltick_slow4
    b L2086
L2087:
    bl Lrd_slow
    b L2088
L2089:
    bl Ltick_slow4
    b L2090
L2091:
    bl Lrd_slow
    b L2092
L2094:
    bl Ltick_slow4
    b L2095
L2096:
    bl Ltick_slow4
    b L2097
L2098:
    mov r3, r1
    bl Lwr_slow
    b L2099
L2100:
    bl Ltick_slow4
    b L2101
L2102:
    mov r3, r2
    bl Lwr_slow
    b L2103
    .p2align 4
Lc_D5:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2104
L2105:
    mov r2, r10
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2106
L2107:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2108
    strb r1, [ip, r0]
L2109:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2110
L2111:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2112
    strb r2, [ip, r0]
L2113:
    b Lnext
L2104:
    bl Ltick_slow4
    b L2105
L2106:
    bl Ltick_slow4
    b L2107
L2108:
    mov r3, r1
    bl Lwr_slow
    b L2109
L2110:
    bl Ltick_slow4
    b L2111
L2112:
    mov r3, r2
    bl Lwr_slow
    b L2113
    .p2align 4
Lc_D6:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2114
L2115:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2116
L2117:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    sub ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
L2114:
    bl Ltick_slow4
    b L2115
L2116:
    bl Lrd_slow
    b L2117
    .p2align 4
Lc_D7:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2118
L2119:
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2120
L2121:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2122
    strb r1, [ip, r0]
L2123:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2124
L2125:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2126
    strb r2, [ip, r0]
L2127:
    mov ip, #16
    pkhbt r6, r6, ip, lsl #16
    b Lnext
L2118:
    bl Ltick_slow4
    b L2119
L2120:
    bl Ltick_slow4
    b L2121
L2122:
    mov r3, r1
    bl Lwr_slow
    b L2123
L2124:
    bl Ltick_slow4
    b L2125
L2126:
    mov r3, r2
    bl Lwr_slow
    b L2127
    .p2align 4
Lc_D8:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2128
L2129:
    tst r8, #16
    beq L2130
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2131
L2132:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2133
L2134:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2135
L2136:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2137
L2138:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2139
L2140:
L2130:
    b Lnext
L2128:
    bl Ltick_slow4
    b L2129
L2131:
    bl Ltick_slow4
    b L2132
L2133:
    bl Lrd_slow
    b L2134
L2135:
    bl Ltick_slow4
    b L2136
L2137:
    bl Lrd_slow
    b L2138
L2139:
    bl Ltick_slow4
    b L2140
    .p2align 4
Lc_D9:
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2141
L2142:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2143
L2144:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2145
L2146:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2147
L2148:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2149
L2150:
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L2151
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L2151:
    ldr r0, [sp, #0]
    mov r1, #217
    bl gbc_asm_op
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2152
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2152:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2153
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2153:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2154
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2154:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2155
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2155:
    sub r2, r5, r2
    str r2, [sp, #56]
    b Lnext
L2141:
    bl Ltick_slow4
    b L2142
L2143:
    bl Lrd_slow
    b L2144
L2145:
    bl Ltick_slow4
    b L2146
L2147:
    bl Lrd_slow
    b L2148
L2149:
    bl Ltick_slow4
    b L2150
    .p2align 4
Lc_DA:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2156
L2157:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2158
L2159:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2160
L2161:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2162
L2163:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #16
    beq L2164
    pkhbt r6, r6, r2, lsl #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2165
L2166:
L2164:
    b Lnext
L2156:
    bl Ltick_slow4
    b L2157
L2158:
    bl Lrd_slow
    b L2159
L2160:
    bl Ltick_slow4
    b L2161
L2162:
    bl Lrd_slow
    b L2163
L2165:
    bl Ltick_slow4
    b L2166
    .p2align 4
Lc_DB:
    b Lnext
    .p2align 4
Lc_DC:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2167
L2168:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2169
L2170:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2171
L2172:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2173
L2174:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    tst r8, #16
    beq L2175
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2176
L2177:
    str r2, [sp, #60]
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2178
L2179:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2180
    strb r1, [ip, r0]
L2181:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2182
L2183:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2184
    strb r2, [ip, r0]
L2185:
    ldr ip, [sp, #60]
    pkhbt r6, r6, ip, lsl #16
L2175:
    b Lnext
L2167:
    bl Ltick_slow4
    b L2168
L2169:
    bl Lrd_slow
    b L2170
L2171:
    bl Ltick_slow4
    b L2172
L2173:
    bl Lrd_slow
    b L2174
L2176:
    bl Ltick_slow4
    b L2177
L2178:
    bl Ltick_slow4
    b L2179
L2180:
    mov r3, r1
    bl Lwr_slow
    b L2181
L2182:
    bl Ltick_slow4
    b L2183
L2184:
    mov r3, r2
    bl Lwr_slow
    b L2185
    .p2align 4
Lc_DD:
    b Lnext
    .p2align 4
Lc_DE:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2186
L2187:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2188
L2189:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    and lr, r8, #0x10
    sub ip, r7, r1
    sub ip, ip, lr, lsr #4
    eor lr, r7, r1
    eor lr, lr, ip
    and r7, ip, #0xFF
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
L2186:
    bl Ltick_slow4
    b L2187
L2188:
    bl Lrd_slow
    b L2189
    .p2align 4
Lc_DF:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2190
L2191:
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2192
L2193:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2194
    strb r1, [ip, r0]
L2195:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2196
L2197:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2198
    strb r2, [ip, r0]
L2199:
    mov ip, #24
    pkhbt r6, r6, ip, lsl #16
    b Lnext
L2190:
    bl Ltick_slow4
    b L2191
L2192:
    bl Ltick_slow4
    b L2193
L2194:
    mov r3, r1
    bl Lwr_slow
    b L2195
L2196:
    bl Ltick_slow4
    b L2197
L2198:
    mov r3, r2
    bl Lwr_slow
    b L2199
    .p2align 4
Lc_E0:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2202
L2203:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2204
L2205:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    cmp r1, #0x80
    blo L2200
    cmp r1, #0xFF
    beq L2200
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2206
L2207:
    ldr r3, [r4, #136]
    orr ip, r1, #0xFF00
    strb r7, [r3, ip]
    b L2201
L2200:
    mov r0, r1
    orr r0, r0, #0xFF00
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2208
L2209:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2210
    strb r7, [ip, r0]
L2211:
L2201:
    b Lnext
L2202:
    bl Ltick_slow4
    b L2203
L2204:
    bl Lrd_slow
    b L2205
L2206:
    bl Ltick_slow4
    b L2207
L2208:
    bl Ltick_slow4
    b L2209
L2210:
    mov r3, r7
    bl Lwr_slow
    b L2211
    .p2align 4
Lc_E1:
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2212
L2213:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2214
L2215:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2216
L2217:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2218
L2219:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    mov r11, r2
    b Lnext
L2212:
    bl Ltick_slow4
    b L2213
L2214:
    bl Lrd_slow
    b L2215
L2216:
    bl Ltick_slow4
    b L2217
L2218:
    bl Lrd_slow
    b L2219
    .p2align 4
Lc_E2:
    uxtb r0, r9
    orr r0, r0, #0xFF00
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2220
L2221:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2222
    strb r7, [ip, r0]
L2223:
    b Lnext
L2220:
    bl Ltick_slow4
    b L2221
L2222:
    mov r3, r7
    bl Lwr_slow
    b L2223
    .p2align 4
Lc_E3:
    b Lnext
    .p2align 4
Lc_E4:
    b Lnext
    .p2align 4
Lc_E5:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2224
L2225:
    mov r2, r11
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2226
L2227:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2228
    strb r1, [ip, r0]
L2229:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2230
L2231:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2232
    strb r2, [ip, r0]
L2233:
    b Lnext
L2224:
    bl Ltick_slow4
    b L2225
L2226:
    bl Ltick_slow4
    b L2227
L2228:
    mov r3, r1
    bl Lwr_slow
    b L2229
L2230:
    bl Ltick_slow4
    b L2231
L2232:
    mov r3, r2
    bl Lwr_slow
    b L2233
    .p2align 4
Lc_E6:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2234
L2235:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2236
L2237:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    ands r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, #0x20
    b Lnext
L2234:
    bl Ltick_slow4
    b L2235
L2236:
    bl Lrd_slow
    b L2237
    .p2align 4
Lc_E7:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2238
L2239:
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2240
L2241:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2242
    strb r1, [ip, r0]
L2243:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2244
L2245:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2246
    strb r2, [ip, r0]
L2247:
    mov ip, #32
    pkhbt r6, r6, ip, lsl #16
    b Lnext
L2238:
    bl Ltick_slow4
    b L2239
L2240:
    bl Ltick_slow4
    b L2241
L2242:
    mov r3, r1
    bl Lwr_slow
    b L2243
L2244:
    bl Ltick_slow4
    b L2245
L2246:
    mov r3, r2
    bl Lwr_slow
    b L2247
    .p2align 4
Lc_E8:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2248
L2249:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2250
L2251:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    uxtb r3, r6
    add r3, r3, r1
    and ip, r6, #0xF
    and lr, r1, #0xF
    add ip, ip, lr
    ubfx r3, r3, #8, #1
    ubfx ip, ip, #4, #1
    lsl r8, r3, #4
    orr r8, r8, ip, lsl #5
    sxtb lr, r1
    uxth r3, r6
    add r3, r3, lr
    pkhbt r6, r3, r6
    sub r5, r5, #8
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2252
L2253:
    b Lnext
L2248:
    bl Ltick_slow4
    b L2249
L2250:
    bl Lrd_slow
    b L2251
L2252:
    bl Ltick_slow8
    b L2253
    .p2align 4
Lc_E9:
    pkhbt r6, r6, r11, lsl #16
    b Lnext
    .p2align 4
Lc_EA:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2254
L2255:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2256
L2257:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2258
L2259:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2260
L2261:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r0, r2
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2262
L2263:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2264
    strb r7, [ip, r0]
L2265:
    b Lnext
L2254:
    bl Ltick_slow4
    b L2255
L2256:
    bl Lrd_slow
    b L2257
L2258:
    bl Ltick_slow4
    b L2259
L2260:
    bl Lrd_slow
    b L2261
L2262:
    bl Ltick_slow4
    b L2263
L2264:
    mov r3, r7
    bl Lwr_slow
    b L2265
    .p2align 4
Lc_EB:
    b Lnext
    .p2align 4
Lc_EC:
    b Lnext
    .p2align 4
Lc_ED:
    b Lnext
    .p2align 4
Lc_EE:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2266
L2267:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2268
L2269:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    eors r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    b Lnext
L2266:
    bl Ltick_slow4
    b L2267
L2268:
    bl Lrd_slow
    b L2269
    .p2align 4
Lc_EF:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2270
L2271:
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2272
L2273:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2274
    strb r1, [ip, r0]
L2275:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2276
L2277:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2278
    strb r2, [ip, r0]
L2279:
    mov ip, #40
    pkhbt r6, r6, ip, lsl #16
    b Lnext
L2270:
    bl Ltick_slow4
    b L2271
L2272:
    bl Ltick_slow4
    b L2273
L2274:
    mov r3, r1
    bl Lwr_slow
    b L2275
L2276:
    bl Ltick_slow4
    b L2277
L2278:
    mov r3, r2
    bl Lwr_slow
    b L2279
    .p2align 4
Lc_F0:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2282
L2283:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2284
L2285:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    cmp r1, #0x80
    blo L2280
    cmp r1, #0xFF
    beq L2280
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2286
L2287:
    ldr r3, [r4, #136]
    orr ip, r1, #0xFF00
    ldrb r7, [r3, ip]
    b L2281
L2280:
    mov r0, r1
    orr r0, r0, #0xFF00
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2288
L2289:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2290
L2291:
    ldrb r7, [r3, r0]
L2281:
    b Lnext
L2282:
    bl Ltick_slow4
    b L2283
L2284:
    bl Lrd_slow
    b L2285
L2286:
    bl Ltick_slow4
    b L2287
L2288:
    bl Ltick_slow4
    b L2289
L2290:
    bl Lrd_slow
    b L2291
    .p2align 4
Lc_F1:
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2292
L2293:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2294
L2295:
    ldrb r1, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2296
L2297:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2298
L2299:
    ldrb r2, [r3, r0]
    uxth ip, r6
    add ip, ip, #1
    pkhbt r6, ip, r6
    orr r2, r1, r2, lsl #8
    lsr r7, r2, #8
    and r8, r2, #0xF0
    b Lnext
L2292:
    bl Ltick_slow4
    b L2293
L2294:
    bl Lrd_slow
    b L2295
L2296:
    bl Ltick_slow4
    b L2297
L2298:
    bl Lrd_slow
    b L2299
    .p2align 4
Lc_F2:
    uxtb r0, r9
    orr r0, r0, #0xFF00
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2300
L2301:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2302
L2303:
    ldrb r7, [r3, r0]
    b Lnext
L2300:
    bl Ltick_slow4
    b L2301
L2302:
    bl Lrd_slow
    b L2303
    .p2align 4
Lc_F3:
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L2304
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L2304:
    ldr r0, [sp, #0]
    mov r1, #243
    bl gbc_asm_op
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2305
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2305:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2306
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2306:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2307
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2307:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2308
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2308:
    sub r2, r5, r2
    str r2, [sp, #56]
    b Lnext
    .p2align 4
Lc_F4:
    b Lnext
    .p2align 4
Lc_F5:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2309
L2310:
    orr r2, r8, r7, lsl #8
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2311
L2312:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2313
    strb r1, [ip, r0]
L2314:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2315
L2316:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2317
    strb r2, [ip, r0]
L2318:
    b Lnext
L2309:
    bl Ltick_slow4
    b L2310
L2311:
    bl Ltick_slow4
    b L2312
L2313:
    mov r3, r1
    bl Lwr_slow
    b L2314
L2315:
    bl Ltick_slow4
    b L2316
L2317:
    mov r3, r2
    bl Lwr_slow
    b L2318
    .p2align 4
Lc_F6:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2319
L2320:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2321
L2322:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    orrs r7, r7, r1
    moveq r8, #0x80
    movne r8, #0
    b Lnext
L2319:
    bl Ltick_slow4
    b L2320
L2321:
    bl Lrd_slow
    b L2322
    .p2align 4
Lc_F7:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2323
L2324:
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2325
L2326:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2327
    strb r1, [ip, r0]
L2328:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2329
L2330:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2331
    strb r2, [ip, r0]
L2332:
    mov ip, #48
    pkhbt r6, r6, ip, lsl #16
    b Lnext
L2323:
    bl Ltick_slow4
    b L2324
L2325:
    bl Ltick_slow4
    b L2326
L2327:
    mov r3, r1
    bl Lwr_slow
    b L2328
L2329:
    bl Ltick_slow4
    b L2330
L2331:
    mov r3, r2
    bl Lwr_slow
    b L2332
    .p2align 4
Lc_F8:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2333
L2334:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2335
L2336:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    uxtb r3, r6
    add r3, r3, r1
    and ip, r6, #0xF
    and lr, r1, #0xF
    add ip, ip, lr
    ubfx r3, r3, #8, #1
    ubfx ip, ip, #4, #1
    lsl r8, r3, #4
    orr r8, r8, ip, lsl #5
    sxtb lr, r1
    uxth r3, r6
    add r3, r3, lr
    uxth r11, r3
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2337
L2338:
    b Lnext
L2333:
    bl Ltick_slow4
    b L2334
L2335:
    bl Lrd_slow
    b L2336
L2337:
    bl Ltick_slow4
    b L2338
    .p2align 4
Lc_F9:
    pkhbt r6, r11, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2339
L2340:
    b Lnext
L2339:
    bl Ltick_slow4
    b L2340
    .p2align 4
Lc_FA:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2341
L2342:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2343
L2344:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2345
L2346:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2347
L2348:
    ldrb r2, [r3, r0]
    add r6, r6, #0x10000
    orr r2, r1, r2, lsl #8
    mov r0, r2
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2349
L2350:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2351
L2352:
    ldrb r7, [r3, r0]
    b Lnext
L2341:
    bl Ltick_slow4
    b L2342
L2343:
    bl Lrd_slow
    b L2344
L2345:
    bl Ltick_slow4
    b L2346
L2347:
    bl Lrd_slow
    b L2348
L2349:
    bl Ltick_slow4
    b L2350
L2351:
    bl Lrd_slow
    b L2352
    .p2align 4
Lc_FB:
    ldr ip, [sp, #0]
    strb r7, [ip, #16]
    strb r8, [ip, #17]
    rev16 lr, r9
    strh lr, [ip, #18]
    rev16 lr, r10
    strh lr, [ip, #20]
    rev16 lr, r11
    strh lr, [ip, #22]
    strh r6, [ip, #24]
    lsr lr, r6, #16
    strh lr, [ip, #26]
    ldrb lr, [r4, #211]
    cmp lr, #0
    bne L2353
    ldr r3, [sp, #44]
    sub r3, r3, r5
    ldr lr, [sp, #36]
    adds lr, lr, r3
    str lr, [ip, #32]
    ldr r3, [sp, #40]
    adc r3, r3, #0
    str r3, [ip, #36]
    ldrh r3, [r4, #208]
    add r3, r3, lr
    movw lr, #314
    movt lr, #1
    strh r3, [ip, lr]
L2353:
    ldr r0, [sp, #0]
    mov r1, #251
    bl gbc_asm_op
    ldr ip, [sp, #0]
    ldrb r7, [ip, #16]
    ldrb r8, [ip, #17]
    ldrh lr, [ip, #18]
    rev16 r9, lr
    ldrh lr, [ip, #20]
    rev16 r10, lr
    ldrh lr, [ip, #22]
    rev16 r11, lr
    ldrh lr, [ip, #24]
    ldrh r3, [ip, #26]
    orr r6, lr, r3, lsl #16
    ldr r0, [ip, #32]
    ldr r1, [ip, #36]
    str r0, [sp, #36]
    str r1, [sp, #40]
    ldr r2, [r4, #176]
    ldr r3, [r4, #180]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2354
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2354:
    str r2, [sp, #44]
    mov r5, r2
    ldr r2, [r4, #152]
    ldr r3, [r4, #156]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2355
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2355:
    sub r2, r5, r2
    str r2, [sp, #48]
    ldr r2, [r4, #168]
    ldr r3, [r4, #172]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2356
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2356:
    sub r2, r5, r2
    str r2, [sp, #52]
    ldr r2, [r4, #160]
    ldr r3, [r4, #164]
    subs r2, r2, r0
    sbcs r3, r3, r1
    movlo r2, #0
    blo L2357
    cmp r3, #0
    mvnne r2, #0x80000000
    cmp r2, #0
    mvnlt r2, #0x80000000
L2357:
    sub r2, r5, r2
    str r2, [sp, #56]
    b Lnext
    .p2align 4
Lc_FC:
    b Lnext
    .p2align 4
Lc_FD:
    b Lnext
    .p2align 4
Lc_FE:
    lsr r0, r6, #16
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2358
L2359:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2360
L2361:
    ldrb r1, [r3, r0]
    add r6, r6, #0x10000
    sub ip, r7, r1
    eor lr, r7, r1
    eor lr, lr, ip
    and r8, lr, #0x10
    lsl r8, r8, #1
    tst lr, #0x100
    orrne r8, r8, #0x10
    tst ip, #0xFF
    orreq r8, r8, #0x80
    orr r8, r8, #0x40
    b Lnext
L2358:
    bl Ltick_slow4
    b L2359
L2360:
    bl Lrd_slow
    b L2361
    .p2align 4
Lc_FF:
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2362
L2363:
    lsr r2, r6, #16
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    lsr r1, r2, #8
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2364
L2365:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2366
    strb r1, [ip, r0]
L2367:
    uxth ip, r6
    sub ip, ip, #1
    pkhbt r6, ip, r6
    uxth r0, r6
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2368
L2369:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2370
    strb r2, [ip, r0]
L2371:
    mov ip, #56
    pkhbt r6, r6, ip, lsl #16
    b Lnext
L2362:
    bl Ltick_slow4
    b L2363
L2364:
    bl Ltick_slow4
    b L2365
L2366:
    mov r3, r1
    bl Lwr_slow
    b L2367
L2368:
    bl Ltick_slow4
    b L2369
L2370:
    mov r3, r2
    bl Lwr_slow
    b L2371
    .p2align 4
Lccb_00:
    lsr r3, r9, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_01:
    uxtb r3, r9
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_02:
    lsr r3, r10, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_03:
    uxtb r3, r10
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_04:
    lsr r3, r11, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_05:
    uxtb r3, r11
    lsr lr, r3, #7
    lsl ip, r3, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_06:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2372
L2373:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2374
L2375:
    ldrb r1, [r3, r0]
    lsr lr, r1, #7
    lsl ip, r1, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2376
L2377:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2378
    strb r1, [ip, r0]
L2379:
    b Lnext
L2372:
    bl Ltick_slow4
    b L2373
L2374:
    bl Lrd_slow
    b L2375
L2376:
    bl Ltick_slow4
    b L2377
L2378:
    mov r3, r1
    bl Lwr_slow
    b L2379
    .p2align 4
Lccb_07:
    lsr lr, r7, #7
    lsl ip, r7, #1
    orr ip, ip, lr
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_08:
    lsr r3, r9, #8
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_09:
    uxtb r3, r9
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_0A:
    lsr r3, r10, #8
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_0B:
    uxtb r3, r10
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_0C:
    lsr r3, r11, #8
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_0D:
    uxtb r3, r11
    and lr, r3, #1
    lsr ip, r3, #1
    orr ip, ip, lr, lsl #7
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_0E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2380
L2381:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2382
L2383:
    ldrb r1, [r3, r0]
    and lr, r1, #1
    lsr ip, r1, #1
    orr ip, ip, lr, lsl #7
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2384
L2385:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2386
    strb r1, [ip, r0]
L2387:
    b Lnext
L2380:
    bl Ltick_slow4
    b L2381
L2382:
    bl Lrd_slow
    b L2383
L2384:
    bl Ltick_slow4
    b L2385
L2386:
    mov r3, r1
    bl Lwr_slow
    b L2387
    .p2align 4
Lccb_0F:
    and lr, r7, #1
    lsr ip, r7, #1
    orr ip, ip, lr, lsl #7
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_10:
    lsr r3, r9, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_11:
    uxtb r3, r9
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_12:
    lsr r3, r10, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_13:
    uxtb r3, r10
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_14:
    lsr r3, r11, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_15:
    uxtb r3, r11
    lsr lr, r3, #7
    lsl ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_16:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2388
L2389:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2390
L2391:
    ldrb r1, [r3, r0]
    lsr lr, r1, #7
    lsl ip, r1, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2392
L2393:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2394
    strb r1, [ip, r0]
L2395:
    b Lnext
L2388:
    bl Ltick_slow4
    b L2389
L2390:
    bl Lrd_slow
    b L2391
L2392:
    bl Ltick_slow4
    b L2393
L2394:
    mov r3, r1
    bl Lwr_slow
    b L2395
    .p2align 4
Lccb_17:
    lsr lr, r7, #7
    lsl ip, r7, #1
    tst r8, #0x10
    orrne ip, ip, #1
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_18:
    lsr r3, r9, #8
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_19:
    uxtb r3, r9
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_1A:
    lsr r3, r10, #8
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_1B:
    uxtb r3, r10
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_1C:
    lsr r3, r11, #8
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_1D:
    uxtb r3, r11
    and lr, r3, #1
    lsr ip, r3, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_1E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2396
L2397:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2398
L2399:
    ldrb r1, [r3, r0]
    and lr, r1, #1
    lsr ip, r1, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2400
L2401:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2402
    strb r1, [ip, r0]
L2403:
    b Lnext
L2396:
    bl Ltick_slow4
    b L2397
L2398:
    bl Lrd_slow
    b L2399
L2400:
    bl Ltick_slow4
    b L2401
L2402:
    mov r3, r1
    bl Lwr_slow
    b L2403
    .p2align 4
Lccb_1F:
    and lr, r7, #1
    lsr ip, r7, #1
    tst r8, #0x10
    orrne ip, ip, #0x80
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_20:
    lsr r3, r9, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_21:
    uxtb r3, r9
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_22:
    lsr r3, r10, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_23:
    uxtb r3, r10
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_24:
    lsr r3, r11, #8
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_25:
    uxtb r3, r11
    lsr lr, r3, #7
    lsl ip, r3, #1
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_26:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2404
L2405:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2406
L2407:
    ldrb r1, [r3, r0]
    lsr lr, r1, #7
    lsl ip, r1, #1
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2408
L2409:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2410
    strb r1, [ip, r0]
L2411:
    b Lnext
L2404:
    bl Ltick_slow4
    b L2405
L2406:
    bl Lrd_slow
    b L2407
L2408:
    bl Ltick_slow4
    b L2409
L2410:
    mov r3, r1
    bl Lwr_slow
    b L2411
    .p2align 4
Lccb_27:
    lsr lr, r7, #7
    lsl ip, r7, #1
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_28:
    lsr r3, r9, #8
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_29:
    uxtb r3, r9
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_2A:
    lsr r3, r10, #8
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_2B:
    uxtb r3, r10
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_2C:
    lsr r3, r11, #8
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_2D:
    uxtb r3, r11
    and lr, r3, #1
    and ip, r3, #0x80
    orr ip, ip, r3, lsr #1
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_2E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2412
L2413:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2414
L2415:
    ldrb r1, [r3, r0]
    and lr, r1, #1
    and ip, r1, #0x80
    orr ip, ip, r1, lsr #1
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2416
L2417:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2418
    strb r1, [ip, r0]
L2419:
    b Lnext
L2412:
    bl Ltick_slow4
    b L2413
L2414:
    bl Lrd_slow
    b L2415
L2416:
    bl Ltick_slow4
    b L2417
L2418:
    mov r3, r1
    bl Lwr_slow
    b L2419
    .p2align 4
Lccb_2F:
    and lr, r7, #1
    and ip, r7, #0x80
    orr ip, ip, r7, lsr #1
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_30:
    lsr r3, r9, #8
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_31:
    uxtb r3, r9
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_32:
    lsr r3, r10, #8
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_33:
    uxtb r3, r10
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_34:
    lsr r3, r11, #8
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_35:
    uxtb r3, r11
    mov lr, #0
    lsl ip, r3, #4
    orr ip, ip, r3, lsr #4
    and ip, ip, #0xFF
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_36:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2420
L2421:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2422
L2423:
    ldrb r1, [r3, r0]
    mov lr, #0
    lsl ip, r1, #4
    orr ip, ip, r1, lsr #4
    and ip, ip, #0xFF
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2424
L2425:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2426
    strb r1, [ip, r0]
L2427:
    b Lnext
L2420:
    bl Ltick_slow4
    b L2421
L2422:
    bl Lrd_slow
    b L2423
L2424:
    bl Ltick_slow4
    b L2425
L2426:
    mov r3, r1
    bl Lwr_slow
    b L2427
    .p2align 4
Lccb_37:
    mov lr, #0
    lsl ip, r7, #4
    orr ip, ip, r7, lsr #4
    and ip, ip, #0xFF
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_38:
    lsr r3, r9, #8
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r9, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_39:
    uxtb r3, r9
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r9, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_3A:
    lsr r3, r10, #8
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r10, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_3B:
    uxtb r3, r10
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r10, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_3C:
    lsr r3, r11, #8
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r11, ip, #8, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_3D:
    uxtb r3, r11
    and lr, r3, #1
    lsr ip, r3, #1
    bfi r11, ip, #0, #8
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_3E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2428
L2429:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2430
L2431:
    ldrb r1, [r3, r0]
    and lr, r1, #1
    lsr ip, r1, #1
    and r1, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2432
L2433:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2434
    strb r1, [ip, r0]
L2435:
    b Lnext
L2428:
    bl Ltick_slow4
    b L2429
L2430:
    bl Lrd_slow
    b L2431
L2432:
    bl Ltick_slow4
    b L2433
L2434:
    mov r3, r1
    bl Lwr_slow
    b L2435
    .p2align 4
Lccb_3F:
    and lr, r7, #1
    lsr ip, r7, #1
    and r7, ip, #0xFF
    cmp ip, #0
    moveq r8, #0x80
    movne r8, #0
    orr r8, r8, lr, lsl #4
    b Lnext
    .p2align 4
Lccb_40:
    lsr r3, r9, #8
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_41:
    uxtb r3, r9
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_42:
    lsr r3, r10, #8
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_43:
    uxtb r3, r10
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_44:
    lsr r3, r11, #8
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_45:
    uxtb r3, r11
    tst r3, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_46:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2436
L2437:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2438
L2439:
    ldrb r1, [r3, r0]
    tst r1, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
L2436:
    bl Ltick_slow4
    b L2437
L2438:
    bl Lrd_slow
    b L2439
    .p2align 4
Lccb_47:
    tst r7, #1
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_48:
    lsr r3, r9, #8
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_49:
    uxtb r3, r9
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_4A:
    lsr r3, r10, #8
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_4B:
    uxtb r3, r10
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_4C:
    lsr r3, r11, #8
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_4D:
    uxtb r3, r11
    tst r3, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_4E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2440
L2441:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2442
L2443:
    ldrb r1, [r3, r0]
    tst r1, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
L2440:
    bl Ltick_slow4
    b L2441
L2442:
    bl Lrd_slow
    b L2443
    .p2align 4
Lccb_4F:
    tst r7, #2
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_50:
    lsr r3, r9, #8
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_51:
    uxtb r3, r9
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_52:
    lsr r3, r10, #8
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_53:
    uxtb r3, r10
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_54:
    lsr r3, r11, #8
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_55:
    uxtb r3, r11
    tst r3, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_56:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2444
L2445:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2446
L2447:
    ldrb r1, [r3, r0]
    tst r1, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
L2444:
    bl Ltick_slow4
    b L2445
L2446:
    bl Lrd_slow
    b L2447
    .p2align 4
Lccb_57:
    tst r7, #4
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_58:
    lsr r3, r9, #8
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_59:
    uxtb r3, r9
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_5A:
    lsr r3, r10, #8
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_5B:
    uxtb r3, r10
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_5C:
    lsr r3, r11, #8
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_5D:
    uxtb r3, r11
    tst r3, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_5E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2448
L2449:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2450
L2451:
    ldrb r1, [r3, r0]
    tst r1, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
L2448:
    bl Ltick_slow4
    b L2449
L2450:
    bl Lrd_slow
    b L2451
    .p2align 4
Lccb_5F:
    tst r7, #8
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_60:
    lsr r3, r9, #8
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_61:
    uxtb r3, r9
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_62:
    lsr r3, r10, #8
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_63:
    uxtb r3, r10
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_64:
    lsr r3, r11, #8
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_65:
    uxtb r3, r11
    tst r3, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_66:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2452
L2453:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2454
L2455:
    ldrb r1, [r3, r0]
    tst r1, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
L2452:
    bl Ltick_slow4
    b L2453
L2454:
    bl Lrd_slow
    b L2455
    .p2align 4
Lccb_67:
    tst r7, #16
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_68:
    lsr r3, r9, #8
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_69:
    uxtb r3, r9
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_6A:
    lsr r3, r10, #8
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_6B:
    uxtb r3, r10
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_6C:
    lsr r3, r11, #8
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_6D:
    uxtb r3, r11
    tst r3, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_6E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2456
L2457:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2458
L2459:
    ldrb r1, [r3, r0]
    tst r1, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
L2456:
    bl Ltick_slow4
    b L2457
L2458:
    bl Lrd_slow
    b L2459
    .p2align 4
Lccb_6F:
    tst r7, #32
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_70:
    lsr r3, r9, #8
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_71:
    uxtb r3, r9
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_72:
    lsr r3, r10, #8
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_73:
    uxtb r3, r10
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_74:
    lsr r3, r11, #8
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_75:
    uxtb r3, r11
    tst r3, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_76:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2460
L2461:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2462
L2463:
    ldrb r1, [r3, r0]
    tst r1, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
L2460:
    bl Ltick_slow4
    b L2461
L2462:
    bl Lrd_slow
    b L2463
    .p2align 4
Lccb_77:
    tst r7, #64
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_78:
    lsr r3, r9, #8
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_79:
    uxtb r3, r9
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_7A:
    lsr r3, r10, #8
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_7B:
    uxtb r3, r10
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_7C:
    lsr r3, r11, #8
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_7D:
    uxtb r3, r11
    tst r3, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_7E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2464
L2465:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2466
L2467:
    ldrb r1, [r3, r0]
    tst r1, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
L2464:
    bl Ltick_slow4
    b L2465
L2466:
    bl Lrd_slow
    b L2467
    .p2align 4
Lccb_7F:
    tst r7, #128
    and r8, r8, #0x10
    orr r8, r8, #0x20
    orreq r8, r8, #0x80
    b Lnext
    .p2align 4
Lccb_80:
    lsr r3, r9, #8
    bic ip, r3, #1
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_81:
    uxtb r3, r9
    bic ip, r3, #1
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_82:
    lsr r3, r10, #8
    bic ip, r3, #1
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_83:
    uxtb r3, r10
    bic ip, r3, #1
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_84:
    lsr r3, r11, #8
    bic ip, r3, #1
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_85:
    uxtb r3, r11
    bic ip, r3, #1
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_86:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2468
L2469:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2470
L2471:
    ldrb r1, [r3, r0]
    bic ip, r1, #1
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2472
L2473:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2474
    strb r1, [ip, r0]
L2475:
    b Lnext
L2468:
    bl Ltick_slow4
    b L2469
L2470:
    bl Lrd_slow
    b L2471
L2472:
    bl Ltick_slow4
    b L2473
L2474:
    mov r3, r1
    bl Lwr_slow
    b L2475
    .p2align 4
Lccb_87:
    bic ip, r7, #1
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_88:
    lsr r3, r9, #8
    bic ip, r3, #2
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_89:
    uxtb r3, r9
    bic ip, r3, #2
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_8A:
    lsr r3, r10, #8
    bic ip, r3, #2
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_8B:
    uxtb r3, r10
    bic ip, r3, #2
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_8C:
    lsr r3, r11, #8
    bic ip, r3, #2
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_8D:
    uxtb r3, r11
    bic ip, r3, #2
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_8E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2476
L2477:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2478
L2479:
    ldrb r1, [r3, r0]
    bic ip, r1, #2
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2480
L2481:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2482
    strb r1, [ip, r0]
L2483:
    b Lnext
L2476:
    bl Ltick_slow4
    b L2477
L2478:
    bl Lrd_slow
    b L2479
L2480:
    bl Ltick_slow4
    b L2481
L2482:
    mov r3, r1
    bl Lwr_slow
    b L2483
    .p2align 4
Lccb_8F:
    bic ip, r7, #2
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_90:
    lsr r3, r9, #8
    bic ip, r3, #4
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_91:
    uxtb r3, r9
    bic ip, r3, #4
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_92:
    lsr r3, r10, #8
    bic ip, r3, #4
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_93:
    uxtb r3, r10
    bic ip, r3, #4
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_94:
    lsr r3, r11, #8
    bic ip, r3, #4
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_95:
    uxtb r3, r11
    bic ip, r3, #4
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_96:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2484
L2485:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2486
L2487:
    ldrb r1, [r3, r0]
    bic ip, r1, #4
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2488
L2489:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2490
    strb r1, [ip, r0]
L2491:
    b Lnext
L2484:
    bl Ltick_slow4
    b L2485
L2486:
    bl Lrd_slow
    b L2487
L2488:
    bl Ltick_slow4
    b L2489
L2490:
    mov r3, r1
    bl Lwr_slow
    b L2491
    .p2align 4
Lccb_97:
    bic ip, r7, #4
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_98:
    lsr r3, r9, #8
    bic ip, r3, #8
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_99:
    uxtb r3, r9
    bic ip, r3, #8
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_9A:
    lsr r3, r10, #8
    bic ip, r3, #8
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_9B:
    uxtb r3, r10
    bic ip, r3, #8
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_9C:
    lsr r3, r11, #8
    bic ip, r3, #8
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_9D:
    uxtb r3, r11
    bic ip, r3, #8
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_9E:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2492
L2493:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2494
L2495:
    ldrb r1, [r3, r0]
    bic ip, r1, #8
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2496
L2497:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2498
    strb r1, [ip, r0]
L2499:
    b Lnext
L2492:
    bl Ltick_slow4
    b L2493
L2494:
    bl Lrd_slow
    b L2495
L2496:
    bl Ltick_slow4
    b L2497
L2498:
    mov r3, r1
    bl Lwr_slow
    b L2499
    .p2align 4
Lccb_9F:
    bic ip, r7, #8
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_A0:
    lsr r3, r9, #8
    bic ip, r3, #16
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_A1:
    uxtb r3, r9
    bic ip, r3, #16
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_A2:
    lsr r3, r10, #8
    bic ip, r3, #16
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_A3:
    uxtb r3, r10
    bic ip, r3, #16
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_A4:
    lsr r3, r11, #8
    bic ip, r3, #16
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_A5:
    uxtb r3, r11
    bic ip, r3, #16
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_A6:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2500
L2501:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2502
L2503:
    ldrb r1, [r3, r0]
    bic ip, r1, #16
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2504
L2505:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2506
    strb r1, [ip, r0]
L2507:
    b Lnext
L2500:
    bl Ltick_slow4
    b L2501
L2502:
    bl Lrd_slow
    b L2503
L2504:
    bl Ltick_slow4
    b L2505
L2506:
    mov r3, r1
    bl Lwr_slow
    b L2507
    .p2align 4
Lccb_A7:
    bic ip, r7, #16
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_A8:
    lsr r3, r9, #8
    bic ip, r3, #32
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_A9:
    uxtb r3, r9
    bic ip, r3, #32
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_AA:
    lsr r3, r10, #8
    bic ip, r3, #32
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_AB:
    uxtb r3, r10
    bic ip, r3, #32
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_AC:
    lsr r3, r11, #8
    bic ip, r3, #32
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_AD:
    uxtb r3, r11
    bic ip, r3, #32
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_AE:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2508
L2509:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2510
L2511:
    ldrb r1, [r3, r0]
    bic ip, r1, #32
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2512
L2513:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2514
    strb r1, [ip, r0]
L2515:
    b Lnext
L2508:
    bl Ltick_slow4
    b L2509
L2510:
    bl Lrd_slow
    b L2511
L2512:
    bl Ltick_slow4
    b L2513
L2514:
    mov r3, r1
    bl Lwr_slow
    b L2515
    .p2align 4
Lccb_AF:
    bic ip, r7, #32
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_B0:
    lsr r3, r9, #8
    bic ip, r3, #64
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_B1:
    uxtb r3, r9
    bic ip, r3, #64
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_B2:
    lsr r3, r10, #8
    bic ip, r3, #64
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_B3:
    uxtb r3, r10
    bic ip, r3, #64
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_B4:
    lsr r3, r11, #8
    bic ip, r3, #64
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_B5:
    uxtb r3, r11
    bic ip, r3, #64
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_B6:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2516
L2517:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2518
L2519:
    ldrb r1, [r3, r0]
    bic ip, r1, #64
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2520
L2521:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2522
    strb r1, [ip, r0]
L2523:
    b Lnext
L2516:
    bl Ltick_slow4
    b L2517
L2518:
    bl Lrd_slow
    b L2519
L2520:
    bl Ltick_slow4
    b L2521
L2522:
    mov r3, r1
    bl Lwr_slow
    b L2523
    .p2align 4
Lccb_B7:
    bic ip, r7, #64
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_B8:
    lsr r3, r9, #8
    bic ip, r3, #128
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_B9:
    uxtb r3, r9
    bic ip, r3, #128
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_BA:
    lsr r3, r10, #8
    bic ip, r3, #128
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_BB:
    uxtb r3, r10
    bic ip, r3, #128
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_BC:
    lsr r3, r11, #8
    bic ip, r3, #128
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_BD:
    uxtb r3, r11
    bic ip, r3, #128
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_BE:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2524
L2525:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2526
L2527:
    ldrb r1, [r3, r0]
    bic ip, r1, #128
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2528
L2529:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2530
    strb r1, [ip, r0]
L2531:
    b Lnext
L2524:
    bl Ltick_slow4
    b L2525
L2526:
    bl Lrd_slow
    b L2527
L2528:
    bl Ltick_slow4
    b L2529
L2530:
    mov r3, r1
    bl Lwr_slow
    b L2531
    .p2align 4
Lccb_BF:
    bic ip, r7, #128
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_C0:
    lsr r3, r9, #8
    orr ip, r3, #1
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_C1:
    uxtb r3, r9
    orr ip, r3, #1
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_C2:
    lsr r3, r10, #8
    orr ip, r3, #1
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_C3:
    uxtb r3, r10
    orr ip, r3, #1
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_C4:
    lsr r3, r11, #8
    orr ip, r3, #1
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_C5:
    uxtb r3, r11
    orr ip, r3, #1
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_C6:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2532
L2533:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2534
L2535:
    ldrb r1, [r3, r0]
    orr ip, r1, #1
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2536
L2537:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2538
    strb r1, [ip, r0]
L2539:
    b Lnext
L2532:
    bl Ltick_slow4
    b L2533
L2534:
    bl Lrd_slow
    b L2535
L2536:
    bl Ltick_slow4
    b L2537
L2538:
    mov r3, r1
    bl Lwr_slow
    b L2539
    .p2align 4
Lccb_C7:
    orr ip, r7, #1
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_C8:
    lsr r3, r9, #8
    orr ip, r3, #2
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_C9:
    uxtb r3, r9
    orr ip, r3, #2
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_CA:
    lsr r3, r10, #8
    orr ip, r3, #2
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_CB:
    uxtb r3, r10
    orr ip, r3, #2
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_CC:
    lsr r3, r11, #8
    orr ip, r3, #2
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_CD:
    uxtb r3, r11
    orr ip, r3, #2
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_CE:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2540
L2541:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2542
L2543:
    ldrb r1, [r3, r0]
    orr ip, r1, #2
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2544
L2545:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2546
    strb r1, [ip, r0]
L2547:
    b Lnext
L2540:
    bl Ltick_slow4
    b L2541
L2542:
    bl Lrd_slow
    b L2543
L2544:
    bl Ltick_slow4
    b L2545
L2546:
    mov r3, r1
    bl Lwr_slow
    b L2547
    .p2align 4
Lccb_CF:
    orr ip, r7, #2
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_D0:
    lsr r3, r9, #8
    orr ip, r3, #4
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_D1:
    uxtb r3, r9
    orr ip, r3, #4
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_D2:
    lsr r3, r10, #8
    orr ip, r3, #4
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_D3:
    uxtb r3, r10
    orr ip, r3, #4
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_D4:
    lsr r3, r11, #8
    orr ip, r3, #4
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_D5:
    uxtb r3, r11
    orr ip, r3, #4
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_D6:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2548
L2549:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2550
L2551:
    ldrb r1, [r3, r0]
    orr ip, r1, #4
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2552
L2553:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2554
    strb r1, [ip, r0]
L2555:
    b Lnext
L2548:
    bl Ltick_slow4
    b L2549
L2550:
    bl Lrd_slow
    b L2551
L2552:
    bl Ltick_slow4
    b L2553
L2554:
    mov r3, r1
    bl Lwr_slow
    b L2555
    .p2align 4
Lccb_D7:
    orr ip, r7, #4
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_D8:
    lsr r3, r9, #8
    orr ip, r3, #8
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_D9:
    uxtb r3, r9
    orr ip, r3, #8
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_DA:
    lsr r3, r10, #8
    orr ip, r3, #8
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_DB:
    uxtb r3, r10
    orr ip, r3, #8
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_DC:
    lsr r3, r11, #8
    orr ip, r3, #8
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_DD:
    uxtb r3, r11
    orr ip, r3, #8
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_DE:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2556
L2557:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2558
L2559:
    ldrb r1, [r3, r0]
    orr ip, r1, #8
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2560
L2561:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2562
    strb r1, [ip, r0]
L2563:
    b Lnext
L2556:
    bl Ltick_slow4
    b L2557
L2558:
    bl Lrd_slow
    b L2559
L2560:
    bl Ltick_slow4
    b L2561
L2562:
    mov r3, r1
    bl Lwr_slow
    b L2563
    .p2align 4
Lccb_DF:
    orr ip, r7, #8
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_E0:
    lsr r3, r9, #8
    orr ip, r3, #16
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_E1:
    uxtb r3, r9
    orr ip, r3, #16
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_E2:
    lsr r3, r10, #8
    orr ip, r3, #16
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_E3:
    uxtb r3, r10
    orr ip, r3, #16
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_E4:
    lsr r3, r11, #8
    orr ip, r3, #16
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_E5:
    uxtb r3, r11
    orr ip, r3, #16
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_E6:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2564
L2565:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2566
L2567:
    ldrb r1, [r3, r0]
    orr ip, r1, #16
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2568
L2569:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2570
    strb r1, [ip, r0]
L2571:
    b Lnext
L2564:
    bl Ltick_slow4
    b L2565
L2566:
    bl Lrd_slow
    b L2567
L2568:
    bl Ltick_slow4
    b L2569
L2570:
    mov r3, r1
    bl Lwr_slow
    b L2571
    .p2align 4
Lccb_E7:
    orr ip, r7, #16
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_E8:
    lsr r3, r9, #8
    orr ip, r3, #32
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_E9:
    uxtb r3, r9
    orr ip, r3, #32
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_EA:
    lsr r3, r10, #8
    orr ip, r3, #32
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_EB:
    uxtb r3, r10
    orr ip, r3, #32
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_EC:
    lsr r3, r11, #8
    orr ip, r3, #32
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_ED:
    uxtb r3, r11
    orr ip, r3, #32
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_EE:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2572
L2573:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2574
L2575:
    ldrb r1, [r3, r0]
    orr ip, r1, #32
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2576
L2577:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2578
    strb r1, [ip, r0]
L2579:
    b Lnext
L2572:
    bl Ltick_slow4
    b L2573
L2574:
    bl Lrd_slow
    b L2575
L2576:
    bl Ltick_slow4
    b L2577
L2578:
    mov r3, r1
    bl Lwr_slow
    b L2579
    .p2align 4
Lccb_EF:
    orr ip, r7, #32
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_F0:
    lsr r3, r9, #8
    orr ip, r3, #64
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_F1:
    uxtb r3, r9
    orr ip, r3, #64
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_F2:
    lsr r3, r10, #8
    orr ip, r3, #64
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_F3:
    uxtb r3, r10
    orr ip, r3, #64
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_F4:
    lsr r3, r11, #8
    orr ip, r3, #64
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_F5:
    uxtb r3, r11
    orr ip, r3, #64
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_F6:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2580
L2581:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2582
L2583:
    ldrb r1, [r3, r0]
    orr ip, r1, #64
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2584
L2585:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2586
    strb r1, [ip, r0]
L2587:
    b Lnext
L2580:
    bl Ltick_slow4
    b L2581
L2582:
    bl Lrd_slow
    b L2583
L2584:
    bl Ltick_slow4
    b L2585
L2586:
    mov r3, r1
    bl Lwr_slow
    b L2587
    .p2align 4
Lccb_F7:
    orr ip, r7, #64
    and r7, ip, #0xFF
    b Lnext
    .p2align 4
Lccb_F8:
    lsr r3, r9, #8
    orr ip, r3, #128
    bfi r9, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_F9:
    uxtb r3, r9
    orr ip, r3, #128
    bfi r9, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_FA:
    lsr r3, r10, #8
    orr ip, r3, #128
    bfi r10, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_FB:
    uxtb r3, r10
    orr ip, r3, #128
    bfi r10, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_FC:
    lsr r3, r11, #8
    orr ip, r3, #128
    bfi r11, ip, #8, #8
    b Lnext
    .p2align 4
Lccb_FD:
    uxtb r3, r11
    orr ip, r3, #128
    bfi r11, ip, #0, #8
    b Lnext
    .p2align 4
Lccb_FE:
    mov r0, r11
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2588
L2589:
    lsr ip, r0, #12
    ldr r3, [r4, ip, lsl #2]
    cmp r3, #0
    beq L2590
L2591:
    ldrb r1, [r3, r0]
    orr ip, r1, #128
    and r1, ip, #0xFF
    sub r5, r5, #4
    ldr ip, [sp, #48]
    cmp r5, ip
    ble L2592
L2593:
    lsr ip, r0, #8
    add ip, r4, ip, lsl #2
    ldr ip, [ip, #1784]
    cmp ip, #0
    beq L2594
    strb r1, [ip, r0]
L2595:
    b Lnext
L2588:
    bl Ltick_slow4
    b L2589
L2590:
    bl Lrd_slow
    b L2591
L2592:
    bl Ltick_slow4
    b L2593
L2594:
    mov r3, r1
    bl Lwr_slow
    b L2595
    .p2align 4
Lccb_FF:
    orr ip, r7, #128
    and r7, ip, #0xFF
    b Lnext
    .p2align 2
Ljt_f:
    .word Lf_00 - Ljt_f
    .word Lf_01 - Ljt_f
    .word Lf_02 - Ljt_f
    .word Lf_03 - Ljt_f
    .word Lf_04 - Ljt_f
    .word Lf_05 - Ljt_f
    .word Lf_06 - Ljt_f
    .word Lf_07 - Ljt_f
    .word Lf_08 - Ljt_f
    .word Lf_09 - Ljt_f
    .word Lf_0A - Ljt_f
    .word Lf_0B - Ljt_f
    .word Lf_0C - Ljt_f
    .word Lf_0D - Ljt_f
    .word Lf_0E - Ljt_f
    .word Lf_0F - Ljt_f
    .word Lf_10 - Ljt_f
    .word Lf_11 - Ljt_f
    .word Lf_12 - Ljt_f
    .word Lf_13 - Ljt_f
    .word Lf_14 - Ljt_f
    .word Lf_15 - Ljt_f
    .word Lf_16 - Ljt_f
    .word Lf_17 - Ljt_f
    .word Lf_18 - Ljt_f
    .word Lf_19 - Ljt_f
    .word Lf_1A - Ljt_f
    .word Lf_1B - Ljt_f
    .word Lf_1C - Ljt_f
    .word Lf_1D - Ljt_f
    .word Lf_1E - Ljt_f
    .word Lf_1F - Ljt_f
    .word Lf_20 - Ljt_f
    .word Lf_21 - Ljt_f
    .word Lf_22 - Ljt_f
    .word Lf_23 - Ljt_f
    .word Lf_24 - Ljt_f
    .word Lf_25 - Ljt_f
    .word Lf_26 - Ljt_f
    .word Lf_27 - Ljt_f
    .word Lf_28 - Ljt_f
    .word Lf_29 - Ljt_f
    .word Lf_2A - Ljt_f
    .word Lf_2B - Ljt_f
    .word Lf_2C - Ljt_f
    .word Lf_2D - Ljt_f
    .word Lf_2E - Ljt_f
    .word Lf_2F - Ljt_f
    .word Lf_30 - Ljt_f
    .word Lf_31 - Ljt_f
    .word Lf_32 - Ljt_f
    .word Lf_33 - Ljt_f
    .word Lf_34 - Ljt_f
    .word Lf_35 - Ljt_f
    .word Lf_36 - Ljt_f
    .word Lf_37 - Ljt_f
    .word Lf_38 - Ljt_f
    .word Lf_39 - Ljt_f
    .word Lf_3A - Ljt_f
    .word Lf_3B - Ljt_f
    .word Lf_3C - Ljt_f
    .word Lf_3D - Ljt_f
    .word Lf_3E - Ljt_f
    .word Lf_3F - Ljt_f
    .word Lf_40 - Ljt_f
    .word Lf_41 - Ljt_f
    .word Lf_42 - Ljt_f
    .word Lf_43 - Ljt_f
    .word Lf_44 - Ljt_f
    .word Lf_45 - Ljt_f
    .word Lf_46 - Ljt_f
    .word Lf_47 - Ljt_f
    .word Lf_48 - Ljt_f
    .word Lf_49 - Ljt_f
    .word Lf_4A - Ljt_f
    .word Lf_4B - Ljt_f
    .word Lf_4C - Ljt_f
    .word Lf_4D - Ljt_f
    .word Lf_4E - Ljt_f
    .word Lf_4F - Ljt_f
    .word Lf_50 - Ljt_f
    .word Lf_51 - Ljt_f
    .word Lf_52 - Ljt_f
    .word Lf_53 - Ljt_f
    .word Lf_54 - Ljt_f
    .word Lf_55 - Ljt_f
    .word Lf_56 - Ljt_f
    .word Lf_57 - Ljt_f
    .word Lf_58 - Ljt_f
    .word Lf_59 - Ljt_f
    .word Lf_5A - Ljt_f
    .word Lf_5B - Ljt_f
    .word Lf_5C - Ljt_f
    .word Lf_5D - Ljt_f
    .word Lf_5E - Ljt_f
    .word Lf_5F - Ljt_f
    .word Lf_60 - Ljt_f
    .word Lf_61 - Ljt_f
    .word Lf_62 - Ljt_f
    .word Lf_63 - Ljt_f
    .word Lf_64 - Ljt_f
    .word Lf_65 - Ljt_f
    .word Lf_66 - Ljt_f
    .word Lf_67 - Ljt_f
    .word Lf_68 - Ljt_f
    .word Lf_69 - Ljt_f
    .word Lf_6A - Ljt_f
    .word Lf_6B - Ljt_f
    .word Lf_6C - Ljt_f
    .word Lf_6D - Ljt_f
    .word Lf_6E - Ljt_f
    .word Lf_6F - Ljt_f
    .word Lf_70 - Ljt_f
    .word Lf_71 - Ljt_f
    .word Lf_72 - Ljt_f
    .word Lf_73 - Ljt_f
    .word Lf_74 - Ljt_f
    .word Lf_75 - Ljt_f
    .word Lf_76 - Ljt_f
    .word Lf_77 - Ljt_f
    .word Lf_78 - Ljt_f
    .word Lf_79 - Ljt_f
    .word Lf_7A - Ljt_f
    .word Lf_7B - Ljt_f
    .word Lf_7C - Ljt_f
    .word Lf_7D - Ljt_f
    .word Lf_7E - Ljt_f
    .word Lf_7F - Ljt_f
    .word Lf_80 - Ljt_f
    .word Lf_81 - Ljt_f
    .word Lf_82 - Ljt_f
    .word Lf_83 - Ljt_f
    .word Lf_84 - Ljt_f
    .word Lf_85 - Ljt_f
    .word Lf_86 - Ljt_f
    .word Lf_87 - Ljt_f
    .word Lf_88 - Ljt_f
    .word Lf_89 - Ljt_f
    .word Lf_8A - Ljt_f
    .word Lf_8B - Ljt_f
    .word Lf_8C - Ljt_f
    .word Lf_8D - Ljt_f
    .word Lf_8E - Ljt_f
    .word Lf_8F - Ljt_f
    .word Lf_90 - Ljt_f
    .word Lf_91 - Ljt_f
    .word Lf_92 - Ljt_f
    .word Lf_93 - Ljt_f
    .word Lf_94 - Ljt_f
    .word Lf_95 - Ljt_f
    .word Lf_96 - Ljt_f
    .word Lf_97 - Ljt_f
    .word Lf_98 - Ljt_f
    .word Lf_99 - Ljt_f
    .word Lf_9A - Ljt_f
    .word Lf_9B - Ljt_f
    .word Lf_9C - Ljt_f
    .word Lf_9D - Ljt_f
    .word Lf_9E - Ljt_f
    .word Lf_9F - Ljt_f
    .word Lf_A0 - Ljt_f
    .word Lf_A1 - Ljt_f
    .word Lf_A2 - Ljt_f
    .word Lf_A3 - Ljt_f
    .word Lf_A4 - Ljt_f
    .word Lf_A5 - Ljt_f
    .word Lf_A6 - Ljt_f
    .word Lf_A7 - Ljt_f
    .word Lf_A8 - Ljt_f
    .word Lf_A9 - Ljt_f
    .word Lf_AA - Ljt_f
    .word Lf_AB - Ljt_f
    .word Lf_AC - Ljt_f
    .word Lf_AD - Ljt_f
    .word Lf_AE - Ljt_f
    .word Lf_AF - Ljt_f
    .word Lf_B0 - Ljt_f
    .word Lf_B1 - Ljt_f
    .word Lf_B2 - Ljt_f
    .word Lf_B3 - Ljt_f
    .word Lf_B4 - Ljt_f
    .word Lf_B5 - Ljt_f
    .word Lf_B6 - Ljt_f
    .word Lf_B7 - Ljt_f
    .word Lf_B8 - Ljt_f
    .word Lf_B9 - Ljt_f
    .word Lf_BA - Ljt_f
    .word Lf_BB - Ljt_f
    .word Lf_BC - Ljt_f
    .word Lf_BD - Ljt_f
    .word Lf_BE - Ljt_f
    .word Lf_BF - Ljt_f
    .word Lf_C0 - Ljt_f
    .word Lf_C1 - Ljt_f
    .word Lf_C2 - Ljt_f
    .word Lf_C3 - Ljt_f
    .word Lf_C4 - Ljt_f
    .word Lf_C5 - Ljt_f
    .word Lf_C6 - Ljt_f
    .word Lf_C7 - Ljt_f
    .word Lf_C8 - Ljt_f
    .word Lf_C9 - Ljt_f
    .word Lf_CA - Ljt_f
    .word Lf_CB - Ljt_f
    .word Lf_CC - Ljt_f
    .word Lf_CD - Ljt_f
    .word Lf_CE - Ljt_f
    .word Lf_CF - Ljt_f
    .word Lf_D0 - Ljt_f
    .word Lf_D1 - Ljt_f
    .word Lf_D2 - Ljt_f
    .word Lf_D3 - Ljt_f
    .word Lf_D4 - Ljt_f
    .word Lf_D5 - Ljt_f
    .word Lf_D6 - Ljt_f
    .word Lf_D7 - Ljt_f
    .word Lf_D8 - Ljt_f
    .word Lf_D9 - Ljt_f
    .word Lf_DA - Ljt_f
    .word Lf_DB - Ljt_f
    .word Lf_DC - Ljt_f
    .word Lf_DD - Ljt_f
    .word Lf_DE - Ljt_f
    .word Lf_DF - Ljt_f
    .word Lf_E0 - Ljt_f
    .word Lf_E1 - Ljt_f
    .word Lf_E2 - Ljt_f
    .word Lf_E3 - Ljt_f
    .word Lf_E4 - Ljt_f
    .word Lf_E5 - Ljt_f
    .word Lf_E6 - Ljt_f
    .word Lf_E7 - Ljt_f
    .word Lf_E8 - Ljt_f
    .word Lf_E9 - Ljt_f
    .word Lf_EA - Ljt_f
    .word Lf_EB - Ljt_f
    .word Lf_EC - Ljt_f
    .word Lf_ED - Ljt_f
    .word Lf_EE - Ljt_f
    .word Lf_EF - Ljt_f
    .word Lf_F0 - Ljt_f
    .word Lf_F1 - Ljt_f
    .word Lf_F2 - Ljt_f
    .word Lf_F3 - Ljt_f
    .word Lf_F4 - Ljt_f
    .word Lf_F5 - Ljt_f
    .word Lf_F6 - Ljt_f
    .word Lf_F7 - Ljt_f
    .word Lf_F8 - Ljt_f
    .word Lf_F9 - Ljt_f
    .word Lf_FA - Ljt_f
    .word Lf_FB - Ljt_f
    .word Lf_FC - Ljt_f
    .word Lf_FD - Ljt_f
    .word Lf_FE - Ljt_f
    .word Lf_FF - Ljt_f
    .p2align 2
Ljt_c:
    .word Lc_00 - Ljt_c
    .word Lc_01 - Ljt_c
    .word Lc_02 - Ljt_c
    .word Lc_03 - Ljt_c
    .word Lc_04 - Ljt_c
    .word Lc_05 - Ljt_c
    .word Lc_06 - Ljt_c
    .word Lc_07 - Ljt_c
    .word Lc_08 - Ljt_c
    .word Lc_09 - Ljt_c
    .word Lc_0A - Ljt_c
    .word Lc_0B - Ljt_c
    .word Lc_0C - Ljt_c
    .word Lc_0D - Ljt_c
    .word Lc_0E - Ljt_c
    .word Lc_0F - Ljt_c
    .word Lc_10 - Ljt_c
    .word Lc_11 - Ljt_c
    .word Lc_12 - Ljt_c
    .word Lc_13 - Ljt_c
    .word Lc_14 - Ljt_c
    .word Lc_15 - Ljt_c
    .word Lc_16 - Ljt_c
    .word Lc_17 - Ljt_c
    .word Lc_18 - Ljt_c
    .word Lc_19 - Ljt_c
    .word Lc_1A - Ljt_c
    .word Lc_1B - Ljt_c
    .word Lc_1C - Ljt_c
    .word Lc_1D - Ljt_c
    .word Lc_1E - Ljt_c
    .word Lc_1F - Ljt_c
    .word Lc_20 - Ljt_c
    .word Lc_21 - Ljt_c
    .word Lc_22 - Ljt_c
    .word Lc_23 - Ljt_c
    .word Lc_24 - Ljt_c
    .word Lc_25 - Ljt_c
    .word Lc_26 - Ljt_c
    .word Lc_27 - Ljt_c
    .word Lc_28 - Ljt_c
    .word Lc_29 - Ljt_c
    .word Lc_2A - Ljt_c
    .word Lc_2B - Ljt_c
    .word Lc_2C - Ljt_c
    .word Lc_2D - Ljt_c
    .word Lc_2E - Ljt_c
    .word Lc_2F - Ljt_c
    .word Lc_30 - Ljt_c
    .word Lc_31 - Ljt_c
    .word Lc_32 - Ljt_c
    .word Lc_33 - Ljt_c
    .word Lc_34 - Ljt_c
    .word Lc_35 - Ljt_c
    .word Lc_36 - Ljt_c
    .word Lc_37 - Ljt_c
    .word Lc_38 - Ljt_c
    .word Lc_39 - Ljt_c
    .word Lc_3A - Ljt_c
    .word Lc_3B - Ljt_c
    .word Lc_3C - Ljt_c
    .word Lc_3D - Ljt_c
    .word Lc_3E - Ljt_c
    .word Lc_3F - Ljt_c
    .word Lc_40 - Ljt_c
    .word Lc_41 - Ljt_c
    .word Lc_42 - Ljt_c
    .word Lc_43 - Ljt_c
    .word Lc_44 - Ljt_c
    .word Lc_45 - Ljt_c
    .word Lc_46 - Ljt_c
    .word Lc_47 - Ljt_c
    .word Lc_48 - Ljt_c
    .word Lc_49 - Ljt_c
    .word Lc_4A - Ljt_c
    .word Lc_4B - Ljt_c
    .word Lc_4C - Ljt_c
    .word Lc_4D - Ljt_c
    .word Lc_4E - Ljt_c
    .word Lc_4F - Ljt_c
    .word Lc_50 - Ljt_c
    .word Lc_51 - Ljt_c
    .word Lc_52 - Ljt_c
    .word Lc_53 - Ljt_c
    .word Lc_54 - Ljt_c
    .word Lc_55 - Ljt_c
    .word Lc_56 - Ljt_c
    .word Lc_57 - Ljt_c
    .word Lc_58 - Ljt_c
    .word Lc_59 - Ljt_c
    .word Lc_5A - Ljt_c
    .word Lc_5B - Ljt_c
    .word Lc_5C - Ljt_c
    .word Lc_5D - Ljt_c
    .word Lc_5E - Ljt_c
    .word Lc_5F - Ljt_c
    .word Lc_60 - Ljt_c
    .word Lc_61 - Ljt_c
    .word Lc_62 - Ljt_c
    .word Lc_63 - Ljt_c
    .word Lc_64 - Ljt_c
    .word Lc_65 - Ljt_c
    .word Lc_66 - Ljt_c
    .word Lc_67 - Ljt_c
    .word Lc_68 - Ljt_c
    .word Lc_69 - Ljt_c
    .word Lc_6A - Ljt_c
    .word Lc_6B - Ljt_c
    .word Lc_6C - Ljt_c
    .word Lc_6D - Ljt_c
    .word Lc_6E - Ljt_c
    .word Lc_6F - Ljt_c
    .word Lc_70 - Ljt_c
    .word Lc_71 - Ljt_c
    .word Lc_72 - Ljt_c
    .word Lc_73 - Ljt_c
    .word Lc_74 - Ljt_c
    .word Lc_75 - Ljt_c
    .word Lc_76 - Ljt_c
    .word Lc_77 - Ljt_c
    .word Lc_78 - Ljt_c
    .word Lc_79 - Ljt_c
    .word Lc_7A - Ljt_c
    .word Lc_7B - Ljt_c
    .word Lc_7C - Ljt_c
    .word Lc_7D - Ljt_c
    .word Lc_7E - Ljt_c
    .word Lc_7F - Ljt_c
    .word Lc_80 - Ljt_c
    .word Lc_81 - Ljt_c
    .word Lc_82 - Ljt_c
    .word Lc_83 - Ljt_c
    .word Lc_84 - Ljt_c
    .word Lc_85 - Ljt_c
    .word Lc_86 - Ljt_c
    .word Lc_87 - Ljt_c
    .word Lc_88 - Ljt_c
    .word Lc_89 - Ljt_c
    .word Lc_8A - Ljt_c
    .word Lc_8B - Ljt_c
    .word Lc_8C - Ljt_c
    .word Lc_8D - Ljt_c
    .word Lc_8E - Ljt_c
    .word Lc_8F - Ljt_c
    .word Lc_90 - Ljt_c
    .word Lc_91 - Ljt_c
    .word Lc_92 - Ljt_c
    .word Lc_93 - Ljt_c
    .word Lc_94 - Ljt_c
    .word Lc_95 - Ljt_c
    .word Lc_96 - Ljt_c
    .word Lc_97 - Ljt_c
    .word Lc_98 - Ljt_c
    .word Lc_99 - Ljt_c
    .word Lc_9A - Ljt_c
    .word Lc_9B - Ljt_c
    .word Lc_9C - Ljt_c
    .word Lc_9D - Ljt_c
    .word Lc_9E - Ljt_c
    .word Lc_9F - Ljt_c
    .word Lc_A0 - Ljt_c
    .word Lc_A1 - Ljt_c
    .word Lc_A2 - Ljt_c
    .word Lc_A3 - Ljt_c
    .word Lc_A4 - Ljt_c
    .word Lc_A5 - Ljt_c
    .word Lc_A6 - Ljt_c
    .word Lc_A7 - Ljt_c
    .word Lc_A8 - Ljt_c
    .word Lc_A9 - Ljt_c
    .word Lc_AA - Ljt_c
    .word Lc_AB - Ljt_c
    .word Lc_AC - Ljt_c
    .word Lc_AD - Ljt_c
    .word Lc_AE - Ljt_c
    .word Lc_AF - Ljt_c
    .word Lc_B0 - Ljt_c
    .word Lc_B1 - Ljt_c
    .word Lc_B2 - Ljt_c
    .word Lc_B3 - Ljt_c
    .word Lc_B4 - Ljt_c
    .word Lc_B5 - Ljt_c
    .word Lc_B6 - Ljt_c
    .word Lc_B7 - Ljt_c
    .word Lc_B8 - Ljt_c
    .word Lc_B9 - Ljt_c
    .word Lc_BA - Ljt_c
    .word Lc_BB - Ljt_c
    .word Lc_BC - Ljt_c
    .word Lc_BD - Ljt_c
    .word Lc_BE - Ljt_c
    .word Lc_BF - Ljt_c
    .word Lc_C0 - Ljt_c
    .word Lc_C1 - Ljt_c
    .word Lc_C2 - Ljt_c
    .word Lc_C3 - Ljt_c
    .word Lc_C4 - Ljt_c
    .word Lc_C5 - Ljt_c
    .word Lc_C6 - Ljt_c
    .word Lc_C7 - Ljt_c
    .word Lc_C8 - Ljt_c
    .word Lc_C9 - Ljt_c
    .word Lc_CA - Ljt_c
    .word Lc_CB - Ljt_c
    .word Lc_CC - Ljt_c
    .word Lc_CD - Ljt_c
    .word Lc_CE - Ljt_c
    .word Lc_CF - Ljt_c
    .word Lc_D0 - Ljt_c
    .word Lc_D1 - Ljt_c
    .word Lc_D2 - Ljt_c
    .word Lc_D3 - Ljt_c
    .word Lc_D4 - Ljt_c
    .word Lc_D5 - Ljt_c
    .word Lc_D6 - Ljt_c
    .word Lc_D7 - Ljt_c
    .word Lc_D8 - Ljt_c
    .word Lc_D9 - Ljt_c
    .word Lc_DA - Ljt_c
    .word Lc_DB - Ljt_c
    .word Lc_DC - Ljt_c
    .word Lc_DD - Ljt_c
    .word Lc_DE - Ljt_c
    .word Lc_DF - Ljt_c
    .word Lc_E0 - Ljt_c
    .word Lc_E1 - Ljt_c
    .word Lc_E2 - Ljt_c
    .word Lc_E3 - Ljt_c
    .word Lc_E4 - Ljt_c
    .word Lc_E5 - Ljt_c
    .word Lc_E6 - Ljt_c
    .word Lc_E7 - Ljt_c
    .word Lc_E8 - Ljt_c
    .word Lc_E9 - Ljt_c
    .word Lc_EA - Ljt_c
    .word Lc_EB - Ljt_c
    .word Lc_EC - Ljt_c
    .word Lc_ED - Ljt_c
    .word Lc_EE - Ljt_c
    .word Lc_EF - Ljt_c
    .word Lc_F0 - Ljt_c
    .word Lc_F1 - Ljt_c
    .word Lc_F2 - Ljt_c
    .word Lc_F3 - Ljt_c
    .word Lc_F4 - Ljt_c
    .word Lc_F5 - Ljt_c
    .word Lc_F6 - Ljt_c
    .word Lc_F7 - Ljt_c
    .word Lc_F8 - Ljt_c
    .word Lc_F9 - Ljt_c
    .word Lc_FA - Ljt_c
    .word Lc_FB - Ljt_c
    .word Lc_FC - Ljt_c
    .word Lc_FD - Ljt_c
    .word Lc_FE - Ljt_c
    .word Lc_FF - Ljt_c
    .p2align 2
Ljt_fcb:
    .word Lfcb_00 - Ljt_fcb
    .word Lfcb_01 - Ljt_fcb
    .word Lfcb_02 - Ljt_fcb
    .word Lfcb_03 - Ljt_fcb
    .word Lfcb_04 - Ljt_fcb
    .word Lfcb_05 - Ljt_fcb
    .word Lfcb_06 - Ljt_fcb
    .word Lfcb_07 - Ljt_fcb
    .word Lfcb_08 - Ljt_fcb
    .word Lfcb_09 - Ljt_fcb
    .word Lfcb_0A - Ljt_fcb
    .word Lfcb_0B - Ljt_fcb
    .word Lfcb_0C - Ljt_fcb
    .word Lfcb_0D - Ljt_fcb
    .word Lfcb_0E - Ljt_fcb
    .word Lfcb_0F - Ljt_fcb
    .word Lfcb_10 - Ljt_fcb
    .word Lfcb_11 - Ljt_fcb
    .word Lfcb_12 - Ljt_fcb
    .word Lfcb_13 - Ljt_fcb
    .word Lfcb_14 - Ljt_fcb
    .word Lfcb_15 - Ljt_fcb
    .word Lfcb_16 - Ljt_fcb
    .word Lfcb_17 - Ljt_fcb
    .word Lfcb_18 - Ljt_fcb
    .word Lfcb_19 - Ljt_fcb
    .word Lfcb_1A - Ljt_fcb
    .word Lfcb_1B - Ljt_fcb
    .word Lfcb_1C - Ljt_fcb
    .word Lfcb_1D - Ljt_fcb
    .word Lfcb_1E - Ljt_fcb
    .word Lfcb_1F - Ljt_fcb
    .word Lfcb_20 - Ljt_fcb
    .word Lfcb_21 - Ljt_fcb
    .word Lfcb_22 - Ljt_fcb
    .word Lfcb_23 - Ljt_fcb
    .word Lfcb_24 - Ljt_fcb
    .word Lfcb_25 - Ljt_fcb
    .word Lfcb_26 - Ljt_fcb
    .word Lfcb_27 - Ljt_fcb
    .word Lfcb_28 - Ljt_fcb
    .word Lfcb_29 - Ljt_fcb
    .word Lfcb_2A - Ljt_fcb
    .word Lfcb_2B - Ljt_fcb
    .word Lfcb_2C - Ljt_fcb
    .word Lfcb_2D - Ljt_fcb
    .word Lfcb_2E - Ljt_fcb
    .word Lfcb_2F - Ljt_fcb
    .word Lfcb_30 - Ljt_fcb
    .word Lfcb_31 - Ljt_fcb
    .word Lfcb_32 - Ljt_fcb
    .word Lfcb_33 - Ljt_fcb
    .word Lfcb_34 - Ljt_fcb
    .word Lfcb_35 - Ljt_fcb
    .word Lfcb_36 - Ljt_fcb
    .word Lfcb_37 - Ljt_fcb
    .word Lfcb_38 - Ljt_fcb
    .word Lfcb_39 - Ljt_fcb
    .word Lfcb_3A - Ljt_fcb
    .word Lfcb_3B - Ljt_fcb
    .word Lfcb_3C - Ljt_fcb
    .word Lfcb_3D - Ljt_fcb
    .word Lfcb_3E - Ljt_fcb
    .word Lfcb_3F - Ljt_fcb
    .word Lfcb_40 - Ljt_fcb
    .word Lfcb_41 - Ljt_fcb
    .word Lfcb_42 - Ljt_fcb
    .word Lfcb_43 - Ljt_fcb
    .word Lfcb_44 - Ljt_fcb
    .word Lfcb_45 - Ljt_fcb
    .word Lfcb_46 - Ljt_fcb
    .word Lfcb_47 - Ljt_fcb
    .word Lfcb_48 - Ljt_fcb
    .word Lfcb_49 - Ljt_fcb
    .word Lfcb_4A - Ljt_fcb
    .word Lfcb_4B - Ljt_fcb
    .word Lfcb_4C - Ljt_fcb
    .word Lfcb_4D - Ljt_fcb
    .word Lfcb_4E - Ljt_fcb
    .word Lfcb_4F - Ljt_fcb
    .word Lfcb_50 - Ljt_fcb
    .word Lfcb_51 - Ljt_fcb
    .word Lfcb_52 - Ljt_fcb
    .word Lfcb_53 - Ljt_fcb
    .word Lfcb_54 - Ljt_fcb
    .word Lfcb_55 - Ljt_fcb
    .word Lfcb_56 - Ljt_fcb
    .word Lfcb_57 - Ljt_fcb
    .word Lfcb_58 - Ljt_fcb
    .word Lfcb_59 - Ljt_fcb
    .word Lfcb_5A - Ljt_fcb
    .word Lfcb_5B - Ljt_fcb
    .word Lfcb_5C - Ljt_fcb
    .word Lfcb_5D - Ljt_fcb
    .word Lfcb_5E - Ljt_fcb
    .word Lfcb_5F - Ljt_fcb
    .word Lfcb_60 - Ljt_fcb
    .word Lfcb_61 - Ljt_fcb
    .word Lfcb_62 - Ljt_fcb
    .word Lfcb_63 - Ljt_fcb
    .word Lfcb_64 - Ljt_fcb
    .word Lfcb_65 - Ljt_fcb
    .word Lfcb_66 - Ljt_fcb
    .word Lfcb_67 - Ljt_fcb
    .word Lfcb_68 - Ljt_fcb
    .word Lfcb_69 - Ljt_fcb
    .word Lfcb_6A - Ljt_fcb
    .word Lfcb_6B - Ljt_fcb
    .word Lfcb_6C - Ljt_fcb
    .word Lfcb_6D - Ljt_fcb
    .word Lfcb_6E - Ljt_fcb
    .word Lfcb_6F - Ljt_fcb
    .word Lfcb_70 - Ljt_fcb
    .word Lfcb_71 - Ljt_fcb
    .word Lfcb_72 - Ljt_fcb
    .word Lfcb_73 - Ljt_fcb
    .word Lfcb_74 - Ljt_fcb
    .word Lfcb_75 - Ljt_fcb
    .word Lfcb_76 - Ljt_fcb
    .word Lfcb_77 - Ljt_fcb
    .word Lfcb_78 - Ljt_fcb
    .word Lfcb_79 - Ljt_fcb
    .word Lfcb_7A - Ljt_fcb
    .word Lfcb_7B - Ljt_fcb
    .word Lfcb_7C - Ljt_fcb
    .word Lfcb_7D - Ljt_fcb
    .word Lfcb_7E - Ljt_fcb
    .word Lfcb_7F - Ljt_fcb
    .word Lfcb_80 - Ljt_fcb
    .word Lfcb_81 - Ljt_fcb
    .word Lfcb_82 - Ljt_fcb
    .word Lfcb_83 - Ljt_fcb
    .word Lfcb_84 - Ljt_fcb
    .word Lfcb_85 - Ljt_fcb
    .word Lfcb_86 - Ljt_fcb
    .word Lfcb_87 - Ljt_fcb
    .word Lfcb_88 - Ljt_fcb
    .word Lfcb_89 - Ljt_fcb
    .word Lfcb_8A - Ljt_fcb
    .word Lfcb_8B - Ljt_fcb
    .word Lfcb_8C - Ljt_fcb
    .word Lfcb_8D - Ljt_fcb
    .word Lfcb_8E - Ljt_fcb
    .word Lfcb_8F - Ljt_fcb
    .word Lfcb_90 - Ljt_fcb
    .word Lfcb_91 - Ljt_fcb
    .word Lfcb_92 - Ljt_fcb
    .word Lfcb_93 - Ljt_fcb
    .word Lfcb_94 - Ljt_fcb
    .word Lfcb_95 - Ljt_fcb
    .word Lfcb_96 - Ljt_fcb
    .word Lfcb_97 - Ljt_fcb
    .word Lfcb_98 - Ljt_fcb
    .word Lfcb_99 - Ljt_fcb
    .word Lfcb_9A - Ljt_fcb
    .word Lfcb_9B - Ljt_fcb
    .word Lfcb_9C - Ljt_fcb
    .word Lfcb_9D - Ljt_fcb
    .word Lfcb_9E - Ljt_fcb
    .word Lfcb_9F - Ljt_fcb
    .word Lfcb_A0 - Ljt_fcb
    .word Lfcb_A1 - Ljt_fcb
    .word Lfcb_A2 - Ljt_fcb
    .word Lfcb_A3 - Ljt_fcb
    .word Lfcb_A4 - Ljt_fcb
    .word Lfcb_A5 - Ljt_fcb
    .word Lfcb_A6 - Ljt_fcb
    .word Lfcb_A7 - Ljt_fcb
    .word Lfcb_A8 - Ljt_fcb
    .word Lfcb_A9 - Ljt_fcb
    .word Lfcb_AA - Ljt_fcb
    .word Lfcb_AB - Ljt_fcb
    .word Lfcb_AC - Ljt_fcb
    .word Lfcb_AD - Ljt_fcb
    .word Lfcb_AE - Ljt_fcb
    .word Lfcb_AF - Ljt_fcb
    .word Lfcb_B0 - Ljt_fcb
    .word Lfcb_B1 - Ljt_fcb
    .word Lfcb_B2 - Ljt_fcb
    .word Lfcb_B3 - Ljt_fcb
    .word Lfcb_B4 - Ljt_fcb
    .word Lfcb_B5 - Ljt_fcb
    .word Lfcb_B6 - Ljt_fcb
    .word Lfcb_B7 - Ljt_fcb
    .word Lfcb_B8 - Ljt_fcb
    .word Lfcb_B9 - Ljt_fcb
    .word Lfcb_BA - Ljt_fcb
    .word Lfcb_BB - Ljt_fcb
    .word Lfcb_BC - Ljt_fcb
    .word Lfcb_BD - Ljt_fcb
    .word Lfcb_BE - Ljt_fcb
    .word Lfcb_BF - Ljt_fcb
    .word Lfcb_C0 - Ljt_fcb
    .word Lfcb_C1 - Ljt_fcb
    .word Lfcb_C2 - Ljt_fcb
    .word Lfcb_C3 - Ljt_fcb
    .word Lfcb_C4 - Ljt_fcb
    .word Lfcb_C5 - Ljt_fcb
    .word Lfcb_C6 - Ljt_fcb
    .word Lfcb_C7 - Ljt_fcb
    .word Lfcb_C8 - Ljt_fcb
    .word Lfcb_C9 - Ljt_fcb
    .word Lfcb_CA - Ljt_fcb
    .word Lfcb_CB - Ljt_fcb
    .word Lfcb_CC - Ljt_fcb
    .word Lfcb_CD - Ljt_fcb
    .word Lfcb_CE - Ljt_fcb
    .word Lfcb_CF - Ljt_fcb
    .word Lfcb_D0 - Ljt_fcb
    .word Lfcb_D1 - Ljt_fcb
    .word Lfcb_D2 - Ljt_fcb
    .word Lfcb_D3 - Ljt_fcb
    .word Lfcb_D4 - Ljt_fcb
    .word Lfcb_D5 - Ljt_fcb
    .word Lfcb_D6 - Ljt_fcb
    .word Lfcb_D7 - Ljt_fcb
    .word Lfcb_D8 - Ljt_fcb
    .word Lfcb_D9 - Ljt_fcb
    .word Lfcb_DA - Ljt_fcb
    .word Lfcb_DB - Ljt_fcb
    .word Lfcb_DC - Ljt_fcb
    .word Lfcb_DD - Ljt_fcb
    .word Lfcb_DE - Ljt_fcb
    .word Lfcb_DF - Ljt_fcb
    .word Lfcb_E0 - Ljt_fcb
    .word Lfcb_E1 - Ljt_fcb
    .word Lfcb_E2 - Ljt_fcb
    .word Lfcb_E3 - Ljt_fcb
    .word Lfcb_E4 - Ljt_fcb
    .word Lfcb_E5 - Ljt_fcb
    .word Lfcb_E6 - Ljt_fcb
    .word Lfcb_E7 - Ljt_fcb
    .word Lfcb_E8 - Ljt_fcb
    .word Lfcb_E9 - Ljt_fcb
    .word Lfcb_EA - Ljt_fcb
    .word Lfcb_EB - Ljt_fcb
    .word Lfcb_EC - Ljt_fcb
    .word Lfcb_ED - Ljt_fcb
    .word Lfcb_EE - Ljt_fcb
    .word Lfcb_EF - Ljt_fcb
    .word Lfcb_F0 - Ljt_fcb
    .word Lfcb_F1 - Ljt_fcb
    .word Lfcb_F2 - Ljt_fcb
    .word Lfcb_F3 - Ljt_fcb
    .word Lfcb_F4 - Ljt_fcb
    .word Lfcb_F5 - Ljt_fcb
    .word Lfcb_F6 - Ljt_fcb
    .word Lfcb_F7 - Ljt_fcb
    .word Lfcb_F8 - Ljt_fcb
    .word Lfcb_F9 - Ljt_fcb
    .word Lfcb_FA - Ljt_fcb
    .word Lfcb_FB - Ljt_fcb
    .word Lfcb_FC - Ljt_fcb
    .word Lfcb_FD - Ljt_fcb
    .word Lfcb_FE - Ljt_fcb
    .word Lfcb_FF - Ljt_fcb
    .p2align 2
Ljt_ccb:
    .word Lccb_00 - Ljt_ccb
    .word Lccb_01 - Ljt_ccb
    .word Lccb_02 - Ljt_ccb
    .word Lccb_03 - Ljt_ccb
    .word Lccb_04 - Ljt_ccb
    .word Lccb_05 - Ljt_ccb
    .word Lccb_06 - Ljt_ccb
    .word Lccb_07 - Ljt_ccb
    .word Lccb_08 - Ljt_ccb
    .word Lccb_09 - Ljt_ccb
    .word Lccb_0A - Ljt_ccb
    .word Lccb_0B - Ljt_ccb
    .word Lccb_0C - Ljt_ccb
    .word Lccb_0D - Ljt_ccb
    .word Lccb_0E - Ljt_ccb
    .word Lccb_0F - Ljt_ccb
    .word Lccb_10 - Ljt_ccb
    .word Lccb_11 - Ljt_ccb
    .word Lccb_12 - Ljt_ccb
    .word Lccb_13 - Ljt_ccb
    .word Lccb_14 - Ljt_ccb
    .word Lccb_15 - Ljt_ccb
    .word Lccb_16 - Ljt_ccb
    .word Lccb_17 - Ljt_ccb
    .word Lccb_18 - Ljt_ccb
    .word Lccb_19 - Ljt_ccb
    .word Lccb_1A - Ljt_ccb
    .word Lccb_1B - Ljt_ccb
    .word Lccb_1C - Ljt_ccb
    .word Lccb_1D - Ljt_ccb
    .word Lccb_1E - Ljt_ccb
    .word Lccb_1F - Ljt_ccb
    .word Lccb_20 - Ljt_ccb
    .word Lccb_21 - Ljt_ccb
    .word Lccb_22 - Ljt_ccb
    .word Lccb_23 - Ljt_ccb
    .word Lccb_24 - Ljt_ccb
    .word Lccb_25 - Ljt_ccb
    .word Lccb_26 - Ljt_ccb
    .word Lccb_27 - Ljt_ccb
    .word Lccb_28 - Ljt_ccb
    .word Lccb_29 - Ljt_ccb
    .word Lccb_2A - Ljt_ccb
    .word Lccb_2B - Ljt_ccb
    .word Lccb_2C - Ljt_ccb
    .word Lccb_2D - Ljt_ccb
    .word Lccb_2E - Ljt_ccb
    .word Lccb_2F - Ljt_ccb
    .word Lccb_30 - Ljt_ccb
    .word Lccb_31 - Ljt_ccb
    .word Lccb_32 - Ljt_ccb
    .word Lccb_33 - Ljt_ccb
    .word Lccb_34 - Ljt_ccb
    .word Lccb_35 - Ljt_ccb
    .word Lccb_36 - Ljt_ccb
    .word Lccb_37 - Ljt_ccb
    .word Lccb_38 - Ljt_ccb
    .word Lccb_39 - Ljt_ccb
    .word Lccb_3A - Ljt_ccb
    .word Lccb_3B - Ljt_ccb
    .word Lccb_3C - Ljt_ccb
    .word Lccb_3D - Ljt_ccb
    .word Lccb_3E - Ljt_ccb
    .word Lccb_3F - Ljt_ccb
    .word Lccb_40 - Ljt_ccb
    .word Lccb_41 - Ljt_ccb
    .word Lccb_42 - Ljt_ccb
    .word Lccb_43 - Ljt_ccb
    .word Lccb_44 - Ljt_ccb
    .word Lccb_45 - Ljt_ccb
    .word Lccb_46 - Ljt_ccb
    .word Lccb_47 - Ljt_ccb
    .word Lccb_48 - Ljt_ccb
    .word Lccb_49 - Ljt_ccb
    .word Lccb_4A - Ljt_ccb
    .word Lccb_4B - Ljt_ccb
    .word Lccb_4C - Ljt_ccb
    .word Lccb_4D - Ljt_ccb
    .word Lccb_4E - Ljt_ccb
    .word Lccb_4F - Ljt_ccb
    .word Lccb_50 - Ljt_ccb
    .word Lccb_51 - Ljt_ccb
    .word Lccb_52 - Ljt_ccb
    .word Lccb_53 - Ljt_ccb
    .word Lccb_54 - Ljt_ccb
    .word Lccb_55 - Ljt_ccb
    .word Lccb_56 - Ljt_ccb
    .word Lccb_57 - Ljt_ccb
    .word Lccb_58 - Ljt_ccb
    .word Lccb_59 - Ljt_ccb
    .word Lccb_5A - Ljt_ccb
    .word Lccb_5B - Ljt_ccb
    .word Lccb_5C - Ljt_ccb
    .word Lccb_5D - Ljt_ccb
    .word Lccb_5E - Ljt_ccb
    .word Lccb_5F - Ljt_ccb
    .word Lccb_60 - Ljt_ccb
    .word Lccb_61 - Ljt_ccb
    .word Lccb_62 - Ljt_ccb
    .word Lccb_63 - Ljt_ccb
    .word Lccb_64 - Ljt_ccb
    .word Lccb_65 - Ljt_ccb
    .word Lccb_66 - Ljt_ccb
    .word Lccb_67 - Ljt_ccb
    .word Lccb_68 - Ljt_ccb
    .word Lccb_69 - Ljt_ccb
    .word Lccb_6A - Ljt_ccb
    .word Lccb_6B - Ljt_ccb
    .word Lccb_6C - Ljt_ccb
    .word Lccb_6D - Ljt_ccb
    .word Lccb_6E - Ljt_ccb
    .word Lccb_6F - Ljt_ccb
    .word Lccb_70 - Ljt_ccb
    .word Lccb_71 - Ljt_ccb
    .word Lccb_72 - Ljt_ccb
    .word Lccb_73 - Ljt_ccb
    .word Lccb_74 - Ljt_ccb
    .word Lccb_75 - Ljt_ccb
    .word Lccb_76 - Ljt_ccb
    .word Lccb_77 - Ljt_ccb
    .word Lccb_78 - Ljt_ccb
    .word Lccb_79 - Ljt_ccb
    .word Lccb_7A - Ljt_ccb
    .word Lccb_7B - Ljt_ccb
    .word Lccb_7C - Ljt_ccb
    .word Lccb_7D - Ljt_ccb
    .word Lccb_7E - Ljt_ccb
    .word Lccb_7F - Ljt_ccb
    .word Lccb_80 - Ljt_ccb
    .word Lccb_81 - Ljt_ccb
    .word Lccb_82 - Ljt_ccb
    .word Lccb_83 - Ljt_ccb
    .word Lccb_84 - Ljt_ccb
    .word Lccb_85 - Ljt_ccb
    .word Lccb_86 - Ljt_ccb
    .word Lccb_87 - Ljt_ccb
    .word Lccb_88 - Ljt_ccb
    .word Lccb_89 - Ljt_ccb
    .word Lccb_8A - Ljt_ccb
    .word Lccb_8B - Ljt_ccb
    .word Lccb_8C - Ljt_ccb
    .word Lccb_8D - Ljt_ccb
    .word Lccb_8E - Ljt_ccb
    .word Lccb_8F - Ljt_ccb
    .word Lccb_90 - Ljt_ccb
    .word Lccb_91 - Ljt_ccb
    .word Lccb_92 - Ljt_ccb
    .word Lccb_93 - Ljt_ccb
    .word Lccb_94 - Ljt_ccb
    .word Lccb_95 - Ljt_ccb
    .word Lccb_96 - Ljt_ccb
    .word Lccb_97 - Ljt_ccb
    .word Lccb_98 - Ljt_ccb
    .word Lccb_99 - Ljt_ccb
    .word Lccb_9A - Ljt_ccb
    .word Lccb_9B - Ljt_ccb
    .word Lccb_9C - Ljt_ccb
    .word Lccb_9D - Ljt_ccb
    .word Lccb_9E - Ljt_ccb
    .word Lccb_9F - Ljt_ccb
    .word Lccb_A0 - Ljt_ccb
    .word Lccb_A1 - Ljt_ccb
    .word Lccb_A2 - Ljt_ccb
    .word Lccb_A3 - Ljt_ccb
    .word Lccb_A4 - Ljt_ccb
    .word Lccb_A5 - Ljt_ccb
    .word Lccb_A6 - Ljt_ccb
    .word Lccb_A7 - Ljt_ccb
    .word Lccb_A8 - Ljt_ccb
    .word Lccb_A9 - Ljt_ccb
    .word Lccb_AA - Ljt_ccb
    .word Lccb_AB - Ljt_ccb
    .word Lccb_AC - Ljt_ccb
    .word Lccb_AD - Ljt_ccb
    .word Lccb_AE - Ljt_ccb
    .word Lccb_AF - Ljt_ccb
    .word Lccb_B0 - Ljt_ccb
    .word Lccb_B1 - Ljt_ccb
    .word Lccb_B2 - Ljt_ccb
    .word Lccb_B3 - Ljt_ccb
    .word Lccb_B4 - Ljt_ccb
    .word Lccb_B5 - Ljt_ccb
    .word Lccb_B6 - Ljt_ccb
    .word Lccb_B7 - Ljt_ccb
    .word Lccb_B8 - Ljt_ccb
    .word Lccb_B9 - Ljt_ccb
    .word Lccb_BA - Ljt_ccb
    .word Lccb_BB - Ljt_ccb
    .word Lccb_BC - Ljt_ccb
    .word Lccb_BD - Ljt_ccb
    .word Lccb_BE - Ljt_ccb
    .word Lccb_BF - Ljt_ccb
    .word Lccb_C0 - Ljt_ccb
    .word Lccb_C1 - Ljt_ccb
    .word Lccb_C2 - Ljt_ccb
    .word Lccb_C3 - Ljt_ccb
    .word Lccb_C4 - Ljt_ccb
    .word Lccb_C5 - Ljt_ccb
    .word Lccb_C6 - Ljt_ccb
    .word Lccb_C7 - Ljt_ccb
    .word Lccb_C8 - Ljt_ccb
    .word Lccb_C9 - Ljt_ccb
    .word Lccb_CA - Ljt_ccb
    .word Lccb_CB - Ljt_ccb
    .word Lccb_CC - Ljt_ccb
    .word Lccb_CD - Ljt_ccb
    .word Lccb_CE - Ljt_ccb
    .word Lccb_CF - Ljt_ccb
    .word Lccb_D0 - Ljt_ccb
    .word Lccb_D1 - Ljt_ccb
    .word Lccb_D2 - Ljt_ccb
    .word Lccb_D3 - Ljt_ccb
    .word Lccb_D4 - Ljt_ccb
    .word Lccb_D5 - Ljt_ccb
    .word Lccb_D6 - Ljt_ccb
    .word Lccb_D7 - Ljt_ccb
    .word Lccb_D8 - Ljt_ccb
    .word Lccb_D9 - Ljt_ccb
    .word Lccb_DA - Ljt_ccb
    .word Lccb_DB - Ljt_ccb
    .word Lccb_DC - Ljt_ccb
    .word Lccb_DD - Ljt_ccb
    .word Lccb_DE - Ljt_ccb
    .word Lccb_DF - Ljt_ccb
    .word Lccb_E0 - Ljt_ccb
    .word Lccb_E1 - Ljt_ccb
    .word Lccb_E2 - Ljt_ccb
    .word Lccb_E3 - Ljt_ccb
    .word Lccb_E4 - Ljt_ccb
    .word Lccb_E5 - Ljt_ccb
    .word Lccb_E6 - Ljt_ccb
    .word Lccb_E7 - Ljt_ccb
    .word Lccb_E8 - Ljt_ccb
    .word Lccb_E9 - Ljt_ccb
    .word Lccb_EA - Ljt_ccb
    .word Lccb_EB - Ljt_ccb
    .word Lccb_EC - Ljt_ccb
    .word Lccb_ED - Ljt_ccb
    .word Lccb_EE - Ljt_ccb
    .word Lccb_EF - Ljt_ccb
    .word Lccb_F0 - Ljt_ccb
    .word Lccb_F1 - Ljt_ccb
    .word Lccb_F2 - Ljt_ccb
    .word Lccb_F3 - Ljt_ccb
    .word Lccb_F4 - Ljt_ccb
    .word Lccb_F5 - Ljt_ccb
    .word Lccb_F6 - Ljt_ccb
    .word Lccb_F7 - Ljt_ccb
    .word Lccb_F8 - Ljt_ccb
    .word Lccb_F9 - Ljt_ccb
    .word Lccb_FA - Ljt_ccb
    .word Lccb_FB - Ljt_ccb
    .word Lccb_FC - Ljt_ccb
    .word Lccb_FD - Ljt_ccb
    .word Lccb_FE - Ljt_ccb
    .word Lccb_FF - Ljt_ccb

    .section .note.GNU-stack,"",%progbits
