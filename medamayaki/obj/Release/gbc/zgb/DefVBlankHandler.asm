;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module DefVBlankHandler
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _VBL_isr
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
;C:/CrossZGB/ZGB/common/src/DefVBlankHandler.c:7: void VBL_isr(void) NONBANKED {
;	---------------------------------
; Function VBL_isr
; ---------------------------------
_VBL_isr::
;C:/CrossZGB/ZGB/common/src/DefVBlankHandler.c:8: vbl_count ++;
	ld	hl, #_vbl_count
	inc	(hl)
;C:/CrossZGB/ZGB/common/src/DefVBlankHandler.c:10: move_bkg(scroll_x_vblank + TILE_TO_PX(scroll_offset_x), scroll_y_vblank + TILE_TO_PX(scroll_offset_y));
	ld	a, (_scroll_y_vblank)
	ld	c, a
	ld	a, (#_scroll_offset_y)
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ld	c, a
	ld	a, (_scroll_x_vblank)
	ld	b, a
	ld	a, (#_scroll_offset_x)
	add	a, a
	add	a, a
	add	a, a
	add	a, b
	ldh	(_SCX_REG + 0), a
;c:\crosszgb\gbdk\include\gb\gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;C:/CrossZGB/ZGB/common/src/DefVBlankHandler.c:10: move_bkg(scroll_x_vblank + TILE_TO_PX(scroll_offset_x), scroll_y_vblank + TILE_TO_PX(scroll_offset_y));
;C:/CrossZGB/ZGB/common/src/DefVBlankHandler.c:17: }
	ret
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
