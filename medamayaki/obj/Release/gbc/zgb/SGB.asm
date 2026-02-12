;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module SGB
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _LoadSGBBorder
	.globl _set_sgb_border
	.globl _sgb_transfer
	.globl _fill_bkg_rect
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _set_vram_byte
	.globl _display_off
	.globl _vsync
	.globl _memset
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
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:19: void set_sgb_border(unsigned char * tiledata, size_t tiledata_size,
;	---------------------------------
; Function set_sgb_border
; ---------------------------------
_set_sgb_border::
	add	sp, #-23
	ldhl	sp,	#16
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#20
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:23: if (_is_SGB) {
	ld	a, (#__is_SGB)
	or	a, a
	jp	Z, 00119$
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:25: memset(map_buf, 0, sizeof(map_buf));
	ld	hl, #0
	add	hl, sp
	ld	de, #0x0010
	push	de
	ld	de, #0x0000
	push	de
	push	hl
	call	_memset
	add	sp, #6
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:27: SGB_TRANSFER(SGB_MASK_EN, SGB_SCR_FREEZE); 
	ldhl	sp,	#0
	ld	a, #0xb9
	ld	(hl+), a
	ld	(hl), #0x01
	ld	hl, #0
	add	hl, sp
	push	hl
	call	_sgb_transfer
	pop	hl
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:29: UINT8 __save_BGP = BGP_REG, __save_lcdc = LCDC_REG;
	ldh	a, (_BGP_REG + 0)
	ldhl	sp,	#18
	ld	(hl+), a
	ldh	a, (_LCDC_REG + 0)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:30: HIDE_SPRITES, HIDE_WIN, SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:31: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:33: BGP_REG = DMG_PALETTE(DMG_WHITE, DMG_LITE_GRAY, DMG_DARK_GRAY, DMG_BLACK);
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:34: SCX_REG = SCY_REG = 0U;
	xor	a, a
	ldh	(_SCY_REG + 0), a
	xor	a, a
	ldh	(_SCX_REG + 0), a
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:37: for (UINT8 y = 0, tile = 0; y != 14; y++) {
	ld	de, #0x0
00117$:
	ld	a, d
	sub	a, #0x0e
	jr	Z, 00102$
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:38: UINT8 * ptr = set_bkg_tile_xy(0, y, tile++);
	ld	a, e
	inc	e
	push	de
	push	af
	inc	sp
	ld	e, d
	xor	a, a
	call	_set_bkg_tile_xy
	pop	de
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:39: for (UINT8 x = 0; x != (DEVICE_SCREEN_WIDTH - 1); x++)
	ld	l, #0x00
00114$:
	ld	a, l
	sub	a, #0x13
	jr	Z, 00132$
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:40: set_vram_byte(++ptr, tile++);
	ld	a, e
	inc	e
	inc	bc
	push	hl
	push	de
	ld	e, c
	ld	d, b
	call	_set_vram_byte
	pop	de
	pop	hl
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:39: for (UINT8 x = 0; x != (DEVICE_SCREEN_WIDTH - 1); x++)
	inc	l
	jr	00114$
00132$:
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:37: for (UINT8 y = 0, tile = 0; y != 14; y++) {
	inc	d
	jr	00117$
00102$:
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:45: UINT8 ntiles = (tiledata_size > 256 * 32) ? 0 : tiledata_size >> 5;
	ldhl	sp,	#20
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x20
	sbc	a, (hl)
	jr	NC, 00121$
	ld	bc, #0x0000
	jr	00122$
00121$:
	ldhl	sp,#20
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
00122$:
	ldhl	sp,	#22
	ld	(hl), c
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:27: SGB_TRANSFER(SGB_MASK_EN, SGB_SCR_FREEZE); 
	ld	hl, #0
	add	hl, sp
	ld	c, l
	ld	b, h
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:46: if ((!ntiles) || (ntiles > 128U)) { 
	ldhl	sp,	#22
	ld	a, (hl)
	or	a, a
	jr	Z, 00105$
	ld	a, #0x80
	sub	a, (hl)
	jr	NC, 00106$
00105$:
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:47: set_bkg_data(0, 0, tiledata); 
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	xor	a, a
	rrca
	push	af
	call	_set_bkg_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:48: SGB_TRANSFER(SGB_CHR_TRN, SGB_CHR_BLOCK0);
	ldhl	sp,	#0
	ld	a, #0x99
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	call	_sgb_transfer
	pop	hl
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:49: if (ntiles) ntiles -= 128U; 
	ldhl	sp,	#22
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
	ld	a, (hl)
	add	a, #0x80
	ld	(hl), a
00104$:
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:50: tiledata += (128 * 32);
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x1000
	add	hl, de
	ld	e, l
	ld	d, h
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:51: set_bkg_data(0, ntiles << 1, tiledata); 
	ldhl	sp,	#22
	ld	a, (hl)
	add	a, a
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:52: SGB_TRANSFER(SGB_CHR_TRN, SGB_CHR_BLOCK1);
	ldhl	sp,	#0
	ld	a, #0x99
	ld	(hl+), a
	ld	(hl), #0x01
	push	bc
	call	_sgb_transfer
	pop	hl
	jr	00107$
00106$:
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:54: set_bkg_data(0, ntiles << 1, tiledata); 
	ldhl	sp,	#22
	ld	a, (hl)
	add	a, a
	ldhl	sp,	#16
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:55: SGB_TRANSFER(SGB_CHR_TRN, SGB_CHR_BLOCK0);
	ldhl	sp,	#0
	ld	a, #0x99
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	call	_sgb_transfer
	pop	hl
00107$:
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:59: set_bkg_data(0, (UINT8)(tilemap_size >> 4), tilemap);
	ldhl	sp,#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, e
	ldhl	sp,	#25
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	h, a
	ld	l, #0x00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:60: set_bkg_data(128, (UINT8)(palette_size >> 4), palette);
	ldhl	sp,#31
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ld	a, e
	ldhl	sp,	#29
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	h, a
	ld	l, #0x80
	push	hl
	call	_set_bkg_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:61: SGB_TRANSFER(SGB_PCT_TRN, 0);
	ldhl	sp,	#0
	ld	a, #0xa1
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	call	_sgb_transfer
	pop	hl
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:64: memset(map_buf, 0, sizeof(map_buf));
	ld	hl, #0
	add	hl, sp
	ld	de, #0x0010
	push	de
	ld	de, #0x0000
	push	de
	push	hl
	call	_memset
	add	sp, #6
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:65: set_bkg_data(0, 1, map_buf);
	push	bc
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:66: fill_bkg_rect(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT, 0);
	xor	a, a
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:68: BGP_REG = __save_BGP;
	ldhl	sp,	#18
	ld	a, (hl)
	ldh	(_BGP_REG + 0), a
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:70: vsync();
	call	_vsync
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:72: SGB_TRANSFER(SGB_MASK_EN, SGB_SCR_UNFREEZE); 
	ldhl	sp,	#0
	ld	a, #0xb9
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	call	_sgb_transfer
	inc	sp
	inc	sp
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:74: if ((__save_lcdc & LCDCF_ON) == 0) DISPLAY_OFF;
	push	hl
	ldhl	sp,	#21
	bit	7, (hl)
	pop	hl
	jr	NZ, 00110$
	call	_display_off
00110$:
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:75: LCDC_REG = __save_lcdc;
	ldhl	sp,	#19
	ld	a, (hl)
	ldh	(_LCDC_REG + 0), a
00119$:
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:78: }
	add	sp, #23
	pop	hl
	add	sp, #8
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:80: void LoadSGBBorder(UINT8 map_bank, struct MapInfo* map) {
;	---------------------------------
; Function LoadSGBBorder
; ---------------------------------
_LoadSGBBorder::
	add	sp, #-13
	ld	c, a
	ldhl	sp,	#11
	ld	(hl), e
	inc	hl
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:81: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:82: SWITCH_ROM(map_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:83: set_sgb_border(map->tiles->data, map->tiles->num_frames << 5, map->data, 1792, map->tiles->pals, map->tiles->num_pals << 5);
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ldhl	sp,	#1
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#3
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	ld	a, (bc)
	ld	e, #0x00
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	ld	(hl+), a
	ld	a, e
	ld	(hl+), a
	inc	bc
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	push	de
	ld	de, #0x0700
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	push	de
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_set_sgb_border
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:84: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/gb/SGB.c:85: }
	add	sp, #13
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
