# The PS Vita version of Pinball NS (VitaSDK, vita2d):
#   cmake -S platform/vita -B build/vita && cmake --build build/vita     ->  build/vita/PinballNS.vpk
cmake_minimum_required(VERSION 3.16)

if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
  if(DEFINED ENV{VITASDK})
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VITASDK}/share/vita.toolchain.cmake" CACHE PATH "toolchain file")
  else()
    message(FATAL_ERROR "Please define VITASDK to point to your SDK path!")
  endif()
endif()

project(PinballNS C ASM)
include("$ENV{VITASDK}/share/vita.cmake" REQUIRED)

set(VITA_APP_NAME "Pinball NS")
set(VITA_TITLEID "PBNS00001")
set(VITA_VERSION "01.00")

set(ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../..)

add_executable(pinball-ns
  ${ROOT}/platform/vita/main_vita.c
  ${ROOT}/platform/desktop/desk.c
  ${ROOT}/platform/mobile/ui.c
  ${ROOT}/platform/mobile/design.c
  ${ROOT}/platform/mobile/screen.c
  ${ROOT}/src/game/pinball.c
  ${ROOT}/src/core/gbc.c
  ${ROOT}/src/core/gbc_exec.c
  ${ROOT}/src/core/gbc_ppu.c
  ${ROOT}/src/core/gbc_apu.c
  ${ROOT}/src/core/cpu_a32.S
)

# Speed: -O3 with link-time optimisation (the emulator's hot paths inlined across files), ARM code (not
# Thumb), tuned for the Vita's Cortex-A9; no -ffast-math (the sound keeps its exact arithmetic: gbc_apu.c).
set(PNS_CFLAGS -O3 -flto -std=gnu11 -fomit-frame-pointer -fno-common -fno-semantic-interposition
  -Wall -Wno-unused-function -Wno-missing-field-initializers)
target_compile_options(pinball-ns PRIVATE "$<$<COMPILE_LANGUAGE:C>:${PNS_CFLAGS}>"
  -marm -mcpu=cortex-a9 -mtune=cortex-a9 -mfpu=neon -mfloat-abi=hard)
# the CPU of the Game Boy in assembly (src/core/cpu_a32.S, written by tools/gencpu.c), NEON in the PPU
target_compile_definitions(pinball-ns PRIVATE PB_ASM)
target_link_options(pinball-ns PRIVATE -O3 -flto -marm -mcpu=cortex-a9 -mfpu=neon -mfloat-abi=hard)
target_compile_definitions(pinball-ns PRIVATE _DEFAULT_SOURCE)

target_link_libraries(pinball-ns
  vita2d freetype png jpeg z m pthread
  SceDisplay_stub SceGxm_stub SceSysmodule_stub SceCtrl_stub SceTouch_stub SceMotion_stub SceAudio_stub
  ScePower_stub ScePgf_stub SceCommonDialog_stub SceAppUtil_stub SceKernelThreadMgr_stub SceAppMgr_stub)

vita_create_self(eboot.bin pinball-ns)
vita_create_vpk(PinballNS.vpk ${VITA_TITLEID} eboot.bin
  VERSION ${VITA_VERSION}
  NAME ${VITA_APP_NAME}
  FILE ${CMAKE_CURRENT_SOURCE_DIR}/sce_sys/icon0.png sce_sys/icon0.png
  FILE ${CMAKE_CURRENT_SOURCE_DIR}/sce_sys/pic0.png sce_sys/pic0.png
  FILE ${CMAKE_CURRENT_SOURCE_DIR}/chooser_bg.png chooser_bg.png
)
