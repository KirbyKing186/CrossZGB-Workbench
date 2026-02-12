;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Fade
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _FadeStepColor
	.globl _UpdateColor
	.globl _FadeDMG
	.globl _set_sprite_palette
	.globl _set_bkg_palette
	.globl _display_off
	.globl _vsync
	.globl _ZGB_Fading_SPal
	.globl _ZGB_Fading_BPal
	.globl b_FadeIn
	.globl _FadeIn
	.globl b_FadeOut
	.globl _FadeOut
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_FadeDMG_colors_10000_145:
	.ds 12
_ZGB_Fading_BPal::
	.ds 64
_ZGB_Fading_SPal::
	.ds 64
_FadeStepColor_palette_10000_181:
	.ds 64
_FadeStepColor_palette_s_10000_181:
	.ds 64
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
	.area _CODE_1
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:13: void FadeDMG(UINT8 fadeout) {
;	---------------------------------
; Function FadeDMG
; ---------------------------------
_FadeDMG::
	add	sp, #-10
	ldhl	sp,	#7
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:16: UINT8* c = colors;
	ld	(hl+), a
	ld	(hl), #<(_FadeDMG_colors_10000_145)
	inc	hl
	ld	(hl), #>(_FadeDMG_colors_10000_145)
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:20: for(i = 0; i != 3; ++i) {
	ldhl	sp,	#6
	ld	(hl), #0x00
00112$:
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:21: p = (UINT8)*(pals[i]);
	ldhl	sp,	#6
	ld	c, (hl)
	xor	a, a
	ld	l, c
	ld	h, a
	add	hl, hl
	ld	de, #_pals
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	ldhl	sp,	#2
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:22: for(j = 0; j != 8; j += 2, ++c) {
	ld	(hl+), a
	ld	(hl), #0x00
00110$:
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:23: *c = (DespRight(p, j)) & 0x3;
	ldhl	sp,	#2
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
;C:/CrossZGB/ZGB/common/include/Math.h:27: return a >> b;
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	inc	a
	jr	00219$
00218$:
	ldhl	sp,	#5
	sra	(hl)
	dec	hl
	rr	(hl)
00219$:
	dec	a
	jr	NZ, 00218$
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:23: *c = (DespRight(p, j)) & 0x3;
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x03
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:22: for(j = 0; j != 8; j += 2, ++c) {
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0x02
	ld	(hl), a
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00220$
	inc	hl
	inc	(hl)
00220$:
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x08
	jr	NZ, 00110$
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:20: for(i = 0; i != 3; ++i) {
	ldhl	sp,	#6
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00112$
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:27: for(i = 0; i != 4; ++i) {
	ldhl	sp,	#8
	ld	(hl), #0x00
00116$:
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:28: p = fadeout ? 3 - i : i;
	ldhl	sp,	#7
	ld	a, (hl)
	or	a, a
	jr	Z, 00120$
	inc	hl
	ld	a, #0x03
	sub	a, (hl)
	jr	00121$
00120$:
	ldhl	sp,	#8
	ld	a, (hl)
00121$:
	ldhl	sp,	#0
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:29: for(j = 0; j != 3; ++j) {
	ldhl	sp,	#9
	ld	(hl), #0x00
00114$:
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:30: c = &colors[j << 2];
	ldhl	sp,	#9
	ld	a, (hl)
	add	a, a
	add	a, a
	ld	e, a
	ld	d, #0x00
	ld	hl, #_FadeDMG_colors_10000_145
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:31: *pals[j] = DMG_PALETTE(FadeInOp(c[0], p), FadeInOp(c[1], p), FadeInOp(c[2], p), FadeInOp(c[3], p));
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_pals
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#3
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#6
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:8: return (c < i) ? 0: (c - i);
	ld	(hl), a
	ldhl	sp,	#0
	sub	a, (hl)
	jr	NC, 00122$
	ld	d, #0x00
	jr	00123$
00122$:
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	sub	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ld	d, (hl)
00123$:
	ld	a, d
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:31: *pals[j] = DMG_PALETTE(FadeInOp(c[0], p), FadeInOp(c[1], p), FadeInOp(c[2], p), FadeInOp(c[3], p));
	and	a, #0x03
	rrca
	rrca
	and	a, #0xc0
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#6
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:8: return (c < i) ? 0: (c - i);
	ld	(hl), a
	ldhl	sp,	#0
	sub	a, (hl)
	jr	NC, 00124$
	xor	a, a
	jr	00125$
00124$:
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	sub	a, (hl)
00125$:
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:31: *pals[j] = DMG_PALETTE(FadeInOp(c[0], p), FadeInOp(c[1], p), FadeInOp(c[2], p), FadeInOp(c[3], p));
	swap a
	and	a, #0x30
	ld	b, a
	ldhl	sp,	#5
	ld	a, (hl)
	or	a, b
	ld	c, a
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:8: return (c < i) ? 0: (c - i);
	ld	a, b
	ldhl	sp,	#0
	sub	a, (hl)
	jr	NC, 00126$
	xor	a, a
	jr	00127$
00126$:
	ld	a, b
	ldhl	sp,	#0
	sub	a, (hl)
00127$:
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:31: *pals[j] = DMG_PALETTE(FadeInOp(c[0], p), FadeInOp(c[1], p), FadeInOp(c[2], p), FadeInOp(c[3], p));
	and	a, #0x03
	add	a, a
	add	a, a
	or	a, c
	ld	c, a
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:8: return (c < i) ? 0: (c - i);
	ld	(hl), a
	ldhl	sp,	#0
	sub	a, (hl)
	jr	NC, 00128$
	ld	d, #0x00
	jr	00129$
00128$:
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	sub	a, (hl)
	ld	d, a
00129$:
	ld	a, d
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:31: *pals[j] = DMG_PALETTE(FadeInOp(c[0], p), FadeInOp(c[1], p), FadeInOp(c[2], p), FadeInOp(c[3], p));
	and	a, #0x03
	or	a, c
	ldhl	sp,	#3
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:29: for(j = 0; j != 3; ++j) {
	ldhl	sp,	#9
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x03
	jp	NZ, 00114$
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:33: vsync();
	call	_vsync
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:34: vsync();
	call	_vsync
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:27: for(i = 0; i != 4; ++i) {
	ldhl	sp,	#8
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x04
	jp	NZ, 00116$
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:36: }
	add	sp, #10
	ret
_pals:
	.dw _BGP_REG
	.dw _OBP0_REG
	.dw _OBP1_REG
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:42: palette_color_t UpdateColor(UINT8 i, UWORD col) {
;	---------------------------------
; Function UpdateColor
; ---------------------------------
_UpdateColor::
	add	sp, #-4
	ld	c, a
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:43: return RGB(PAL_RED(col) | DespRight(0x1F, 5 - i), PAL_GREEN(col) | DespRight(0x1F, 5 - i), PAL_BLUE(col) | DespRight(0x1F, 5 - i));
	ld	a, (hl)
	rrca
	rrca
	and	a, #0x1f
	ld	l, a
	ld	a, #0x05
	sub	a, c
	ld	e, a
	ld	d, e
;C:/CrossZGB/ZGB/common/include/Math.h:27: return a >> b;
	ld	bc, #0x001f
	inc	d
	jr	00107$
00106$:
	sra	b
	rr	c
00107$:
	dec	d
	jr	NZ, 00106$
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:43: return RGB(PAL_RED(col) | DespRight(0x1F, 5 - i), PAL_GREEN(col) | DespRight(0x1F, 5 - i), PAL_BLUE(col) | DespRight(0x1F, 5 - i));
	ld	a, l
	or	a, c
	and	a, #0x1f
	add	a, a
	add	a, a
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), #0x00
	ldhl	sp,#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, c
	and	a, #0x1f
	ld	d, a
	ld	h, e
;C:/CrossZGB/ZGB/common/include/Math.h:27: return a >> b;
	ld	bc, #0x001f
	inc	h
	jr	00109$
00108$:
	sra	b
	rr	c
00109$:
	dec	h
	jr	NZ, 00108$
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:43: return RGB(PAL_RED(col) | DespRight(0x1F, 5 - i), PAL_GREEN(col) | DespRight(0x1F, 5 - i), PAL_BLUE(col) | DespRight(0x1F, 5 - i));
	ld	a, d
	or	a, c
	and	a, #0x1f
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	a, (hl+)
	or	a, b
	ld	b, a
	ld	a, (hl)
	and	a, #0x1f
	ld	l, a
	ld	a, e
;C:/CrossZGB/ZGB/common/include/Math.h:27: return a >> b;
	push	af
	ld	de, #0x001f
	pop	af
	inc	a
	jr	00111$
00110$:
	sra	d
	rr	e
00111$:
	dec	a
	jr	NZ, 00110$
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:43: return RGB(PAL_RED(col) | DespRight(0x1F, 5 - i), PAL_GREEN(col) | DespRight(0x1F, 5 - i), PAL_BLUE(col) | DespRight(0x1F, 5 - i));
	ld	a, l
	or	a, e
	and	a, #0x1f
	or	a, c
	ld	c, a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:44: }
	add	sp, #4
	ret
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:46: void FadeStepColor(UINT8 i) {
;	---------------------------------
; Function FadeStepColor
; ---------------------------------
_FadeStepColor::
	add	sp, #-8
	ldhl	sp,	#2
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:49: palette_color_t* col = ZGB_Fading_BPal;
	ld	(hl+), a
	ld	a, #<(_ZGB_Fading_BPal)
	ld	(hl+), a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:50: palette_color_t* col_s = ZGB_Fading_SPal;
	ld	a, #>(_ZGB_Fading_BPal)
	ld	(hl+), a
	ld	a, #<(_ZGB_Fading_SPal)
	ld	(hl+), a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:52: for(UINT8 c = 0; c < 32; ++c, ++col, ++col_s) {
	ld	a, #>(_ZGB_Fading_SPal)
	ld	(hl+), a
	ld	(hl), #0x00
00103$:
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x20
	jr	NC, 00101$
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:53: palette[c] = UpdateColor(i, *col);
	ld	c, (hl)
	xor	a, a
	sla	c
	adc	a, a
	ldhl	sp,	#0
	ld	(hl), c
	inc	hl
	ld	(hl), a
	pop	de
	push	de
	ld	hl, #_FadeStepColor_palette_10000_181
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	e, l
	push	bc
	ld	d, a
	ldhl	sp,	#4
	ld	a, (hl)
	call	_UpdateColor
	ld	e, c
	ld	d, b
	pop	bc
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:54: palette_s[c] = UpdateColor(i, *col_s);
	pop	de
	push	de
	ld	hl, #_FadeStepColor_palette_s_10000_181
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	e, l
	push	bc
	ld	d, a
	ldhl	sp,	#4
	ld	a, (hl)
	call	_UpdateColor
	ld	e, c
	ld	d, b
	pop	bc
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:52: for(UINT8 c = 0; c < 32; ++c, ++col, ++col_s) {
	ldhl	sp,	#7
	inc	(hl)
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	jr	00103$
00101$:
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:57: vsync();
	call	_vsync
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:58: set_bkg_palette(0, 8, palette);
	ld	de, #_FadeStepColor_palette_10000_181
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:59: set_sprite_palette(0, 8, palette_s);
	ld	de, #_FadeStepColor_palette_s_10000_181
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_palette
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:60: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:61: vsync();
	call	_vsync
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:62: }
	add	sp, #8
	ret
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:65: void FadeIn(void) BANKED {
;	---------------------------------
; Function FadeIn
; ---------------------------------
	b_FadeIn	= 1
_FadeIn::
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:67: if (_cpu == CGB_TYPE) {
	ld	hl, #__cpu
	ld	a, (hl)
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:68: for(UINT8 i = 0; i != 6; i ++) FadeStepColor(i);
	sub	a, #0x11
	jr	NZ, 00103$
	ld	c, a
00106$:
	ld	a, c
	sub	a, #0x06
	jp	Z, _display_off
	push	bc
	ld	a, c
	call	_FadeStepColor
	pop	bc
	inc	c
	jr	00106$
00103$:
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:71: FadeDMG(0);
	xor	a, a
	call	_FadeDMG
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:75: DISPLAY_OFF;
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:76: }
	jp	_display_off
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:78: void FadeOut(void) BANKED {
;	---------------------------------
; Function FadeOut
; ---------------------------------
	b_FadeOut	= 1
_FadeOut::
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:80: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00103$
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:81: for(UINT8 i = 5; i != 0xFF; -- i) FadeStepColor(i);	
	ld	c, #0x05
00106$:
	ld	a, c
	inc	a
	ret	Z
	push	bc
	ld	a, c
	call	_FadeStepColor
	pop	bc
	dec	c
	jr	00106$
00103$:
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:84: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:85: FadeDMG(1);
	ld	a, #0x01
;C:/CrossZGB/ZGB/common/src/gb/Fade.c:89: }
	jp	_FadeDMG
	.area _CODE_1
	.area _INITIALIZER
	.area _CABS (ABS)
