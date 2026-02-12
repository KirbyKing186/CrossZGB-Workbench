;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module ScrollFindTile
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ScrollFindTile
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
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:3: UINT8 ScrollFindTile(UINT8 map_bank, const struct MapInfo* map, UINT8 tile, UINT16 start_x, UINT16 start_y, UINT16 w, UINT16 h, UINT16* x, UINT16* y) {
;	---------------------------------
; Function ScrollFindTile
; ---------------------------------
_ScrollFindTile::
	add	sp, #-21
	ld	c, a
	ldhl	sp,	#17
	ld	(hl), e
	inc	hl
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:4: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:5: SWITCH_ROM(map_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:6: for (UINT16 xt = start_x; xt != start_x + w; ++ xt) {
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,#24
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#28
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#24
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl), a
00109$:
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:9: *x = xt;
	ldhl	sp,	#32
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#33
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:10: *y = yt;
	ldhl	sp,	#34
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#35
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:6: for (UINT16 xt = start_x; xt != start_x + w; ++ xt) {
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NZ, 00148$
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#20
	sub	a, (hl)
	jp	Z, 00104$
00148$:
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:7: for (UINT16 yt = start_y; yt != start_y + h; ++ yt) {
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#11
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#30
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00106$:
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00149$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00110$
00149$:
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:8: if (map->data[map->width * yt + xt] == tile) {
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#15
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	push	bc
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	ld	e, c
	ld	d, b
	pop	bc
	ldhl	sp,	#19
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#15
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00107$
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:9: *x = xt;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#24
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:10: *y = yt;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:11: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:12: return 1;
	ld	a, #0x01
	jr	00111$
00107$:
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:7: for (UINT16 yt = start_y; yt != start_y + h; ++ yt) {
	inc	bc
	ldhl	sp,	#9
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00106$
00110$:
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:6: for (UINT16 xt = start_x; xt != start_x + w; ++ xt) {
	ldhl	sp,	#19
	inc	(hl)
	jr	NZ, 00152$
	inc	hl
	inc	(hl)
00152$:
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	jp	00109$
00104$:
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:16: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:18: *x = *y = 0;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:19: return 0;
	xor	a, a
00111$:
;C:/CrossZGB/ZGB/common/src/ScrollFindTile.c:20: }
	add	sp, #21
	pop	hl
	add	sp, #13
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
