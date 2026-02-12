;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Camera
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _MoveScroll
	.globl _lookahead_offset
	.globl b_SpriteCameraUpdate
	.globl _SpriteCameraUpdate
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_lookahead_offset::
	.ds 1
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
;Camera.c:21: void SpriteCameraUpdate(Sprite* this) BANKED {
;	---------------------------------
; Function SpriteCameraUpdate
; ---------------------------------
	b_SpriteCameraUpdate	= 0
_SpriteCameraUpdate::
	add	sp, #-10
;Camera.c:22: INT16 cam_pos_x = this->x - (SCREEN_WIDTH >> 1) + (this->coll_w >> 1) + CAM_OFFSET_X;
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	srl	a
	add	a, #0xb0
	ldhl	sp,	#7
	ld	(hl+), a
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	push	hl
;Camera.c:23: UINT16 cam_lim_x = scroll_w - SCREEN_WIDTH;
	ld	hl, #_scroll_w
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x00a0
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
;Camera.c:25: INT16 cam_pos_y = this->y - (SCREEN_HEIGHT >> 1) + (this->coll_h >> 1) + CAM_OFFSET_Y;
	ld	hl, #0x0005
	add	hl, bc
	ld	a, (hl)
	srl	a
	add	a, #0xa0
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	push	af
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	pop	af
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;Camera.c:26: UINT16 cam_lim_y = scroll_h - SCREEN_HEIGHT;
	ld	hl, #_scroll_h
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0090
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
;Camera.c:31: CUSTOM_DATA* data = (CUSTOM_DATA*)this->custom_data;
;Camera.c:32: if (data->dir < 0) {
	ld	hl, #0x2c
	add	hl, bc
	bit	7, (hl)
;Camera.c:33: lookahead_update = -1;
;Camera.c:35: lookahead_update = 1;
	ld	c, #0xff
	jr	NZ, 00103$
	ld	c, #0x01
00103$:
;Camera.c:44: lookahead_offset = CLAMP(lookahead_offset + lookahead_update, -LOOKAHEAD_PX, LOOKAHEAD_PX);
	ld	a, (_lookahead_offset)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ld	a, c
	ld	l, a
	rlca
	sbc	a, a
	ld	h, a
	add	hl, de
	ld	a, l
	sub	a, #0xf0
	ld	a, h
	rla
	ccf
	rra
	sbc	a, #0x7f
	jr	NC, 00116$
	ld	bc, #0xfff0
	jr	00117$
00116$:
	ld	e, h
	ld	d, #0x00
	ld	a, #0x10
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	bit	7, e
	jr	Z, 00169$
	bit	7, d
	jr	NZ, 00170$
	cp	a, a
	jr	00170$
00169$:
	bit	7, d
	jr	Z, 00170$
	scf
00170$:
	jr	NC, 00118$
	ld	bc, #0x0010
	jr	00119$
00118$:
	ld	a, c
	ld	hl, #_lookahead_offset
	add	a, (hl)
	ld	c, a
00119$:
00117$:
	ld	hl, #_lookahead_offset
	ld	(hl), c
;Camera.c:45: cam_pos_x += lookahead_offset;
	ld	a, (hl)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	pop	hl
	push	hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;Camera.c:48: if (cam_pos_x < 0) {
	bit	7, (hl)
	jr	Z, 00107$
;Camera.c:49: cam_pos_x = 0;
	dec	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00108$
00107$:
;Camera.c:50: } else if (cam_pos_x > cam_lim_x) {
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00108$
;Camera.c:51: cam_pos_x = cam_lim_x;
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
00108$:
;Camera.c:53: if (cam_pos_y < 0) {
	ldhl	sp,	#5
	bit	7, (hl)
	jr	Z, 00112$
;Camera.c:54: cam_pos_y = 0;
	dec	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	jr	00113$
00112$:
;Camera.c:55: } else if (cam_pos_y > cam_lim_y) {
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00113$
;Camera.c:56: cam_pos_y = cam_lim_y;
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
00113$:
;Camera.c:58: MoveScroll(cam_pos_x, cam_pos_y);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_MoveScroll
;Camera.c:59: }
	add	sp, #10
	ret
	.area _CODE
	.area _INITIALIZER
__xinit____CRASH_HANDLER_INIT:
	.dw ___HandleCrash
	.area _CABS (ABS)
