;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Palette
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcpy
	.globl _set_sprite_palette
	.globl _set_bkg_palette
	.globl _last_bg_pal_loaded
	.globl _default_palette
	.globl b_SetDefaultColorPalettes
	.globl _SetDefaultColorPalettes
	.globl _SetPalette
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
_last_bg_pal_loaded::
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
;C:/CrossZGB/ZGB/common/src/Palette.c:27: INT8 SetPalette(PALETTE_TYPE t, UINT8 first_palette, UINT8 nb_palettes, const palette_color_t *rgb_data, UINT8 bank) NONBANKED {
;	---------------------------------
; Function SetPalette
; ---------------------------------
_SetPalette::
	add	sp, #-9
	ldhl	sp,	#8
	ld	(hl-), a
	ld	(hl), e
;C:/CrossZGB/ZGB/common/src/Palette.c:32: if (!nb_palettes)
	ldhl	sp,	#11
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;C:/CrossZGB/ZGB/common/src/Palette.c:33: return 0;
	xor	a, a
	jp	00108$
00102$:
;C:/CrossZGB/ZGB/common/src/Palette.c:34: if ((first_palette + nb_palettes) > MAX_PALETTES)
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#11
	ld	c, (hl)
	ld	b, #0x00
	pop	hl
	push	hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, #0x08
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00104$
;C:/CrossZGB/ZGB/common/src/Palette.c:35: return 0; // Adding more palettes than supported
	xor	a, a
	jp	00108$
00104$:
;C:/CrossZGB/ZGB/common/src/Palette.c:37: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#2
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Palette.c:38: SWITCH_ROM(bank);
	ldhl	sp,	#14
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Palette.c:40: if (t == BG_PALETTE) {
	ldhl	sp,	#8
	bit	0, (hl)
	jr	NZ, 00106$
;C:/CrossZGB/ZGB/common/src/Palette.c:41: set_bkg_palette(first_palette, nb_palettes, rgb_data);
	push	bc
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
	pop	bc
	jr	00107$
00106$:
;C:/CrossZGB/ZGB/common/src/Palette.c:43: set_sprite_palette(first_palette, nb_palettes, rgb_data);
	push	bc
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_set_sprite_palette
	add	sp, #4
	pop	bc
00107$:
;C:/CrossZGB/ZGB/common/src/Palette.c:45: memcpy(((t == BG_PALETTE) ? ZGB_Fading_BPal : ZGB_Fading_SPal) + (first_palette * N_PALETTE_COLORS), rgb_data, nb_palettes * PALETTE_SIZE);
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#8
	bit	0, (hl)
	jr	NZ, 00110$
	ld	de, #_ZGB_Fading_BPal+0
	ldhl	sp,	#5
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	jr	00111$
00110$:
	ld	de, #_ZGB_Fading_SPal+0
	ldhl	sp,	#5
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00111$:
	ldhl	sp,	#0
	ld	a, (hl)
	ld	d, #0x00
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	ld	e, a
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_memcpy
;C:/CrossZGB/ZGB/common/src/Palette.c:46: SWITCH_ROM(__save);
	ldhl	sp,	#2
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Palette.c:48: return nb_palettes;
	ldhl	sp,	#11
	ld	a, (hl)
00108$:
;C:/CrossZGB/ZGB/common/src/Palette.c:50: }
	add	sp, #9
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_1
;C:/CrossZGB/ZGB/common/src/Palette.c:14: void SetDefaultColorPalettes(void) BANKED {
;	---------------------------------
; Function SetDefaultColorPalettes
; ---------------------------------
	b_SetDefaultColorPalettes	= 1
_SetDefaultColorPalettes::
;C:/CrossZGB/ZGB/common/src/Palette.c:16: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	ret	NZ
;C:/CrossZGB/ZGB/common/src/Palette.c:18: set_bkg_palette(0, MAX_PALETTES, default_palette);
	ld	de, #_default_palette
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/Palette.c:19: memcpy(ZGB_Fading_BPal, default_palette, MAX_PALETTES * PALETTE_SIZE);
	ld	de, #0x0040
	push	de
	ld	bc, #_default_palette
	ld	de, #_ZGB_Fading_BPal
	call	_memcpy
;C:/CrossZGB/ZGB/common/src/Palette.c:20: set_sprite_palette(0, MAX_PALETTES, default_palette);
	ld	de, #_default_palette
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_palette
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/Palette.c:21: memcpy(ZGB_Fading_SPal, default_palette, MAX_PALETTES * PALETTE_SIZE);
	ld	de, #0x0040
	push	de
	ld	bc, #_default_palette
	ld	de, #_ZGB_Fading_SPal
	call	_memcpy
;C:/CrossZGB/ZGB/common/src/Palette.c:25: }
	ret
_default_palette:
	.dw #0x7fff
	.dw #0x5294
	.dw #0x294a
	.dw #0x0000
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.area _CODE_1
	.area _INITIALIZER
__xinit__last_bg_pal_loaded:
	.db #0x00	; 0
	.area _CABS (ABS)
