;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Sprite
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _SpriteManagerRemoveSprite
	.globl _GetSpriteAnimation
	.globl _InitSprite
	.globl _SetSpriteAnim
	.globl _DrawSprite
	.globl _CheckCollision
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_DrawSprite_screen_x_10000_284:
	.ds 2
_DrawSprite_screen_y_10000_284:
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
;C:/CrossZGB/ZGB/common/src/Sprite.c:19: void InitSprite(Sprite* sprite, UINT8 sprite_type) {
;	---------------------------------
; Function InitSprite
; ---------------------------------
_InitSprite::
	add	sp, #-9
	ldhl	sp,	#7
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	c, a
;C:/CrossZGB/ZGB/common/src/Sprite.c:20: const struct MetaSpriteInfo* mt_sprite_info = spriteDatas[sprite_type];
	ld	de, #_spriteDatas+0
	ld	l, c
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:22: sprite->mt_sprite_info = mt_sprite_info;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:23: sprite->mt_sprite_bank = spriteDataBanks[sprite_type];
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	de, #_spriteDataBanks
	ld	l, c
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	pop	hl
	push	hl
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:25: sprite->flips = spriteFlips[sprite_type];
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #_spriteFlips
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:26: sprite->first_tile = spriteIdxs[sprite_type];
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #_spriteIdxs
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:27: sprite->first_tile_H = spriteIdxsH[sprite_type];
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #_spriteIdxsH
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:28: sprite->first_tile_V = spriteIdxsV[sprite_type];
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #_spriteIdxsV
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:29: sprite->first_tile_HV = spriteIdxsHV[sprite_type];
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #_spriteIdxsHV
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:31: sprite->attr_add = (_cpu == CGB_TYPE) ? spritePalsOffset[sprite_type] : 0;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00107$
	ld	hl, #_spritePalsOffset
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	jr	00108$
00107$:
	xor	a, a
00108$:
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:36: sprite->anim_data = NULL;	
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:37: sprite->anim_speed = 33u;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	(hl), #0x21
;C:/CrossZGB/ZGB/common/include/Sprite.h:81: sprite->mt_sprite = GetSpriteAnimation(sprite, frame);
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	push	hl
	ld	bc, #0x0000
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_GetSpriteAnimation
	pop	de
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
;C:/CrossZGB/ZGB/common/include/Sprite.h:82: sprite->anim_frame = frame;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0013
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:41: sprite->ctx = NULL;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0017
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:43: sprite->x = 0;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:44: sprite->y = 0;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	c, a
;C:/CrossZGB/ZGB/common/src/Sprite.c:46: sprite->coll_group = COLL_GROUP_DEFAULT;
	ld	a, (hl-)
	ld	b, a
	inc	bc
	inc	bc
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	(bc), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0022
	add	hl, de
	ld	(hl), #0x01
;C:/CrossZGB/ZGB/common/src/Sprite.c:47: sprite->coll_group_down = COLL_GROUP_DOWN;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0023
	add	hl, de
	ld	(hl), #0x80
;C:/CrossZGB/ZGB/common/include/Sprite.h:100: sprite->visible = (visible);
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0021
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, #0x01
	ld	(bc), a
;C:/CrossZGB/ZGB/common/include/Sprite.h:103: sprite->persistent = (persistent);
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0021
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	and	a, #0xfd
	ld	(bc), a
;C:/CrossZGB/ZGB/common/include/Sprite.h:106: sprite->loop_anim = (loop_anim);
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0021
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, #0x04
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:53: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#6
;C:/CrossZGB/ZGB/common/src/Sprite.c:54: SWITCH_ROM(spriteDataBanks[sprite_type]);
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Sprite.c:55: sprite->coll_w = mt_sprite_info->width;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:56: sprite->coll_h = mt_sprite_info->height;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	inc	de
	ld	a, (de)
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:57: SWITCH_ROM(__save);
	ldhl	sp,	#6
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Sprite.c:58: }
	add	sp, #9
	ret
;C:/CrossZGB/ZGB/common/src/Sprite.c:60: void SetSpriteAnim(Sprite* sprite, const UINT8* data, UINT8 speed) {
;	---------------------------------
; Function SetSpriteAnim
; ---------------------------------
_SetSpriteAnim::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:61: if (sprite->anim_data != data) {
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, l
	sub	a, c
	jr	NZ, 00113$
	ld	a, h
	sub	a, b
	jr	Z, 00104$
00113$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:62: sprite->anim_data = (UINT8* )data;
	pop	hl
	push	hl
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/Sprite.c:63: SetFrame(sprite, VECTOR_GET(data, 0));
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#1
;C:/CrossZGB/ZGB/common/include/Sprite.h:81: sprite->mt_sprite = GetSpriteAnimation(sprite, frame);
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	c, a
	xor	a, a
	push	de
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_GetSpriteAnimation
	pop	de
	ld	a, c
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
;C:/CrossZGB/ZGB/common/include/Sprite.h:82: sprite->anim_frame = frame;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0013
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
;C:/CrossZGB/ZGB/common/src/Sprite.c:64: sprite->anim_frame = 0;
;C:/CrossZGB/ZGB/common/src/Sprite.c:65: sprite->anim_accum_ticks = 0;
	ld	a, (hl+)
	ld	(bc), a
	xor	a, a
	ld	(bc), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:66: sprite->anim_speed = speed;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
00104$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:68: }
	add	sp, #4
	pop	hl
	inc	sp
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/Sprite.c:72: void DrawSprite(void) {
;	---------------------------------
; Function DrawSprite
; ---------------------------------
_DrawSprite::
	add	sp, #-16
;C:/CrossZGB/ZGB/common/src/Sprite.c:74: screen_x = THIS->x - scroll_x;
	ld	hl, #_THIS
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (_scroll_x)
	ld	e, a
	ld	hl, #_scroll_x + 1
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	hl, #_DrawSprite_screen_x_10000_284
	ld	(hl+), a
	ld	a, b
	sbc	a, d
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:75: screen_y = THIS->y - scroll_y;
	ld	a, (#_THIS)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (#_THIS + 1)
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (_scroll_y)
	ld	e, a
	ld	hl, #_scroll_y + 1
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	hl, #_DrawSprite_screen_y_10000_284
	ld	(hl+), a
	ld	a, b
	sbc	a, d
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:78: if (THIS->anim_data) {
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	a, (hl+)
	or	a, (hl)
	jp	Z, 00109$
;C:/CrossZGB/ZGB/common/src/Sprite.c:79: THIS->anim_accum_ticks += (THIS->anim_speed << delta_time);
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#15
	ld	(hl-), a
	dec	hl
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0012
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #_delta_time
	ld	b, (hl)
	inc	b
	jr	00220$
00219$:
	add	a, a
00220$:
	dec	b
	jr	NZ,00219$
	ldhl	sp,	#15
	add	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:75: screen_y = THIS->y - scroll_y;
	ld	a, (_THIS)
	ld	hl, #_THIS + 1
	ld	h, (hl)
;C:/CrossZGB/ZGB/common/src/Sprite.c:79: THIS->anim_accum_ticks += (THIS->anim_speed << delta_time);
	ld	l, a
	ld	de, #0x0011
	add	hl, de
	ld	a, (hl)
;C:/CrossZGB/ZGB/common/src/Sprite.c:80: if (THIS->anim_accum_ticks >= 100u) {
	cp	a, #0x64
	jp	C, 00109$
;C:/CrossZGB/ZGB/common/src/Sprite.c:81: THIS->anim_accum_ticks -= 100u;
	add	a, #0x9c
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:83: if (++THIS->anim_frame >= VECTOR_LEN(THIS->anim_data)) {
	ld	a, (_THIS)
	ld	hl, #_THIS + 1
	ld	b, (hl)
	add	a, #0x13
	ld	c, a
	jr	NC, 00221$
	inc	b
00221$:
	ld	a, (bc)
	inc	a
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, (hl)
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:75: screen_y = THIS->y - scroll_y;
	ld	a, (_THIS)
	ld	c, a
	ld	hl, #_THIS + 1
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/Sprite.c:83: if (++THIS->anim_frame >= VECTOR_LEN(THIS->anim_data)) {
	ld	hl, #0x000f
	add	hl, bc
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	e, (hl)
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, e
	jr	C, 00105$
;C:/CrossZGB/ZGB/common/src/Sprite.c:84: if (THIS->loop_anim) {
	ld	hl, #0x0021
	add	hl, bc
	ld	a, (hl)
	rrca
	rrca
	and	a, #0x01
	ld	e, a
;C:/CrossZGB/ZGB/common/src/Sprite.c:85: THIS->anim_frame = 0;
	ld	hl, #0x0013
	add	hl, bc
;C:/CrossZGB/ZGB/common/src/Sprite.c:84: if (THIS->loop_anim) {
	ld	a, e
	or	a, a
	jr	Z, 00102$
;C:/CrossZGB/ZGB/common/src/Sprite.c:85: THIS->anim_frame = 0;
	ld	(hl), #0x00
	jr	00105$
00102$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:87: --THIS->anim_frame;
	dec	(hl)
	ld	a, (hl)
00105$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:75: screen_y = THIS->y - scroll_y;
	ld	a, (_THIS)
	ld	c, a
	ld	hl, #_THIS + 1
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/Sprite.c:90: THIS->mt_sprite = GetSpriteAnimation(THIS, VECTOR_GET(THIS->anim_data, THIS->anim_frame));
	ld	hl, #0x0014
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
	ld	hl, #0x000f
	add	hl, bc
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	add	a, #0x13
	ld	c, a
	jr	NC, 00222$
	inc	b
00222$:
	ld	a, (bc)
	ld	b, #0x00
	ld	c, a
	inc	bc
	add	hl, bc
	ld	c, (hl)
	xor	a, a
	ld	b, a
	ld	a, (_THIS)
	ld	e, a
	ld	hl, #_THIS + 1
	ld	d, (hl)
	call	_GetSpriteAnimation
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00109$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:75: screen_y = THIS->y - scroll_y;
	ld	a, (_THIS)
	ld	c, a
	ld	hl, #_THIS + 1
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/Sprite.c:96: (THIS->visible) &&
	ld	hl, #0x0021
	add	hl, bc
	ld	a, (hl)
	and	a, #0x01
	ld	e, a
	or	a, a
	jp	Z, 00121$
;C:/CrossZGB/ZGB/common/src/Sprite.c:98: ((UINT16)(screen_x + MAXIMUM_SPRITES_SIZE) < (UINT16)(DEVICE_SCREEN_PX_WIDTH + (MAXIMUM_SPRITES_SIZE << 1))) &&
	ld	hl, #_DrawSprite_screen_x_10000_284
	ld	a, (hl+)
	add	a, #0x20
	ld	e, a
	ld	a, (hl)
	adc	a, #0x00
	ld	d, a
	ld	a, e
	sub	a, #0xe0
	ld	a, d
	sbc	a, #0x00
	jp	NC, 00121$
;C:/CrossZGB/ZGB/common/src/Sprite.c:99: ((UINT16)(screen_y + MAXIMUM_SPRITES_SIZE) < (UINT16)(DEVICE_SCREEN_PX_HEIGHT + (MAXIMUM_SPRITES_SIZE << 1)))
	ld	hl, #_DrawSprite_screen_y_10000_284
	ld	a, (hl+)
	add	a, #0x20
	ld	e, a
	ld	a, (hl)
	adc	a, #0x00
	ld	d, a
	ld	a, e
	sub	a, #0xd0
	ld	a, d
	sbc	a, #0x00
	jp	NC, 00121$
;C:/CrossZGB/ZGB/common/src/Sprite.c:103: screen_x += (DEVICE_SPRITE_PX_OFFSET_X + SCREEN_SPR_OFFSET_X);
	ld	hl, #_DrawSprite_screen_x_10000_284
	ld	a, (hl)
	add	a, #0x08
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:104: screen_y += DEVICE_SPRITE_PX_OFFSET_Y;
	ld	hl, #_DrawSprite_screen_y_10000_284
	ld	a, (hl)
	add	a, #0x10
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:107: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:75: screen_y = THIS->y - scroll_y;
	ld	a, (_THIS)
	ld	c, a
	ld	hl, #_THIS + 1
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/Sprite.c:108: SWITCH_ROM(THIS->mt_sprite_bank);
	ld	hl, #0x0006
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldh	(__current_bank + 0), a
	ld	a, (de)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Sprite.c:109: switch(THIS->mirror) {
	ld	hl, #0x0016
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, #0x04
	ldhl	sp,	#1
	sub	a, (hl)
	jp	C, 00115$
;C:/CrossZGB/ZGB/common/src/Sprite.c:110: case NO_MIRROR: next_oam_idx += move_metasprite_ex    (THIS->mt_sprite, THIS->first_tile,    THIS->attr_add, next_oam_idx, screen_x,                screen_y               ); break;
	ld	a, (#_DrawSprite_screen_y_10000_284)
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (#_DrawSprite_screen_x_10000_284)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (#_next_oam_idx)
	ldhl	sp,	#4
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:111: case H_MIRROR:  next_oam_idx += move_metasprite_flipy (THIS->mt_sprite, THIS->first_tile_H,  THIS->attr_add, next_oam_idx, screen_x,                screen_y + THIS->coll_h); break;
	ld	a, (#_DrawSprite_screen_y_10000_284)
	ldhl	sp,	#5
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:112: case V_MIRROR:  next_oam_idx += move_metasprite_flipx (THIS->mt_sprite, THIS->first_tile_V,  THIS->attr_add, next_oam_idx, screen_x + THIS->coll_w, screen_y               ); break;
	ld	a, (#_DrawSprite_screen_x_10000_284)
	ldhl	sp,	#6
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:90: THIS->mt_sprite = GetSpriteAnimation(THIS, VECTOR_GET(THIS->anim_data, THIS->anim_frame));
	ld	hl, #0x0014
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:110: case NO_MIRROR: next_oam_idx += move_metasprite_ex    (THIS->mt_sprite, THIS->first_tile,    THIS->attr_add, next_oam_idx, screen_x,                screen_y               ); break;
	ld	hl, #0x000e
	add	hl, bc
	ld	e, l
	ld	d, h
;C:/CrossZGB/ZGB/common/src/Sprite.c:111: case H_MIRROR:  next_oam_idx += move_metasprite_flipy (THIS->mt_sprite, THIS->first_tile_H,  THIS->attr_add, next_oam_idx, screen_x,                screen_y + THIS->coll_h); break;
	ld	hl, #0x0005
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:112: case V_MIRROR:  next_oam_idx += move_metasprite_flipx (THIS->mt_sprite, THIS->first_tile_V,  THIS->attr_add, next_oam_idx, screen_x + THIS->coll_w, screen_y               ); break;
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
;C:/CrossZGB/ZGB/common/src/Sprite.c:110: case NO_MIRROR: next_oam_idx += move_metasprite_ex    (THIS->mt_sprite, THIS->first_tile,    THIS->attr_add, next_oam_idx, screen_x,                screen_y               ); break;
	ld	(hl+), a
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#12
	ld	(hl+), a
	inc	de
	ld	a, (de)
;c:\crosszgb\gbdk\include\gb\metasprites.h:160: __current_metasprite = metasprite;
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:109: switch(THIS->mirror) {
	ldhl	sp,	#1
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #00223$
	add	hl, de
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	jp	(hl)
00223$:
	.dw	00110$
	.dw	00111$
	.dw	00112$
	.dw	00114$
	.dw	00114$
;C:/CrossZGB/ZGB/common/src/Sprite.c:110: case NO_MIRROR: next_oam_idx += move_metasprite_ex    (THIS->mt_sprite, THIS->first_tile,    THIS->attr_add, next_oam_idx, screen_x,                screen_y               ); break;
00110$:
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#___current_base_prop),a
	ld	hl, #0x000a
	add	hl, bc
	ld	a, (hl)
	ld	(#___current_base_tile),a
;c:\crosszgb\gbdk\include\gb\metasprites.h:160: __current_metasprite = metasprite;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\crosszgb\gbdk\include\gb\metasprites.h:163: return __move_metasprite(base_sprite, (y << 8) | (uint8_t)x);
	ldhl	sp,	#4
	ld	a, (hl)
	call	___move_metasprite
;C:/CrossZGB/ZGB/common/src/Sprite.c:110: case NO_MIRROR: next_oam_idx += move_metasprite_ex    (THIS->mt_sprite, THIS->first_tile,    THIS->attr_add, next_oam_idx, screen_x,                screen_y               ); break;
	ld	hl, #_next_oam_idx
	add	a, (hl)
	ld	(hl), a
	jp	00115$
;C:/CrossZGB/ZGB/common/src/Sprite.c:111: case H_MIRROR:  next_oam_idx += move_metasprite_flipy (THIS->mt_sprite, THIS->first_tile_H,  THIS->attr_add, next_oam_idx, screen_x,                screen_y + THIS->coll_h); break;
00111$:
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#5
	add	a, (hl)
	dec	hl
	dec	hl
	ld	d, a
	ld	e, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#___current_base_prop),a
	ld	hl, #0x000b
	add	hl, bc
	ld	a, (hl)
	ld	(#___current_base_tile),a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, (hl)
	ldhl	sp,	#4
	ld	l, (hl)
;c:\crosszgb\gbdk\include\gb\metasprites.h:241: __current_metasprite = metasprite;
	ld	(___current_metasprite), a
	ld	a, c
	ld	(___current_metasprite + 1), a
;c:\crosszgb\gbdk\include\gb\metasprites.h:244: return __move_metasprite_flipy(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | x);
	push	de
	ldh	a, (_LCDC_REG + 0)
	ld	c, a
	pop	af
	bit	2, c
	jr	Z, 00131$
	ld	bc, #0x0010
	jr	00132$
00131$:
	ld	bc, #0x0008
00132$:
	sub	a, c
	ld	d, a
	ld	a, l
	call	___move_metasprite_flipy
;C:/CrossZGB/ZGB/common/src/Sprite.c:111: case H_MIRROR:  next_oam_idx += move_metasprite_flipy (THIS->mt_sprite, THIS->first_tile_H,  THIS->attr_add, next_oam_idx, screen_x,                screen_y + THIS->coll_h); break;
	ld	hl, #_next_oam_idx
	add	a, (hl)
	ld	(hl), a
	jp	00115$
;C:/CrossZGB/ZGB/common/src/Sprite.c:112: case V_MIRROR:  next_oam_idx += move_metasprite_flipx (THIS->mt_sprite, THIS->first_tile_V,  THIS->attr_add, next_oam_idx, screen_x + THIS->coll_w, screen_y               ); break;
00112$:
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	add	a, (hl)
	ld	e, a
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#___current_base_prop),a
	ld	hl, #0x000c
	add	hl, bc
	ld	a, (hl)
	ld	(#___current_base_tile),a
;c:\crosszgb\gbdk\include\gb\metasprites.h:200: __current_metasprite = metasprite;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(#___current_metasprite),a
	ldhl	sp,	#15
	ld	a, (hl)
	ld	(#___current_metasprite + 1),a
;c:\crosszgb\gbdk\include\gb\metasprites.h:203: return __move_metasprite_flipx(base_sprite, (y << 8) | (uint8_t)(x - 8u));
	ldhl	sp,	#13
	ld	d, (hl)
	ld	a, e
	add	a, #0xf8
	ld	e, a
	ldhl	sp,	#4
	ld	a, (hl)
	call	___move_metasprite_flipx
;C:/CrossZGB/ZGB/common/src/Sprite.c:112: case V_MIRROR:  next_oam_idx += move_metasprite_flipx (THIS->mt_sprite, THIS->first_tile_V,  THIS->attr_add, next_oam_idx, screen_x + THIS->coll_w, screen_y               ); break;
	ld	hl, #_next_oam_idx
	add	a, (hl)
	ld	(hl), a
	jr	00115$
;C:/CrossZGB/ZGB/common/src/Sprite.c:114: case HV_MIRROR: next_oam_idx += move_metasprite_flipxy(THIS->mt_sprite, THIS->first_tile_HV, THIS->attr_add, next_oam_idx, screen_x + THIS->coll_w, screen_y + THIS->coll_h); break;
00114$:
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#5
	add	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	add	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#___current_base_prop),a
	ld	hl, #0x000d
	add	hl, bc
	ld	a, (hl)
	ld	(#___current_base_tile),a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	b, (hl)
	ldhl	sp,	#4
	ld	c, (hl)
;c:\crosszgb\gbdk\include\gb\metasprites.h:281: __current_metasprite = metasprite;
	ld	hl, #___current_metasprite
	ld	(hl+), a
	ld	(hl), b
;c:\crosszgb\gbdk\include\gb\metasprites.h:284: return __move_metasprite_flipxy(base_sprite, ((y - ((LCDC_REG & LCDCF_OBJ16) ? 16u : 8u)) << 8) | (uint8_t)(x - 8));
	ldhl	sp,	#15
	ld	b, (hl)
	ldh	a, (_LCDC_REG + 0)
	bit	2, a
	jr	Z, 00133$
	ldhl	sp,	#10
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00134$
00133$:
	ldhl	sp,	#10
	ld	a, #0x08
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00134$:
	ld	e, b
	ld	d, #0x00
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (hl)
	add	a, #0xf8
	ld	e, a
	ld	a, c
	call	___move_metasprite_flipxy
;C:/CrossZGB/ZGB/common/src/Sprite.c:114: case HV_MIRROR: next_oam_idx += move_metasprite_flipxy(THIS->mt_sprite, THIS->first_tile_HV, THIS->attr_add, next_oam_idx, screen_x + THIS->coll_w, screen_y + THIS->coll_h); break;
	ld	hl, #_next_oam_idx
	add	a, (hl)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:115: }
00115$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:116: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
	jr	00129$
00121$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:120: (!(THIS->persistent)) && 
	ld	hl, #0x0021
	add	hl, bc
	ld	a, (hl)
	rrca
	and	a, #0x01
	jr	NZ, 00129$
;C:/CrossZGB/ZGB/common/src/Sprite.c:122: ((UINT16)(screen_x + THIS->lim_x + 16u) > (UINT16)((THIS->lim_x << 1) + (DEVICE_SCREEN_PX_WIDTH + (16u << 1)))) || 
	ld	hl, #0x0019
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#12
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_DrawSprite_screen_x_10000_284
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
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, (hl)
	add	a, a
	rl	e
	add	a, #0xc0
	ld	d, a
	jr	NC, 00227$
	inc	e
00227$:
	inc	hl
	ld	a, d
	sub	a, (hl)
	inc	hl
	ld	a, e
	sbc	a, (hl)
	jr	C, 00116$
;C:/CrossZGB/ZGB/common/src/Sprite.c:123: ((UINT16)(screen_y + THIS->lim_y + 16u) > (UINT16)((THIS->lim_y << 1) + (DEVICE_SCREEN_PX_HEIGHT + (16u << 1))))
	ld	hl, #0x001b
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	ld	hl, #_DrawSprite_screen_y_10000_284
	add	a, (hl)
	inc	hl
	ld	e, a
	ld	a, b
	adc	a, (hl)
	ld	d, a
	ld	hl, #0x0010
	add	hl, de
	ld	e, l
	ld	d, h
	ld	l, c
	ld	h, b
	add	hl, hl
	ld	bc, #0x00b0
	add	hl, bc
	ld	a, l
	sub	a, e
	ld	a, h
	sbc	a, d
	jr	NC, 00129$
00116$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:126: return SpriteManagerRemoveSprite(THIS);
	ld	a, (_THIS)
	ld	e, a
	ld	hl, #_THIS + 1
	ld	d, (hl)
	call	_SpriteManagerRemoveSprite
00129$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:130: }
	add	sp, #16
	ret
;C:/CrossZGB/ZGB/common/src/Sprite.c:132: UINT8 CheckCollision(Sprite* sprite1, Sprite* sprite2) {
;	---------------------------------
; Function CheckCollision
; ---------------------------------
_CheckCollision::
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
;C:/CrossZGB/ZGB/common/src/Sprite.c:133: if ((sprite1->x + sprite1->coll_w) < sprite2->x) return 0;
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	d, #0x00
	ld	e, a
	pop	hl
	push	hl
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00102$
	xor	a, a
	jp	00109$
00102$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:134: if ((sprite2->x + sprite2->coll_w) < sprite1->x) return 0;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00104$
	xor	a, a
	jr	00109$
00104$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:135: if ((sprite1->y + sprite1->coll_h) < sprite2->y) return 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	d, #0x00
	ld	e, a
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl+), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00106$
	xor	a, a
	jr	00109$
00106$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:136: if ((sprite2->y + sprite2->coll_h) < sprite1->y) return 0;
	ldhl	sp,#4
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
	ldhl	sp,	#0
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00108$
	xor	a, a
	jr	00109$
00108$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:137: return 1;
	ld	a, #0x01
00109$:
;C:/CrossZGB/ZGB/common/src/Sprite.c:138: }
	add	sp, #8
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
