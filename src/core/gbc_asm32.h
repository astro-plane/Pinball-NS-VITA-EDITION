/* gbc_asm32.h - written by tools/gencpu.c: the offsets of the fields of GBC used by cpu_a32.S
 * (tools/gencpu_a32.h, measured on a 32-bit ARM target). Included by gbc_exec.c in 32-bit builds,
 * where an offset that differs stops the compilation: measure them again and run gencpu. */
#ifndef GBC_ASM32_H
#define GBC_ASM32_H

#include <stddef.h>

#define GBC_ASM_CHECK(name, expr, value) typedef char gbc_asm_check_##name[(expr) == (value) ? 1 : -1];

GBC_ASM_CHECK(a, offsetof(GBC, s.a), 16)
GBC_ASM_CHECK(f, offsetof(GBC, s.f), 17)
GBC_ASM_CHECK(b, offsetof(GBC, s.b), 18)
GBC_ASM_CHECK(c, offsetof(GBC, s.c), 19)
GBC_ASM_CHECK(d, offsetof(GBC, s.d), 20)
GBC_ASM_CHECK(e, offsetof(GBC, s.e), 21)
GBC_ASM_CHECK(h, offsetof(GBC, s.h), 22)
GBC_ASM_CHECK(l, offsetof(GBC, s.l), 23)
GBC_ASM_CHECK(sp, offsetof(GBC, s.sp), 24)
GBC_ASM_CHECK(pc, offsetof(GBC, s.pc), 26)
GBC_ASM_CHECK(cycles, offsetof(GBC, s.cycles), 32)
GBC_ASM_CHECK(div16, offsetof(GBC, s.div16), 65850)
GBC_ASM_CHECK(rom_bank, offsetof(GBC, s.rom_bank), 40)
GBC_ASM_CHECK(rom, offsetof(GBC, rom), 0)
GBC_ASM_CHECK(rom_mask, offsetof(GBC, rom_mask), 12)
GBC_ASM_CHECK(hookbyte, offsetof(GBC, hookbyte), 498048)
GBC_ASM_CHECK(fast, offsetof(GBC, fast), 571776)
GBC_ASM_CHECK(rd, offsetof(GBCFast, rd), 0)
GBC_ASM_CHECK(wr, offsetof(GBCFast, wr), 64)
GBC_ASM_CHECK(wrf, offsetof(GBCFast, wrf), 1784)
GBC_ASM_CHECK(oamb, offsetof(GBCFast, oamb), 132)
GBC_ASM_CHECK(hramb, offsetof(GBCFast, hramb), 136)
GBC_ASM_CHECK(watch, offsetof(GBCFast, watch), 140)
GBC_ASM_CHECK(hooks, offsetof(GBCFast, hooks), 144)
GBC_ASM_CHECK(deadline, offsetof(GBCFast, deadline), 152)
GBC_ASM_CHECK(dl24, offsetof(GBCFast, dl24), 160)
GBC_ASM_CHECK(frame_end, offsetof(GBCFast, frame_end), 168)
GBC_ASM_CHECK(limit, offsetof(GBCFast, limit), 176)
GBC_ASM_CHECK(vlo, offsetof(GBCFast, vlo), 184)
GBC_ASM_CHECK(vhi, offsetof(GBCFast, vhi), 188)
GBC_ASM_CHECK(vmir_lo, offsetof(GBCFast, vmir_lo), 192)
GBC_ASM_CHECK(vmir_hi, offsetof(GBCFast, vmir_hi), 196)
GBC_ASM_CHECK(vmir_a0, offsetof(GBCFast, vmir_a0), 200)
GBC_ASM_CHECK(vmir_a1, offsetof(GBCFast, vmir_a1), 204)
GBC_ASM_CHECK(div_base, offsetof(GBCFast, div_base), 208)
GBC_ASM_CHECK(special, offsetof(GBCFast, special), 210)
GBC_ASM_CHECK(frozen, offsetof(GBCFast, frozen), 211)
GBC_ASM_CHECK(tmp, offsetof(GBCFast, tmp), 212)
GBC_ASM_CHECK(vfast, offsetof(GBCFast, vfast), 214)
GBC_ASM_CHECK(mbc5, offsetof(GBCFast, mbc5), 215)
GBC_ASM_CHECK(ff41, offsetof(GBCFast, ff41), 216)
GBC_ASM_CHECK(ff44, offsetof(GBCFast, ff44), 217)
GBC_ASM_CHECK(stop_pc, offsetof(GBCFast, stop_pc), 224)
GBC_ASM_CHECK(stop_sp, offsetof(GBCFast, stop_sp), 228)
GBC_ASM_CHECK(sizes, sizeof(GBCState) + sizeof(GBCFast), 168048)

#endif
