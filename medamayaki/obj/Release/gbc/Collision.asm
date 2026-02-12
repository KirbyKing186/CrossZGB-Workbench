;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Collision
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _RevertSRAM
	.globl _tile_hit_y
	.globl _tile_hit_x
	.globl _tile_col_test_range_y
	.globl _tile_col_test_range_x
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
__save:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_tile_hit_x::
	.ds 2
_tile_hit_y::
	.ds 2
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
;Collision.c:11: UINT8 tile_col_test_range_y(UINT8 tile_mask, UINT16 tx, UINT16 ty_start, UINT16 ty_end) NONBANKED {
;	---------------------------------
; Function tile_col_test_range_y
; ---------------------------------
_tile_col_test_range_y::
	add	sp, #-5
	ldhl	sp,	#4
	ld	(hl), a
;Collision.c:12: tile_hit_x = tx;
	ld	hl, #_tile_hit_x
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;Collision.c:13: tile_hit_y = ty_start;
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(#_tile_hit_y),a
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_tile_hit_y + 1),a
;Collision.c:15: if (tile_hit_x >= scroll_tiles_w || tile_hit_y >= scroll_tiles_h) {
	push	de
	ld	de, #_tile_hit_x
	ld	hl, #_scroll_tiles_w
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00101$
	push	de
	ld	de, #_tile_hit_y
	ld	hl, #_scroll_tiles_h
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	C, 00102$
00101$:
;Collision.c:16: return (COLLISION_ALL & tile_mask) ? COLLISION_ALL : COLLISION_NONE;
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x0f
	jr	Z, 00132$
	ld	a, #0x0f
	jp	00130$
00132$:
	xor	a, a
	jp	00130$
00102$:
;Collision.c:19: _save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	(#__save),a
;Collision.c:20: UINT8 inc = (ty_start < ty_end);
	push	de
	ldhl	sp,	#9
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	ld	a, #0x00
	rla
	ldhl	sp,	#2
	ld	(hl), a
;Collision.c:21: SWITCH_ROM(scroll_bank);
	ld	a, (_scroll_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;Collision.c:22: UINT8* tile_ptr = scroll_map + (((UINT16)ty_start * scroll_tiles_w) + tx);
	push	de
	ld	a, (_scroll_tiles_w)
	ld	c, a
	ld	hl, #_scroll_tiles_w + 1
	ld	b, (hl)
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ld	l, c
	ld	h, b
	pop	de
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, c
	ld	hl, #_scroll_map
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
;Collision.c:23: if (dynamic_map_active) ENABLE_RAM;
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00145$
	ld	hl, #_rRAMG
	ld	(hl), #0x0a
;Collision.c:25: while (TRUE) {
00145$:
00126$:
;Collision.c:26: if (dynamic_map_active) {
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00110$
;Collision.c:27: if ((tile_ptr - scroll_map) >= BUFFER_SIZE) {
	ld	hl, #_scroll_map
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	sub	a, #0x00
	ld	a, (hl)
	sbc	a, #0x20
	ld	d, (hl)
	ld	a, #0x20
	bit	7,a
	jr	Z, 00235$
	bit	7, d
	jr	NZ, 00236$
	cp	a, a
	jr	00236$
00235$:
	bit	7, d
	jr	Z, 00236$
	scf
00236$:
	jr	C, 00107$
;Collision.c:28: SWITCH_RAM(RAM_DATA_B);
	ld	hl, #_rRAMB
	ld	(hl), #0x02
;Collision.c:29: tile = scroll_collisions[*(tile_ptr - BUFFER_SIZE)];
	ld	l, c
	ld	a,b
	add	a,#0xe0
	ld	h, a
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_scroll_collisions
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	jr	00111$
00107$:
;Collision.c:31: SWITCH_RAM(RAM_DATA_A);
	ld	hl, #_rRAMB
	ld	(hl), #0x01
;Collision.c:32: tile = scroll_collisions[*tile_ptr];
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_scroll_collisions
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	jr	00111$
00110$:
;Collision.c:35: tile = scroll_collisions[*tile_ptr];
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_scroll_collisions
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
00111$:
;Collision.c:38: SWITCH_ROM(_save);
	ld	a, (__save)
	ld	e, a
;Collision.c:37: if (tile & tile_mask) {
	ldhl	sp,	#3
	ld	a, (hl+)
	and	a, (hl)
	jr	Z, 00115$
;Collision.c:38: SWITCH_ROM(_save);
	ld	a, e
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), e
;Collision.c:39: if (dynamic_map_active) RevertSRAM();
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00113$
	call	_RevertSRAM
00113$:
;Collision.c:40: return tile;
	ldhl	sp,	#3
	ld	a, (hl)
	jp	00130$
00115$:
;Collision.c:42: if (tile_hit_y == ty_end) {
	ld	a, (#_tile_hit_y)
	ldhl	sp,	#9
	sub	a, (hl)
	jr	NZ, 00237$
	ld	a, (#_tile_hit_y + 1)
	ldhl	sp,	#10
	sub	a, (hl)
	jr	Z, 00127$
00237$:
;Collision.c:45: if (inc) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00119$
;Collision.c:46: tile_hit_y++;
	ld	hl, #_tile_hit_y
	inc	(hl)
	jr	NZ, 00238$
	inc	hl
	inc	(hl)
00238$:
;Collision.c:47: tile_ptr += scroll_tiles_w;
	ld	a, c
	ld	hl, #_scroll_tiles_w
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
	jr	00120$
00119$:
;Collision.c:49: tile_hit_y--;
	ld	hl, #_tile_hit_y
	ld	a, (hl)
	add	a, #0xff
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0xff
	ld	(hl), a
;Collision.c:50: tile_ptr -= scroll_tiles_w;
	ld	a, (_scroll_tiles_w)
	ld	d, a
	ld	hl, #_scroll_tiles_w + 1
	ld	l, (hl)
	ld	a, c
	sub	a, d
	ld	c, a
	ld	a, b
	sbc	a, l
	ld	b, a
00120$:
;Collision.c:52: if (tile_hit_y >= scroll_tiles_h) {
	push	de
	ld	de, #_tile_hit_y
	ld	hl, #_scroll_tiles_h
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jp	C, 00126$
;Collision.c:53: SWITCH_ROM(_save);
	ld	a, e
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), e
;Collision.c:54: if (dynamic_map_active) RevertSRAM();
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00122$
	call	_RevertSRAM
00122$:
;Collision.c:55: return (COLLISION_ALL & tile_mask) ? COLLISION_ALL : COLLISION_NONE;
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x0f
	jr	Z, 00134$
	ld	a, #0x0f
	jr	00130$
00134$:
	xor	a, a
	jr	00130$
00127$:
;Collision.c:58: SWITCH_ROM(_save);
	ld	a, e
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), e
;Collision.c:59: if (dynamic_map_active) RevertSRAM();
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00129$
	call	_RevertSRAM
00129$:
;Collision.c:60: return COLLISION_NONE;
	xor	a, a
00130$:
;Collision.c:61: }
	add	sp, #5
	pop	hl
	add	sp, #4
	jp	(hl)
;Collision.c:63: UINT8 tile_col_test_range_x(UINT8 tile_mask, UINT16 ty, UINT16 tx_start, UINT16 tx_end) NONBANKED {
;	---------------------------------
; Function tile_col_test_range_x
; ---------------------------------
_tile_col_test_range_x::
	add	sp, #-5
	ldhl	sp,	#4
	ld	(hl), a
;Collision.c:64: tile_hit_x = tx_start;
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(#_tile_hit_x),a
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_tile_hit_x + 1),a
;Collision.c:65: tile_hit_y = ty;
	ld	hl, #_tile_hit_y
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;Collision.c:67: if (tile_hit_x >= scroll_tiles_w || tile_hit_y >= scroll_tiles_h) {
	push	de
	ld	de, #_tile_hit_x
	ld	hl, #_scroll_tiles_w
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	NC, 00101$
	push	de
	ld	de, #_tile_hit_y
	ld	hl, #_scroll_tiles_h
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jr	C, 00102$
00101$:
;Collision.c:68: return (COLLISION_ALL & tile_mask) ? COLLISION_ALL : COLLISION_NONE;
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x0f
	jr	Z, 00132$
	ld	a, #0x0f
	jp	00130$
00132$:
	xor	a, a
	jp	00130$
00102$:
;Collision.c:71: _save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	(#__save),a
;Collision.c:72: UINT8 inc = (tx_start < tx_end);
	push	de
	ldhl	sp,	#9
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	ld	a, #0x00
	rla
	ldhl	sp,	#2
	ld	(hl), a
;Collision.c:73: SWITCH_ROM(scroll_bank);
	ld	a, (_scroll_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;Collision.c:74: UINT8* tile_ptr = scroll_map + (((UINT16)ty * scroll_tiles_w) + tx_start);
	ld	a, (_scroll_tiles_w)
	ld	c, a
	ld	hl, #_scroll_tiles_w + 1
	ld	b, (hl)
	call	__mulint
	ldhl	sp,	#7
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, c
	ld	hl, #_scroll_map
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
;Collision.c:76: if (dynamic_map_active) ENABLE_RAM;
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00145$
	ld	hl, #_rRAMG
	ld	(hl), #0x0a
;Collision.c:77: while (TRUE) {
00145$:
00126$:
;Collision.c:78: if (dynamic_map_active) {
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00110$
;Collision.c:79: if ((tile_ptr - scroll_map) >= BUFFER_SIZE) {
	ld	hl, #_scroll_map
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	sub	a, #0x00
	ld	a, (hl)
	sbc	a, #0x20
	ld	d, (hl)
	ld	a, #0x20
	bit	7,a
	jr	Z, 00235$
	bit	7, d
	jr	NZ, 00236$
	cp	a, a
	jr	00236$
00235$:
	bit	7, d
	jr	Z, 00236$
	scf
00236$:
	jr	C, 00107$
;Collision.c:80: SWITCH_RAM(RAM_DATA_B);
	ld	hl, #_rRAMB
	ld	(hl), #0x02
;Collision.c:81: tile = scroll_collisions[*(tile_ptr - BUFFER_SIZE)];
	ld	l, c
	ld	a,b
	add	a,#0xe0
	ld	h, a
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_scroll_collisions
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	jr	00111$
00107$:
;Collision.c:83: SWITCH_RAM(RAM_DATA_A);
	ld	hl, #_rRAMB
	ld	(hl), #0x01
;Collision.c:84: tile = scroll_collisions[*tile_ptr];
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_scroll_collisions
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	jr	00111$
00110$:
;Collision.c:87: tile = scroll_collisions[*tile_ptr];
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_scroll_collisions
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
00111$:
;Collision.c:90: SWITCH_ROM(_save);
	ld	a, (__save)
	ld	e, a
;Collision.c:89: if (tile & tile_mask) {
	ldhl	sp,	#3
	ld	a, (hl+)
	and	a, (hl)
	jr	Z, 00115$
;Collision.c:90: SWITCH_ROM(_save);
	ld	a, e
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), e
;Collision.c:91: if (dynamic_map_active) RevertSRAM();
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00113$
	call	_RevertSRAM
00113$:
;Collision.c:92: return tile;
	ldhl	sp,	#3
	ld	a, (hl)
	jr	00130$
00115$:
;Collision.c:94: if (tile_hit_x == tx_end) {
	ld	a, (#_tile_hit_x)
	ldhl	sp,	#9
	sub	a, (hl)
	jr	NZ, 00237$
	ld	a, (#_tile_hit_x + 1)
	ldhl	sp,	#10
	sub	a, (hl)
	jr	Z, 00127$
00237$:
;Collision.c:97: if (inc) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00119$
;Collision.c:98: tile_hit_x++;
	ld	hl, #_tile_hit_x
	inc	(hl)
	jr	NZ, 00238$
	inc	hl
	inc	(hl)
00238$:
;Collision.c:99: tile_ptr++;
	inc	bc
	jr	00120$
00119$:
;Collision.c:101: tile_hit_x--;
	ld	hl, #_tile_hit_x
	ld	a, (hl)
	add	a, #0xff
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0xff
	ld	(hl), a
;Collision.c:102: tile_ptr--;
	dec	bc
00120$:
;Collision.c:104: if (tile_hit_x >= scroll_tiles_w) {
	push	de
	ld	de, #_tile_hit_x
	ld	hl, #_scroll_tiles_w
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	pop	de
	jp	C, 00126$
;Collision.c:105: SWITCH_ROM(_save);
	ld	a, e
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), e
;Collision.c:106: if (dynamic_map_active) RevertSRAM();
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00122$
	call	_RevertSRAM
00122$:
;Collision.c:107: return (COLLISION_ALL & tile_mask) ? COLLISION_ALL : COLLISION_NONE;
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x0f
	jr	Z, 00134$
	ld	a, #0x0f
	jr	00130$
00134$:
	xor	a, a
	jr	00130$
00127$:
;Collision.c:110: SWITCH_ROM(_save);
	ld	a, e
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), e
;Collision.c:111: if (dynamic_map_active) RevertSRAM();
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00129$
	call	_RevertSRAM
00129$:
;Collision.c:112: return COLLISION_NONE;
	xor	a, a
00130$:
;Collision.c:113: }
	add	sp, #5
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _INITIALIZER
__xinit__tile_hit_x:
	.dw #0x0000
__xinit__tile_hit_y:
	.dw #0x0000
	.area _CABS (ABS)
