;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module DefScrollLimits
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ClampScrollLimits
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
;C:/CrossZGB/ZGB/common/src/DefScrollLimits.c:4: void ClampScrollLimits(void) {
;	---------------------------------
; Function ClampScrollLimits
; ---------------------------------
_ClampScrollLimits::
;C:/CrossZGB/ZGB/common/src/DefScrollLimits.c:5: if (clamp_enabled) {
	ld	a, (#_clamp_enabled)
	or	a, a
	ret	Z
;C:/CrossZGB/ZGB/common/src/DefScrollLimits.c:6: if (scroll_w < SCREEN_WIDTH) scroll_x = 0u;
	ld	hl, #_scroll_w
	ld	a, (hl+)
	sub	a, #0xa0
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00104$
	xor	a, a
	ld	hl, #_scroll_x
	ld	(hl+), a
	ld	(hl), a
	jr	00105$
00104$:
;C:/CrossZGB/ZGB/common/src/DefScrollLimits.c:7: else if (scroll_x < 0) scroll_x = 0u;
	ld	hl, #_scroll_x + 1
	bit	7, (hl)
	jr	Z, 00105$
	dec	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00105$:
;C:/CrossZGB/ZGB/common/src/DefScrollLimits.c:9: if (scroll_x > (scroll_w - SCREEN_WIDTH)) scroll_x = (scroll_w - SCREEN_WIDTH);
	ld	hl, #_scroll_w
	ld	a, (hl+)
	add	a, #0x60
	ld	c, a
	ld	a, (hl)
	adc	a, #0xff
	ld	b, a
	ld	a, (_scroll_x)
	ld	e, a
	ld	hl, #_scroll_x + 1
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	a, b
	sbc	a, d
	jr	NC, 00107$
	dec	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00107$:
;C:/CrossZGB/ZGB/common/src/DefScrollLimits.c:11: if (scroll_h < (SCREEN_HEIGHT - scroll_h_border)) scroll_y = 0u;
	ld	a, #0x90
	ld	hl, #_scroll_h_border
	sub	a, (hl)
	inc	hl
	ld	c, a
	sbc	a, a
	sub	a, (hl)
	ld	b, a
	ld	hl, #_scroll_h
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00111$
	xor	a, a
	ld	hl, #_scroll_y
	ld	(hl+), a
	ld	(hl), a
	jr	00112$
00111$:
;C:/CrossZGB/ZGB/common/src/DefScrollLimits.c:12: else if (scroll_y < 0) scroll_y = 0u;
	ld	hl, #_scroll_y + 1
	bit	7, (hl)
	jr	Z, 00112$
	dec	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00112$:
;C:/CrossZGB/ZGB/common/src/DefScrollLimits.c:14: if (scroll_y > (scroll_h - SCREEN_HEIGHT + scroll_h_border)) scroll_y = (scroll_h - SCREEN_HEIGHT + scroll_h_border);
	ld	hl, #_scroll_h
	ld	a, (hl+)
	add	a, #0x70
	ld	c, a
	ld	a, (hl)
	adc	a, #0xff
	ld	b, a
	ld	a, (_scroll_h_border)
	ld	l, a
	ld	a, (_scroll_h_border + 1)
	ld	h, a
	add	hl, bc
	ld	e, l
	ld	a, (_scroll_y)
	ld	c, a
	ld	a, (_scroll_y + 1)
	ld	l, a
	ld	a, e
	sub	a, c
	ld	a, h
	sbc	a, l
	ret	NC
	ld	d, h
	ld	hl, #_scroll_y
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/DefScrollLimits.c:16: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
