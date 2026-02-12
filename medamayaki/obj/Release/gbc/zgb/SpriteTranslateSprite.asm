;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module SpriteTranslateSprite
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _TranslateSprite
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_tile_coll:
	.ds 2
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
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:8: UINT8 TranslateSprite(Sprite* sprite, INT8 x, INT8 y) {
;	---------------------------------
; Function TranslateSprite
; ---------------------------------
_TranslateSprite::
	add	sp, #-14
	ldhl	sp,	#12
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:9: UINT8 ret = 0;
	ldhl	sp,	#4
	ld	(hl), #0x00
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:17: pivot_x = sprite->x + (UINT8)(sprite->coll_w - 1u);
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,#12
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
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:15: if (x) {
	ld	(hl+), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00128$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:16: if (x > 0) {
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00344$
	bit	7, d
	jr	NZ, 00345$
	cp	a, a
	jr	00345$
00344$:
	bit	7, d
	jr	Z, 00345$
	scf
00345$:
	ld	a, #0x00
	rla
	ldhl	sp,	#2
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:17: pivot_x = sprite->x + (UINT8)(sprite->coll_w - 1u);
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:16: if (x > 0) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:17: pivot_x = sprite->x + (UINT8)(sprite->coll_w - 1u);
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:19: pivot_x = sprite->x;
00102$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:23: tmp = PX_TO_TILE(pivot_x);
	ld	e, c
	ld	d, b
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:24: pivot_x += x;
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	rlca
	sbc	a, a
	ld	d, a
	pop	af
	add	a, c
	ld	c, a
	ld	a, d
	adc	a, b
	ld	b, a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:25: start_tile_x = PX_TO_TILE(pivot_x);
	ld	l, c
	ld	d, b
	sra	d
	rr	l
	sra	d
	rr	l
	sra	d
	rr	l
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:26: if(tmp == start_tile_x) {
	ld	a, e
	sub	a, (hl)
	jp	Z, 00128$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:31: if((UINT16)pivot_x >= scroll_w) { //This checks pivot_x < 0 || pivot_x >= scroll_W
	ld	hl, #_scroll_w
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jp	NC, 00128$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:36: if(sprite->y >= scroll_h) { //This checks sprite->y < 0 || sprite->y >= scroll_h
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:40: start_tile_y = scroll_tiles_h - 1;
	ld	a, (_scroll_tiles_h)
	dec	a
	ldhl	sp,	#9
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:36: if(sprite->y >= scroll_h) { //This checks sprite->y < 0 || sprite->y >= scroll_h
	ld	hl, #_scroll_h
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00112$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:37: if((INT16)sprite->y < 0) 
	ld	h, b
	bit	7, h
	jr	Z, 00109$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:38: start_tile_y = 0;
	ldhl	sp,	#10
	ld	(hl), #0x00
	jr	00113$
00109$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:40: start_tile_y = scroll_tiles_h - 1;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	(hl), a
	jr	00113$
00112$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:42: start_tile_y = PX_TO_TILE(sprite->y);
	ld	e, c
	ld	d, b
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ldhl	sp,	#10
	ld	(hl), e
00113$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:46: pivot_y = sprite->y + sprite->coll_h - 1;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	dec	bc
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:47: if((UINT16)pivot_y >= scroll_h) { //This checks pivot_y < 0 || pivot_y >= scroll_h
	ld	e, c
	ld	d, b
	ld	hl, #_scroll_h
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00118$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:48: if(pivot_y < 0) 
	bit	7, b
	jr	Z, 00115$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:49: end_tile_y = 0;
	ld	e, #0x00
	jr	00119$
00115$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:51: end_tile_y = scroll_tiles_h - 1;
	ldhl	sp,	#9
	ld	e, (hl)
	jr	00119$
00118$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:53: end_tile_y = PX_TO_TILE(pivot_y);
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ld	e, c
00119$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:56: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#3
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:57: SWITCH_ROM(scroll_bank);
	ld	a, (_scroll_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:58: tile_coll = scroll_map + (scroll_tiles_w * start_tile_y + start_tile_x);
	ldhl	sp,	#10
	ld	c, (hl)
	xor	a, a
	push	de
	ld	b, a
	ld	a, (_scroll_tiles_w)
	ld	e, a
	ld	hl, #_scroll_tiles_w + 1
	ld	d, (hl)
	call	__mulint
	pop	de
	ldhl	sp,	#6
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ld	d, #0x00
	add	a, c
	ld	c, a
	ld	a, d
	adc	a, b
	ld	b, a
	ld	a, (#_scroll_map)
	add	a, c
	ld	(#_tile_coll),a
	ld	a, (#_scroll_map + 1)
	adc	a, b
	ld	(#_tile_coll + 1),a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:59: end_tile_y ++;
	ld	c, e
	inc	c
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:60: scroll_coll_group = sprite->coll_group;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0022
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	b, a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:61: for(tmp = start_tile_y; tmp != end_tile_y; tmp ++, tile_coll += scroll_tiles_w) {
	ldhl	sp,	#10
	ld	e, (hl)
00160$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:17: pivot_x = sprite->x + (UINT8)(sprite->coll_w - 1u);
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	push	de
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:61: for(tmp = start_tile_y; tmp != end_tile_y; tmp ++, tile_coll += scroll_tiles_w) {
	ld	a, c
	sub	a, e
	jp	Z, 00125$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:62: if(scroll_collisions[*tile_coll] & scroll_coll_group) {
	ld	a, (_tile_coll)
	ld	l, a
	ld	a, (_tile_coll + 1)
	ld	h, a
	ld	a, (hl)
	add	a, #<(_scroll_collisions)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_scroll_collisions)
	ld	h, a
	ld	a, (hl)
	and	a, b
	jr	Z, 00161$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:63: if(x > 0) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00121$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:64: sprite->x = TILE_TO_PX(start_tile_x) - sprite->coll_w;
	ldhl	sp,	#5
	ld	a, (hl)
	ld	b, #0x00
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	ldhl	sp,#9
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	l, a
	pop	af
	ld	h, #0x00
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00122$
00121$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:66: sprite->x = TILE_TO_PX(start_tile_x + 1);
	ldhl	sp,	#5
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00122$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:69: ret = *tile_coll;
	ld	a, (_tile_coll)
	ld	hl, #_tile_coll + 1
	ld	h, (hl)
	ld	l, a
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:70: SWITCH_ROM(__save);
	ldhl	sp,	#3
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:71: goto done_x;
	jr	00129$
00161$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:61: for(tmp = start_tile_y; tmp != end_tile_y; tmp ++, tile_coll += scroll_tiles_w) {
	inc	e
	ld	a, (#_tile_coll)
	ld	hl, #_scroll_tiles_w
	add	a, (hl)
	ld	hl, #_tile_coll
	ld	(hl+), a
	ld	a, (hl)
	ld	hl, #_scroll_tiles_w + 1
	adc	a, (hl)
	ld	(#_tile_coll + 1),a
	jp	00160$
00125$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:74: SWITCH_ROM(__save);
	ldhl	sp,	#3
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:77: inc_x:
00128$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:78: sprite->x += x;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#11
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	l, e
	ld	h, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:79: done_x:
00129$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:36: if(sprite->y >= scroll_h) { //This checks sprite->y < 0 || sprite->y >= scroll_h
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:81: if (y) {
	ldhl	sp,	#16
	ld	a, (hl)
	or	a, a
	jp	Z, 00157$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:82: if (y > 0) {
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00349$
	bit	7, d
	jr	NZ, 00350$
	cp	a, a
	jr	00350$
00349$:
	bit	7, d
	jr	Z, 00350$
	scf
00350$:
	ld	a, #0x00
	rla
	ldhl	sp,	#5
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:83: pivot_y = sprite->y + (UINT8)(sprite->coll_h - 1u);
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:82: if (y > 0) {
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00131$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:83: pivot_y = sprite->y + (UINT8)(sprite->coll_h - 1u);
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	dec	a
	ld	e, #0x00
	ld	l, a
	ld	h, e
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	jr	00132$
00131$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:85: pivot_y = sprite->y;
	inc	sp
	inc	sp
	push	bc
00132$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:89: tmp = PX_TO_TILE(pivot_y);
	pop	bc
	push	bc
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:90: pivot_y += y;
	ldhl	sp,	#16
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	pop	hl
	push	hl
	add	hl, de
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:91: start_tile_y = PX_TO_TILE(pivot_y);
	ld	b, l
	ld	e, h
	ld	d, e
	sra	d
	rr	l
	sra	d
	rr	l
	sra	d
	rr	l
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:92: if(tmp == start_tile_y) {
	ld	a, (hl)
	sub	a, c
	jp	Z, 00157$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:97: if((UINT16)pivot_y >= scroll_h) {
	ld	hl, #_scroll_h
	ld	a, b
	sub	a, (hl)
	inc	hl
	ld	a, e
	sbc	a, (hl)
	jp	NC, 00157$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:102: if(sprite->x >= scroll_w){
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:106: start_tile_x = scroll_tiles_w - 1;
	ld	a, (_scroll_tiles_w)
	dec	a
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:102: if(sprite->x >= scroll_w){
	ld	hl, #_scroll_w
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00141$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:103: if((INT16)sprite->x < 0) 
	ld	h, b
	bit	7, h
	jr	Z, 00138$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:104: start_tile_x = 0;
	ldhl	sp,	#7
	ld	(hl), #0x00
	jr	00142$
00138$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:106: start_tile_x = scroll_tiles_w - 1;
	ldhl	sp,	#8
	ld	a, (hl-)
	ld	(hl), a
	jr	00142$
00141$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:108: start_tile_x = PX_TO_TILE(sprite->x);
	ld	e, c
	ld	d, b
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ldhl	sp,	#7
	ld	(hl), e
00142$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:112: pivot_x = sprite->x + sprite->coll_w - 1;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	de, #0x0001
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#10
	ld	(hl-), a
	ld	(hl), e
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:113: if((UINT16)pivot_x >= scroll_w) {
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_scroll_w
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00147$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:114: if(pivot_x < 0) 
	ldhl	sp,	#10
	ld	a, (hl)
	bit	7, a
	jr	Z, 00144$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:115: end_tile_x = 0;
	ld	e, #0x00
	jr	00148$
00144$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:117: end_tile_x = scroll_tiles_w - 1;
	ldhl	sp,	#8
	ld	e, (hl)
	jr	00148$
00147$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:119: end_tile_x = PX_TO_TILE(pivot_x);
	ldhl	sp,	#9
	ld	e, (hl)
	inc	hl
	ld	c, (hl)
	sra	c
	rr	e
	sra	c
	rr	e
	sra	c
	rr	e
00148$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:122: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#8
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:57: SWITCH_ROM(scroll_bank);
	ld	a, (_scroll_bank)
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:123: SWITCH_ROM(scroll_bank);
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:124: tile_coll = scroll_map + (scroll_tiles_w * start_tile_y + start_tile_x);
	ldhl	sp,	#6
	ld	c, (hl)
	xor	a, a
	push	de
	ld	b, a
	ld	a, (_scroll_tiles_w)
	ld	e, a
	ld	hl, #_scroll_tiles_w + 1
	ld	d, (hl)
	call	__mulint
	pop	de
	ldhl	sp,	#7
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (#_scroll_map)
	add	a, c
	ld	(#_tile_coll),a
	ld	a, (#_scroll_map + 1)
	adc	a, b
	ld	(#_tile_coll + 1),a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:125: end_tile_x ++;
	ld	a, e
	inc	a
	ldhl	sp,	#9
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:126: scroll_coll_group = y < 0 ? sprite->coll_group : sprite->coll_group_down;
	ldhl	sp,	#16
	bit	7, (hl)
	jr	Z, 00167$
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0022
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	jr	00168$
00167$:
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0023
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
00168$:
	ldhl	sp,	#10
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:127: for(tmp = start_tile_x; tmp != end_tile_x; tmp ++, tile_coll += 1) {
	ldhl	sp,	#7
	ld	c, (hl)
00163$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:36: if(sprite->y >= scroll_h) { //This checks sprite->y < 0 || sprite->y >= scroll_h
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:127: for(tmp = start_tile_x; tmp != end_tile_x; tmp ++, tile_coll += 1) {
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, c
	jp	Z, 00154$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:128: if(scroll_collisions[*tile_coll] & scroll_coll_group) {
	ld	a, (_tile_coll)
	ld	hl, #_tile_coll + 1
	ld	h, (hl)
	ld	l, a
	ld	l, (hl)
	ld	h, #0x00
	ld	de, #_scroll_collisions
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#10
	and	a, (hl)
	jr	Z, 00164$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:130: sprite->y = TILE_TO_PX(start_tile_y) - sprite->coll_h;
	ldhl	sp,	#6
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:129: if(y > 0) {
	ld	a, (hl-)
	ld	e, a
	ld	d, #0x00
	ld	a, (hl)
	or	a, a
	jr	Z, 00150$
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:130: sprite->y = TILE_TO_PX(start_tile_y) - sprite->coll_h;
	ld	c, e
	ld	b, d
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00151$
00150$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:132: sprite->y = TILE_TO_PX(start_tile_y + 1);
	ld	l, e
	ld	h, d
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00151$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:135: ret = *tile_coll;
	ld	a, (_tile_coll)
	ld	hl, #_tile_coll + 1
	ld	h, (hl)
	ld	l, a
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:136: SWITCH_ROM(__save);
	ldhl	sp,	#8
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:137: goto done_y;
	jr	00158$
00164$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:127: for(tmp = start_tile_x; tmp != end_tile_x; tmp ++, tile_coll += 1) {
	inc	c
	ld	hl, #_tile_coll
	inc	(hl)
	jp	NZ, 00163$
	inc	hl
	inc	(hl)
	jp	00163$
00154$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:140: SWITCH_ROM(__save);
	ldhl	sp,	#8
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:143: inc_y:
00157$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:144: sprite->y += y;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#16
	ld	a, (hl)
	ld	e, a
	rlca
	sbc	a, a
	ld	l, e
	ld	h, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:145: done_y:
00158$:
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:147: return ret;
	ldhl	sp,	#4
	ld	a, (hl)
;C:/CrossZGB/ZGB/common/src/SpriteTranslateSprite.c:148: }
	add	sp, #14
	pop	hl
	inc	sp
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
