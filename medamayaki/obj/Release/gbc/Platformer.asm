;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Platformer
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _tile_col_test_range_x
	.globl _tile_col_test_range_y
	.globl b_PlatformerUpdate
	.globl _PlatformerUpdate
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
___CRASH_HANDLER_INIT:
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
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;Platformer.c:9: void PlatformerUpdate(Sprite* this) BANKED {
;	---------------------------------
; Function PlatformerUpdate
; ---------------------------------
	b_PlatformerUpdate	= 0
_PlatformerUpdate::
	add	sp, #-42
;Platformer.c:11: CUSTOM_DATA* data = (CUSTOM_DATA*)this->custom_data;
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0024
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#42
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#41
	ld	(hl), a
;Platformer.c:13: UINT16 coll_offset_w = PX_TO_SUBPX(this->coll_w) - 1;
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	de, #0x0001
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#39
	ld	(hl-), a
	ld	(hl), e
;Platformer.c:14: UINT16 coll_offset_h = PX_TO_SUBPX(this->coll_h) - 1;
	ldhl	sp,#48
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	de, #0x0001
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
;Platformer.c:15: UINT16 sp_half_width = DIV_2(coll_offset_w);
	ldhl	sp,	#38
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#39
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
;Platformer.c:16: UINT8 prev_on_slope = data->plat.on_slope;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
;Platformer.c:17: data->plat.on_slope = FALSE;
	ld	(hl-), a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
;Platformer.c:20: if (data->grounded) {
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
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
	ld	c, a
;Platformer.c:21: data->plat.drop_timer = 0;
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
;Platformer.c:20: if (data->grounded) {
	ld	a, c
	or	a, a
	jr	Z, 00103$
;Platformer.c:21: data->plat.drop_timer = 0;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
	jr	00108$
;Platformer.c:23: COUNTER_DECREMENT(data->plat.drop_timer);
00103$:
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00108$
	dec	hl
	dec	a
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00108$:
;Platformer.c:25: if (DROP_THROUGH_CONDITION) data->plat.drop_timer = DROP_FRAMES_MAX;
	ld	hl, #(_joypads + 1)
	ld	c, (hl)
	ld	a, (#(_old_joypads + 1) + 0)
	xor	a, c
	and	a, c
	bit	3, a
	jr	Z, 00110$
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x05
00110$:
;Platformer.c:29: INT8 plat_delta_x = CLAMP(VEL_TO_SUBPX(data->vel.x), -MAX_DELTA, MAX_DELTA);
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	c, (hl)
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	a, c
	sub	a, #0x81
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00163$
	ld	bc, #0xff81
	jr	00164$
00163$:
	ld	e, b
	ld	d, #0x00
	ld	a, #0x7f
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00400$
	bit	7, d
	jr	NZ, 00401$
	cp	a, a
	jr	00401$
00400$:
	bit	7, d
	jr	Z, 00401$
	scf
00401$:
	jr	NC, 00165$
	ld	bc, #0x007f
	jr	00166$
00165$:
	ldhl	sp,	#35
	ld	c, (hl)
00166$:
00164$:
	ldhl	sp,	#33
	ld	(hl), c
;Platformer.c:32: UINT16 tile_y_start = SUBPX_TO_TILE(data->pos.y + coll_offset_h);
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
;Platformer.c:34: UINT16 new_x = ((data->pos.x + plat_delta_x) > 0) ? data->pos.x + plat_delta_x : 0;
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
;Platformer.c:66: if ((tile_hit_y == data->plat.slope_y) &&
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
;Platformer.c:34: UINT16 new_x = ((data->pos.x + plat_delta_x) > 0) ? data->pos.x + plat_delta_x : 0;
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;Platformer.c:30: if (plat_delta_x) {
	ldhl	sp,	#33
	ld	a, (hl)
	or	a, a
	jp	Z, 00125$
;Platformer.c:32: UINT16 tile_y_start = SUBPX_TO_TILE(data->pos.y + coll_offset_h);
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	pop	hl
	push	hl
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#26
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;Platformer.c:33: UINT16 tile_y_end = SUBPX_TO_TILE(data->pos.y);
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
	srl	b
	rr	c
	srl	b
	rr	c
;Platformer.c:34: UINT16 new_x = ((data->pos.x + plat_delta_x) > 0) ? data->pos.x + plat_delta_x : 0;
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#34
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, d
	or	a, e
	jr	NZ, 00168$
	ld	de, #0x0000
00168$:
	ldhl	sp,	#28
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;Platformer.c:38: INT16 bounds_edge = 0;
	xor	a, a
	ldhl	sp,	#34
	ld	(hl+), a
;Platformer.c:40: if (plat_delta_x > 0)
	ld	(hl-), a
	dec	hl
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00402$
	bit	7, d
	jr	NZ, 00403$
	cp	a, a
	jr	00403$
00402$:
	bit	7, d
	jr	Z, 00403$
	scf
00403$:
	jr	NC, 00112$
;Platformer.c:43: moving_right = TRUE;
	ldhl	sp,	#30
;Platformer.c:44: hit_flag = COLLISION_LEFT;
	ld	a, #0x01
	ld	(hl+), a
	ld	(hl), #0x04
;Platformer.c:45: bounds_edge = EXCLUSIVE_OFFSET(coll_offset_w);
	ldhl	sp,#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#36
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#35
	ld	(hl), a
	jr	00113$
00112$:
;Platformer.c:50: moving_right = FALSE;
	ldhl	sp,	#30
;Platformer.c:51: hit_flag = COLLISION_RIGHT;
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x08
00113$:
;Platformer.c:54: UINT16 tile_x = SUBPX_TO_TILE(new_x + bounds_edge);
	ldhl	sp,	#34
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#28
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#34
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;Platformer.c:56: UINT8 tile = tile_col_test_range_y(hit_flag, tile_x, tile_y_start, tile_y_end);
	push	bc
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#35
	ld	a, (hl)
	call	_tile_col_test_range_y
;Platformer.c:58: if (tile) {
	or	a, a
	jp	Z, 00123$
;Platformer.c:66: if ((tile_hit_y == data->plat.slope_y) &&
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#26
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (#_tile_hit_y)
	ldhl	sp,	#26
	sub	a, (hl)
	jr	NZ, 00115$
	ld	a, (#_tile_hit_y + 1)
	ldhl	sp,	#27
	sub	a, (hl)
	jr	NZ, 00115$
;Platformer.c:67: (IS_ON_SLOPE(prev_on_slope) &&
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x60
	jr	Z, 00115$
;Platformer.c:68: (IS_SLOPE_LEFT(prev_on_slope) != moving_right)))
	ldhl	sp,	#4
	ld	a, (hl)
	and	a, #0x10
	ldhl	sp,	#30
	ld	c, (hl)
	sub	a, c
	jr	NZ, 00123$
;Platformer.c:70: goto finally_update_x;
00115$:
;Platformer.c:72: if (moving_right) {
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	Z, 00119$
;Platformer.c:73: new_x = TILE_TO_SUBPX(tile_x) - bounds_edge;
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	c, (hl)
	add	a, a
	rl	c
	add	a, a
	rl	c
	add	a, a
	rl	c
	add	a, a
	rl	c
	add	a, a
	rl	c
	add	a, a
	rl	c
	add	a, a
	rl	c
	ld	e, a
	ld	d, c
	ldhl	sp,	#32
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#29
	ld	(hl-), a
	ld	(hl), e
	jr	00120$
00119$:
;Platformer.c:75: new_x = TILE_TO_SUBPX(tile_x + 1) - bounds_edge;
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#32
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#31
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#34
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ld	a, #0x07
00410$:
	ldhl	sp,	#34
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00410$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#32
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#29
	ld	(hl-), a
	ld	(hl), e
00120$:
;Platformer.c:78: data->vel.x = 0;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;Platformer.c:81: finally_update_x:
00123$:
;Platformer.c:82: data->pos.x = new_x;
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#28
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
00125$:
;Platformer.c:87: INT8 plat_delta_y = CLAMP(VEL_TO_SUBPX(data->vel.y), -MAX_DELTA, MAX_DELTA);
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#21
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#20
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ld	c, a
	ld	l, c
	ld	a, l
	rlca
	sbc	a, a
	ld	h, a
	ld	a, l
	sub	a, #0x81
	ld	a, h
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00169$
	ld	bc, #0xff81
	jr	00170$
00169$:
	ld	e, h
	ld	d, #0x00
	ld	a, #0x7f
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00411$
	bit	7, d
	jr	NZ, 00412$
	cp	a, a
	jr	00412$
00411$:
	bit	7, d
	jr	Z, 00412$
	scf
00412$:
	jr	NC, 00171$
	ld	bc, #0x007f
00171$:
00170$:
	ldhl	sp,	#21
	ld	(hl), c
;Platformer.c:88: if (plat_delta_y) {
	ld	a, (hl)
	or	a, a
	jp	Z, 00160$
;Platformer.c:90: UINT16 new_y = ((data->pos.y + plat_delta_y) > 0) ? data->pos.y + plat_delta_y : 0;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#21
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	l, e
	ld	h, a
	add	hl, bc
	ld	a, h
	or	a, l
	jr	Z, 00173$
	ld	e, l
	ld	d, h
	jr	00174$
00173$:
	ld	de, #0x0000
00174$:
	ldhl	sp,	#22
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;Platformer.c:91: UINT8 prev_grounded = data->grounded;
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#24
	ld	(hl), a
;Platformer.c:94: data->grounded = prev_on_slope;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;Platformer.c:96: UINT16 tile_x_start = SUBPX_TO_TILE(data->pos.x);
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#40
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;Platformer.c:97: UINT16 tile_x_end = SUBPX_TO_TILE(data->pos.x + coll_offset_w);
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#38
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#27
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;Platformer.c:99: if (plat_delta_y >= 0) {
	ldhl	sp,	#21
	bit	7, (hl)
	jp	NZ, 00156$
;Platformer.c:102: UINT16 y_bottom = new_y + coll_offset_h;
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#31
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#30
;Platformer.c:103: UINT16 new_tile_y = SUBPX_TO_TILE(y_bottom);
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;Platformer.c:105: UINT16 tile_y_start = SUBPX_TO_TILE(data->pos.y + coll_offset_h) - 1;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
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
	srl	b
	rr	c
	srl	b
	rr	c
	ld	de, #0x0001
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#39
	ld	(hl-), a
	ld	(hl), e
;Platformer.c:106: UINT16 tile_y_end = new_tile_y;
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;Platformer.c:112: if (prev_grounded && (tile_y_end == (tile_y_start + 1))) {
	ldhl	sp,	#24
	ld	a, (hl)
	or	a, a
	jr	Z, 00127$
	ldhl	sp,	#38
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ldhl	sp,	#31
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00127$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	NZ, 00127$
;Platformer.c:113: tile_y_end += 1;
	ldhl	sp,	#31
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
;Platformer.c:114: tile_y_offset = TRUE;
00127$:
;Platformer.c:117: UINT16 x_mid_coord = data->pos.x + sp_half_width + PX_TO_SUBPX(1);
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#36
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#42
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#41
;Platformer.c:118: UINT16 tile_x = SUBPX_TO_TILE(x_mid_coord);
	ld	(hl-), a
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
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;Platformer.c:120: tile = tile_col_test_range_y(COLLISION_SLOPE_ANY, tile_x, tile_y_start, tile_y_end);
	push	bc
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	a, #0x60
	call	_tile_col_test_range_y
;Platformer.c:121: if (tile) {
	ldhl	sp,#33
;Platformer.c:122: const UINT8 slope_type = (tile & COLLISION_SLOPE);
	ld	(hl),a
	or	a,a
	jp	Z,00143$
	inc	hl
	and	a, #0xf0
	ld	(hl), a
;Platformer.c:123: UINT8 x_offset = SUBPX_TILE_REMAINDER(x_mid_coord);
	ldhl	sp,	#40
	ld	a, (hl)
	and	a, #0x7f
	ld	(hl), a
;Platformer.c:124: INT16 offset = 0;
	xor	a, a
	ldhl	sp,	#35
	ld	(hl+), a
	ld	(hl), a
;Platformer.c:128: offset = (PX_TO_SUBPX(8) - x_offset) - coll_offset_h;
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	(hl), a
;Platformer.c:126: switch (slope_type) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x20
	jr	Z, 00129$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x30
	jp	Z, 00132$
;Platformer.c:131: offset = (PX_TO_SUBPX(8) - DIV_2(x_offset)) - coll_offset_h;
	ldhl	sp,	#40
	ld	a, (hl)
	srl	a
	ldhl	sp,	#37
	ld	(hl), a
;Platformer.c:126: switch (slope_type) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x40
	jr	Z, 00130$
;Platformer.c:140: offset = DIV_2(x_offset) - coll_offset_h + PX_TO_SUBPX(4);
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#41
	ld	(hl-), a
	ld	(hl), e
;Platformer.c:126: switch (slope_type) {
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x50
	jr	Z, 00133$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x60
	jr	Z, 00131$
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, #0x70
	jr	Z, 00134$
	jr	00135$
;Platformer.c:127: case COLLISION_SLOPE_45_RIGHT:
00129$:
;Platformer.c:128: offset = (PX_TO_SUBPX(8) - x_offset) - coll_offset_h;
	ld	a, #0x80
	ldhl	sp,	#41
	sub	a, (hl)
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#36
	ld	(hl-), a
	ld	(hl), e
;Platformer.c:129: break;
	jr	00135$
;Platformer.c:130: case COLLISION_SLOPE_225_RIGHT_BOT:
00130$:
;Platformer.c:131: offset = (PX_TO_SUBPX(8) - DIV_2(x_offset)) - coll_offset_h;
	ld	a, #0x80
	ldhl	sp,	#37
	sub	a, (hl)
	ld	c, #0x00
	ld	e, a
	ld	d, c
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#36
	ld	(hl-), a
	ld	(hl), e
;Platformer.c:132: break;
	jr	00135$
;Platformer.c:133: case COLLISION_SLOPE_225_RIGHT_TOP:
00131$:
;Platformer.c:134: offset = (PX_TO_SUBPX(4) - DIV_2(x_offset)) - coll_offset_h;
	ld	a, #0x40
	ldhl	sp,	#37
	sub	a, (hl)
	ld	c, #0x00
	ld	e, a
	ld	d, c
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#36
	ld	(hl-), a
	ld	(hl), e
;Platformer.c:135: break;
	jr	00135$
;Platformer.c:136: case COLLISION_SLOPE_45_LEFT:
00132$:
;Platformer.c:137: offset = x_offset - coll_offset_h;
	ldhl	sp,	#41
	ld	e, (hl)
	ld	d, #0x00
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#36
	ld	(hl-), a
	ld	(hl), e
;Platformer.c:138: break;
	jr	00135$
;Platformer.c:139: case COLLISION_SLOPE_225_LEFT_BOT:
00133$:
;Platformer.c:140: offset = DIV_2(x_offset) - coll_offset_h + PX_TO_SUBPX(4);
	ldhl	sp,#40
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0040
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#37
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#36
	ld	(hl), a
;Platformer.c:141: break;
	jr	00135$
;Platformer.c:142: case COLLISION_SLOPE_225_LEFT_TOP:
00134$:
;Platformer.c:143: offset = DIV_2(x_offset) - coll_offset_h;
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#35
	ld	(hl), a
	ldhl	sp,	#41
	ld	a, (hl)
	ldhl	sp,	#36
	ld	(hl), a
;Platformer.c:145: }				
00135$:
;Platformer.c:147: UINT16 slope_y_coord = TILE_TO_SUBPX(tile_hit_y) + offset - 1;
	ld	a, (_tile_hit_y)
	ld	hl, #_tile_hit_y + 1
	ld	b, (hl)
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	ldhl	sp,	#35
	ld	c, (hl)
	inc	hl
	ld	e, (hl)
	add	a, c
	ld	c, a
	ld	a, b
	adc	a, e
	ld	b, a
	ld	de, #0x0001
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#41
	ld	(hl-), a
	ld	(hl), e
;Platformer.c:151: if (prev_grounded || slope_y_coord <= new_y) {
	ldhl	sp,	#24
	ld	a, (hl)
	or	a, a
	jr	NZ, 00139$
	ldhl	sp,	#22
	ld	e, l
	ld	d, h
	ldhl	sp,	#40
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00143$
00139$:
;Platformer.c:153: UINT16 slope_top_tile_y = SUBPX_TO_TILE(slope_y_coord);
	ldhl	sp,#40
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
	srl	b
	rr	c
	srl	b
	rr	c
;Platformer.c:155: data->plat.slope_y = tile_hit_y;
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (_tile_hit_y)
	ld	(de), a
	inc	de
	ld	a, (_tile_hit_y + 1)
	ld	(de), a
;Platformer.c:156: data->plat.on_slope = tile;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#33
	ld	a, (hl)
	ld	(de), a
;Platformer.c:157: data->grounded = TRUE;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;Platformer.c:159: UINT8 top_tile = tile_col_test_range_x(COLLISION_BOTTOM, slope_top_tile_y, tile_x_start, tile_x_end);
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	e, c
	ld	d, b
	ld	a, #0x02
	call	_tile_col_test_range_x
;Platformer.c:160: if (top_tile) {
	or	a, a
	jr	Z, 00137$
;Platformer.c:161: data->vel.y = 0;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;Platformer.c:162: data->vel.x = 0;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;Platformer.c:163: data->pos.x -= plat_delta_x;
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	inc	de
	ld	a, (de)
	ld	c, a
	ld	e, b
	ld	d, c
	ldhl	sp,	#17
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	c, a
	ld	b, e
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
	jp	00160$
00137$:
;Platformer.c:165: data->pos.y = slope_y_coord;
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;Platformer.c:166: data->vel.y = 0;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;Platformer.c:168: data->plat.drop_timer = 0;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;Platformer.c:171: goto finally_finish;	// Renamed from "goto finally_check_actor_col;"
	jp	00160$
00143$:
;Platformer.c:178: if (!prev_on_slope && (SUBPX_TILE_REMAINDER(y_bottom) > SUBPX_TILE_REMAINDER(plat_delta_y))) {
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	NZ, 00145$
	ldhl	sp,	#29
	ld	c, (hl)
	res	7, c
	ldhl	sp,	#21
	ld	b, (hl)
	res	7, b
	ld	a, b
	sub	a, c
	jr	C, 00152$
;Platformer.c:179: goto finally_update_y;
00145$:
;Platformer.c:182: tile = tile_col_test_range_x(COLLISION_TOP, new_tile_y, tile_x_start, tile_x_end);
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, #0x01
	call	_tile_col_test_range_x
;Platformer.c:183: if (tile) {
	ld	c, a
	or	a, a
	jr	Z, 00152$
;Platformer.c:186: if (data->plat.drop_timer && (tile & PLATFORM_BIT))
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00148$
	bit	7, c
	jr	NZ, 00152$
;Platformer.c:188: goto finally_update_y;
00148$:
;Platformer.c:191: new_y = TILE_TO_SUBPX(tile_hit_y) - coll_offset_h - 1;
	ld	a, (#_tile_hit_y)
	ldhl	sp,	#38
	ld	(hl), a
	ld	a, (#_tile_hit_y + 1)
	ldhl	sp,	#39
	ld	(hl), a
	ld	a, #0x07
00424$:
	ldhl	sp,	#38
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00424$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#41
	ld	(hl-), a
	ld	a, e
	ld	(hl+), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#23
	ld	(hl-), a
	ld	(hl), e
;Platformer.c:193: data->vel.y = 0;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;Platformer.c:195: data->plat.drop_timer = 0;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;Platformer.c:197: data->grounded = TRUE;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
;Platformer.c:199: finally_update_y:
00152$:
;Platformer.c:200: data->pos.y = new_y;
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00160$
00156$:
;Platformer.c:205: UINT16 tile_y = SUBPX_TO_TILE(new_y);
	ldhl	sp,#22
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
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;Platformer.c:206: UINT8 tile = tile_col_test_range_x(COLLISION_BOTTOM, tile_y, tile_x_start, tile_x_end);
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	a, #0x02
	call	_tile_col_test_range_x
;Platformer.c:208: if (tile) {
	or	a, a
	jr	Z, 00154$
;Platformer.c:210: new_y = TILE_TO_SUBPX(tile_hit_y + 1) + 1;
	ld	a, (_tile_hit_y)
	ld	c, a
	ld	hl, #_tile_hit_y + 1
	ld	b, (hl)
	inc	bc
	xor	a, a
	rr	b
	ld	b, c
	rr	b
	rra
	ld	c, a
	inc	bc
	ldhl	sp,	#22
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;Platformer.c:211: data->vel.y = 0;
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00154$:
;Platformer.c:213: data->pos.y = new_y;
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;Platformer.c:217: finally_finish:
00160$:
;Platformer.c:219: this->x = SUBPX_TO_PX(data->pos.x);
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	xor	a, a
	add	hl, hl
	rla
	add	hl, hl
	rla
	add	hl, hl
	rla
	add	hl, hl
	rla
	ld	e, a
	ld	a, h
	ld	(bc), a
	inc	bc
	ld	a, e
	ld	(bc), a
;Platformer.c:220: this->y = SUBPX_TO_PX(data->pos.y);
	ldhl	sp,	#48
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	xor	a, a
	add	hl, hl
	rla
	add	hl, hl
	rla
	add	hl, hl
	rla
	add	hl, hl
	rla
	ld	e, a
	ld	a, h
	ld	(bc), a
	inc	bc
	ld	a, e
	ld	(bc), a
;Platformer.c:222: }
	add	sp, #42
	ret
	.area _CODE
	.area _INITIALIZER
__xinit____CRASH_HANDLER_INIT:
	.dw ___HandleCrash
	.area _CABS (ABS)
