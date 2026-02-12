;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module ScrollUpdateTile
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _UPDATE_TILE
	.globl _GetTileReplacement
	.globl _SpriteManagerAdd
	.globl _set_bkg_tile_xy
	.globl _set_vram_byte
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_UPDATE_TILE_replacement_10000_263:
	.ds 1
_UPDATE_TILE_type_30000_266:
	.ds 1
_UPDATE_TILE_i_50000_268:
	.ds 1
_UPDATE_TILE_id_50000_268:
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
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:15: void UPDATE_TILE(INT16 x, INT16 y) {
;	---------------------------------
; Function UPDATE_TILE
; ---------------------------------
_UPDATE_TILE::
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:18: if(((UINT16)x >= scroll_tiles_w) || ((UINT16)y >= scroll_tiles_h)) { //This also checks x < 0 || y < 0
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_scroll_tiles_w
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00109$
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_scroll_tiles_h
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00110$
00109$:
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:19: replacement = 0;
	xor	a, a
	ld	(#_UPDATE_TILE_replacement_10000_263),a
	jp	00111$
00110$:
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:22: replacement = *scroll_ptr;
	ld	a, (_scroll_ptr)
	ld	hl, #_scroll_ptr + 1
	ld	h, (hl)
	ld	l, a
	ld	a, (hl)
	ld	(#_UPDATE_TILE_replacement_10000_263),a
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:23: type = GetTileReplacement(scroll_ptr, &replacement);
	ld	bc, #_UPDATE_TILE_replacement_10000_263
	ld	a, (_scroll_ptr)
	ld	e, a
	ld	hl, #_scroll_ptr + 1
	ld	d, (hl)
	call	_GetTileReplacement
	ld	hl, #_UPDATE_TILE_type_30000_266
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:24: if(type != 255u) {
	ld	a, (hl)
	inc	a
	jp	Z, 00111$
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:27: id = SPRITE_UNIQUE_ID(x, y);
	ldhl	sp,	#6
	ld	a, (hl-)
	dec	hl
	ld	c, #0x00
	ld	b, (hl)
	ld	e, #0x00
	ld	(_UPDATE_TILE_id_50000_268), a
	ld	a, b
	ld	(_UPDATE_TILE_id_50000_268 + 1), a
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:28: for (i = VECTOR_LEN(sprite_manager_updatables); (i); i--) {
	ld	a, (#_sprite_manager_updatables + 0)
	ld	(#_UPDATE_TILE_i_50000_268),a
00117$:
	ld	hl, #_UPDATE_TILE_i_50000_268
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:29: Sprite* s = sprite_manager_sprites[sprite_manager_updatables[i]];
	ld	a, #<(_sprite_manager_updatables)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_sprite_manager_updatables)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	ld	de, #_sprite_manager_sprites
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:30: if ((s->type == type) && (s->unique_id == id)) {
	ld	hl, #0x001d
	add	hl, bc
	ld	a, (hl)
	ld	hl, #_UPDATE_TILE_type_30000_266
	sub	a, (hl)
	jr	NZ, 00118$
	ld	hl, #0x001f
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_UPDATE_TILE_id_50000_268
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00182$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00104$
00182$:
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:31: break;
00118$:
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:28: for (i = VECTOR_LEN(sprite_manager_updatables); (i); i--) {
	ld	hl, #_UPDATE_TILE_i_50000_268
	dec	(hl)
	jr	00117$
00104$:
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:34: if (i == 0) {
	ld	a, (#_UPDATE_TILE_i_50000_268)
	or	a, a
	jr	NZ, 00111$
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:35: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#3
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:36: SWITCH_ROM(spriteDataBanks[type]);
	ld	a, #<(_spriteDataBanks)
	ld	hl, #_UPDATE_TILE_type_30000_266
	add	a, (hl)
	ld	c, a
	ld	a, #>(_spriteDataBanks)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:37: UINT16 sprite_y = TILE_TO_PX(y + 1) - spriteDatas[type]->height;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	a, (_UPDATE_TILE_type_30000_266)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	ld	de, #_spriteDatas
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	e, (hl)
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:38: SWITCH_ROM(__save);
	ldhl	sp,	#3
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:39: SpriteManagerAdd(type, TILE_TO_PX(x), sprite_y);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	d, (hl)
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	push	bc
	ld	e, a
	ld	a, (_UPDATE_TILE_type_30000_266)
	call	_SpriteManagerAdd
00111$:
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:44: ScrollSetAttrTileXY(SCREEN_BKG_OFFSET_X + x + scroll_offset_x, y + scroll_offset_y, replacement, ((scroll_cptr) ? *scroll_cptr : scroll_tile_info[replacement]));
	ld	hl, #_scroll_cptr + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00121$
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, (hl)
	jr	00122$
00121$:
	ld	a, #<(_scroll_tile_info)
	ld	hl, #_UPDATE_TILE_replacement_10000_263
	add	a, (hl)
	ld	c, a
	ld	a, #>(_scroll_tile_info)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
00122$:
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_UPDATE_TILE_replacement_10000_263)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (_scroll_offset_y)
	add	a, (hl)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (_scroll_offset_x)
	add	a, (hl)
;C:/CrossZGB/ZGB/common/include/Scroll.h:178: UINT8* addr = set_bkg_tile_xy(x, y, t);
	dec	hl
	dec	hl
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#3
	ld	e, (hl)
	call	_set_bkg_tile_xy
;C:/CrossZGB/ZGB/common/include/Scroll.h:180: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00119$
;C:/CrossZGB/ZGB/common/include/Scroll.h:181: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Scroll.h:182: set_vram_byte(addr, c);
	ldhl	sp,	#0
	ld	a, (hl)
	ld	e, c
	ld	d, b
	call	_set_vram_byte
;C:/CrossZGB/ZGB/common/include/Scroll.h:183: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:44: ScrollSetAttrTileXY(SCREEN_BKG_OFFSET_X + x + scroll_offset_x, y + scroll_offset_y, replacement, ((scroll_cptr) ? *scroll_cptr : scroll_tile_info[replacement]));
00119$:
;C:/CrossZGB/ZGB/common/src/ScrollUpdateTile.c:45: }
	add	sp, #8
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
