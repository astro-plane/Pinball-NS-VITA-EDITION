/* gencpu_a32.h - the offsets of the fields of GBC used by cpu_a32.S, as a 32-bit ARM compiler (EABI:
 * 4-byte pointers, 8-byte aligned 64-bit integers) lays GBC out; gencpu runs on a 64-bit machine, so
 * they are measured on the target and kept here (gbc_asm32.h checks them in every 32-bit build: a
 * compilation error when GBC changed; measure them again then, see tools/README or the probe in the
 * history of this file: offsetof of each field below, built for armv7a). */
#ifndef GENCPU_A32_H
#define GENCPU_A32_H
#define A32_S_A 16
#define A32_S_F 17
#define A32_S_B 18
#define A32_S_D 20
#define A32_S_H 22
#define A32_S_SP 24
#define A32_S_PC 26
#define A32_S_CYCLES 32
#define A32_S_DIV16 65850
#define A32_S_ROM_BANK 40
#define A32_ROM 0
#define A32_ROM_MASK 12
#define A32_HOOKBYTE 498048
#define A32_FAST 571776
#define A32_X_RD 0
#define A32_X_WR 64
#define A32_X_WRF 1784
#define A32_X_OAMB 132
#define A32_X_HRAMB 136
#define A32_X_WATCH 140
#define A32_X_HOOKS 144
#define A32_X_DEADLINE 152
#define A32_X_DL24 160
#define A32_X_FRAME_END 168
#define A32_X_LIMIT 176
#define A32_X_VLO 184
#define A32_X_VHI 188
#define A32_X_VMIR_LO 192
#define A32_X_VMIR_HI 196
#define A32_X_VMIR_A0 200
#define A32_X_VMIR_A1 204
#define A32_X_DIV_BASE 208
#define A32_X_SPECIAL 210
#define A32_X_FROZEN 211
#define A32_X_TMP 212
#define A32_X_VFAST 214
#define A32_X_MBC5 215
#define A32_X_FF41 216
#define A32_X_FF44 217
#define A32_X_STOP_PC 224
#define A32_X_STOP_SP 228
#define A32_SIZES (165224 + 2824)
#endif
