;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Interrupts
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _LCD_isr
	.globl _display_off
	.globl _add_LCD
	.globl _remove_LCD
	.globl _lcd_step
	.globl _gradient_colors
	.globl _isrColor
	.globl _effect_isr
	.globl _build_gradient
	.globl _InitSpecialInterrupts
	.globl _RestoreDefaultInterrupts
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_isrColor::
	.ds 2
_gradient_colors::
	.ds 288
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
___CRASH_HANDLER_INIT:
	.ds 2
_lcd_step::
	.ds 1
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
;Interrupts.c:13: void effect_isr(void) NONBANKED {
;	---------------------------------
; Function effect_isr
; ---------------------------------
_effect_isr::
;Interrupts.c:15: isrColor = gradient_colors[LY_REG];
	ldh	a, (_LY_REG + 0)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	ld	de, #_gradient_colors
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #_isrColor
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;Interrupts.c:17: while (STAT_REG & STATF_BUSY);
00101$:
	ldh	a, (_STAT_REG + 0)
	bit	1, a
	jr	NZ, 00101$
;Interrupts.c:37: BCPS_REG = (0x02 << 1) | 0x80; 
	ld	a, #0x84
	ldh	(_BCPS_REG + 0), a
;Interrupts.c:38: BCPD_REG = isrColor & 0xFF;
	ld	a, (_isrColor)
	ld	c, a
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:39: BCPD_REG = isrColor >> 8;
	ld	a, (_isrColor + 1)
	ld	b, a
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:40: BCPS_REG = (0x06 << 1) | 0x80; 
	ld	a, #0x8c
	ldh	(_BCPS_REG + 0), a
;Interrupts.c:41: BCPD_REG = isrColor & 0xFF;
	ld	a, c
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:42: BCPD_REG = isrColor >> 8;
	ld	a, b
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:43: BCPS_REG = (0x0B << 1) | 0x80; 
	ld	a, #0x96
	ldh	(_BCPS_REG + 0), a
;Interrupts.c:44: BCPD_REG = isrColor & 0xFF;
	ld	a, c
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:45: BCPD_REG = isrColor >> 8;
	ld	a, b
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:46: BCPS_REG = (0x0E << 1) | 0x80; 
	ld	a, #0x9c
	ldh	(_BCPS_REG + 0), a
;Interrupts.c:47: BCPD_REG = isrColor & 0xFF;
	ld	a, c
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:48: BCPD_REG = isrColor >> 8;
	ld	a, b
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:49: BCPS_REG = (0x11 << 1) | 0x80; 
	ld	a, #0xa2
	ldh	(_BCPS_REG + 0), a
;Interrupts.c:50: BCPD_REG = isrColor & 0xFF;
	ld	a, c
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:51: BCPD_REG = isrColor >> 8;
	ld	a, b
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:52: BCPS_REG = (0x17 << 1) | 0x80; 
	ld	a, #0xae
	ldh	(_BCPS_REG + 0), a
;Interrupts.c:53: BCPD_REG = isrColor & 0xFF;
	ld	a, c
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:54: BCPD_REG = isrColor >> 8;
	ld	a, b
	ldh	(_BCPD_REG + 0), a
;Interrupts.c:57: LYC_REG += lcd_step;
	ldh	a, (_LYC_REG + 0)
	ld	hl, #_lcd_step
	add	a, (hl)
	ldh	(_LYC_REG + 0), a
;Interrupts.c:59: if (LYC_REG > 143u) LYC_REG = 0;
	ldh	a, (_LYC_REG + 0)
	ld	b, a
	ld	a, #0x8f
	sub	a, b
	ret	NC
	xor	a, a
	ldh	(_LYC_REG + 0), a
;Interrupts.c:61: }
	ret
;Interrupts.c:82: void InitSpecialInterrupts(palette_color_t start_color, palette_color_t end_color, UINT8 lcd_space) NONBANKED {
;	---------------------------------
; Function InitSpecialInterrupts
; ---------------------------------
_InitSpecialInterrupts::
	dec	sp
;Interrupts.c:83: lcd_step = lcd_space;
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_lcd_step),a
;Interrupts.c:84: UINT8 is_display_on = LCDC_REG & LCDCF_ON; // If the display was on, turn it off while running interrupt code and turn it back on when done. Otherwise, keep it off.
	ldh	a, (_LCDC_REG + 0)
	and	a, #0x80
	ldhl	sp,	#0
	ld	(hl), a
;Interrupts.c:85: if (is_display_on) DISPLAY_OFF;
	or	a, a
	jr	Z, 00102$
	call	_display_off
00102$:
;Interrupts.c:92: }
	di
;Interrupts.c:87: remove_LCD(effect_isr);
	push	bc
	push	de
	ld	de, #_effect_isr
	call	_remove_LCD
;Interrupts.c:88: remove_LCD(LCD_isr);
	ld	de, #_LCD_isr
	call	_remove_LCD
	pop	de
	pop	bc
;Interrupts.c:89: LYC_REG = 0;
	xor	a, a
	ldh	(_LYC_REG + 0), a
;Interrupts.c:90: build_gradient(start_color, end_color);
	call	_build_gradient
;Interrupts.c:91: add_LCD(effect_isr);
	ld	de, #_effect_isr
	call	_add_LCD
	ei
;Interrupts.c:93: if (is_display_on) DISPLAY_ON;
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00105$
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
00105$:
;Interrupts.c:94: }
	inc	sp
	pop	hl
	inc	sp
	jp	(hl)
;Interrupts.c:96: void RestoreDefaultInterrupts(void) NONBANKED {
;	---------------------------------
; Function RestoreDefaultInterrupts
; ---------------------------------
_RestoreDefaultInterrupts::
;Interrupts.c:102: }
	di
;Interrupts.c:98: STAT_REG = STATF_LYC;
	ld	a, #0x40
	ldh	(_STAT_REG + 0), a
;Interrupts.c:99: remove_LCD(effect_isr);
	ld	de, #_effect_isr
	call	_remove_LCD
;Interrupts.c:100: remove_LCD(LCD_isr);
	ld	de, #_LCD_isr
	call	_remove_LCD
;Interrupts.c:101: add_LCD(LCD_isr);
	ld	de, #_LCD_isr
	call	_add_LCD
	ei
;Interrupts.c:103: }
	ret
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;Interrupts.c:63: void build_gradient(palette_color_t start_color, palette_color_t end_color) {
;	---------------------------------
; Function build_gradient
; ---------------------------------
_build_gradient::
	add	sp, #-13
;Interrupts.c:65: UINT8 r0 = PAL_RED(start_color);
	ld	a, e
	and	a, #0x1f
	ldhl	sp,	#0
	ld	(hl), a
;Interrupts.c:66: UINT8 g0 = PAL_GREEN(start_color);
	ld	l, e
	ld	h, d
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	srl	h
	rr	l
	ld	a, l
	and	a, #0x1f
	ldhl	sp,	#1
;Interrupts.c:67: UINT8 b0 = PAL_BLUE(start_color);
	ld	(hl+), a
	ld	a, d
	rrca
	rrca
	and	a, #0x1f
;Interrupts.c:69: UINT8 r1 = PAL_RED(end_color);
	ld	(hl+), a
	ld	a, c
	and	a, #0x1f
;Interrupts.c:70: UINT8 g1 = PAL_GREEN(end_color);
	ld	(hl+), a
	ld	e, c
	ld	d, b
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, e
	and	a, #0x1f
;Interrupts.c:71: UINT8 b1 = PAL_BLUE(end_color);
	ld	(hl+), a
	ld	a, b
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
	ld	b, #0x00
	ld	a, c
	and	a, #0x1f
	ld	(hl), a
;Interrupts.c:73: for (UINT8 step = 0; step < DEVICE_SCREEN_PX_HEIGHT; step++) {
	ldhl	sp,	#12
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#12
;Interrupts.c:74: gradient_colors[step] = RGB(
	ld	a,(hl)
	cp	a,#0x90
	jp	NC,00105$
	ldhl	sp,	#6
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ld	d, #0x00
	add	a, a
	rl	d
	ld	e, a
	ld	hl, #_gradient_colors
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#2
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, e
	ld	l, a
	sbc	a, a
	sub	a, d
	push	de
	push	hl
	ldhl	sp,	#10
	ld	c, (hl)
	ld	b, #0x00
	pop	hl
	ld	e, l
	ld	d, a
	call	__mulint
	ld	l, c
	ld	h, b
	ld	bc, #0x008f
	ld	e, l
	ld	d, h
	call	__divsint
	pop	de
	ld	l, c
	ld	h, b
	add	hl, de
	ld	a, l
	and	a, #0x1f
	add	a, a
	add	a, a
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), #0x00
	ldhl	sp,	#1
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, e
	ld	l, a
	sbc	a, a
	sub	a, d
	push	de
	push	hl
	ldhl	sp,	#10
	ld	c, (hl)
	ld	b, #0x00
	pop	hl
	ld	e, l
	ld	d, a
	call	__mulint
	ld	l, c
	ld	h, b
	ld	bc, #0x008f
	ld	e, l
	ld	d, h
	call	__divsint
	pop	de
	ld	l, c
	ld	h, b
	add	hl, de
	ld	a, l
	and	a, #0x1f
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	(hl), c
	inc	hl
	or	a, b
	ld	(hl), a
	ldhl	sp,	#0
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, e
	ld	l, a
	sbc	a, a
	sub	a, d
	push	de
	push	hl
	ldhl	sp,	#10
	ld	c, (hl)
	ld	b, #0x00
	pop	hl
	ld	e, l
	ld	d, a
	call	__mulint
	ld	l, c
	ld	h, b
	ld	bc, #0x008f
	ld	e, l
	ld	d, h
	call	__divsint
	pop	hl
	add	hl, bc
	ld	a, l
	and	a, #0x1f
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	b, (hl)
	or	a, e
	ld	c, a
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;Interrupts.c:73: for (UINT8 step = 0; step < DEVICE_SCREEN_PX_HEIGHT; step++) {
	ldhl	sp,	#12
	inc	(hl)
	jp	00103$
00105$:
;Interrupts.c:80: }
	add	sp, #13
	ret
	.area _CODE
	.area _INITIALIZER
__xinit____CRASH_HANDLER_INIT:
	.dw ___HandleCrash
__xinit__lcd_step:
	.db #0x08	; 8
	.area _CABS (ABS)
