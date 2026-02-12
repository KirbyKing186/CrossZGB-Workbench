;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module DefTileReplacement
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _GetTileReplacement
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;C:/CrossZGB/ZGB/common/src/DefTileReplacement.c:4: UINT8 GetTileReplacement(UINT8* tile_ptr, UINT8* tile) {
;	---------------------------------
; Function GetTileReplacement
; ---------------------------------
_GetTileReplacement::
;C:/CrossZGB/ZGB/common/src/DefTileReplacement.c:6: return 255u;    // don't replace anything
	ld	a, #0xff
;C:/CrossZGB/ZGB/common/src/DefTileReplacement.c:7: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
