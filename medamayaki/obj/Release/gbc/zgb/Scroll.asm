;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Scroll
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ScrollUpdateColumnWithDelay
	.globl _ScrollUpdateColumnR
	.globl _ScrollUpdateRowWithDelay
	.globl _ScrollUpdateRowR
	.globl _ClampScrollLimits
	.globl _UPDATE_TILE
	.globl _SetPalette
	.globl _get_win_xy_addr
	.globl _set_bkg_data
	.globl _get_bkg_xy_addr
	.globl _set_vram_byte
	.globl _memcmp
	.globl _memset
	.globl _last_tile_loaded
	.globl _pending_w_cmap
	.globl _pending_h_cmap
	.globl _pending_w_map
	.globl _pending_h_map
	.globl _clamp_enabled
	.globl _scroll_h_border
	.globl _scroll_offset_y
	.globl _scroll_offset_x
	.globl _scroll_target
	.globl _scroll_y_vblank
	.globl _scroll_x_vblank
	.globl _scroll_y
	.globl _scroll_x
	.globl _scroll_cmap
	.globl _scroll_map
	.globl _scroll_bottom_movement_limit
	.globl _scroll_top_movement_limit
	.globl _scroll_cptr
	.globl _scroll_ptr
	.globl _tiles_0
	.globl _tiles_bank_0
	.globl _hud_map_offset
	.globl _pending_w_i
	.globl _pending_w_y
	.globl _pending_w_x
	.globl _pending_h_i
	.globl _pending_h_y
	.globl _pending_h_x
	.globl _scroll_bank
	.globl _scroll_tile_info
	.globl _scroll_collisions
	.globl _scroll_tiles_h
	.globl _scroll_tiles_w
	.globl _scroll_h
	.globl _scroll_w
	.globl _ScrollSetTiles
	.globl _UpdateMapTile
	.globl _LoadMap
	.globl _ScrollSetMap
	.globl _ScrollInitTilesFromMap
	.globl _ScrollCollisionsReset
	.globl _ScrollInitCollisionGroup
	.globl _ScrollInitCollisionGroupVector
	.globl _ScrollRemoveCollisionGroupVector
	.globl _ScrollInitCollisions
	.globl _ScrollScreenRedraw
	.globl _InitScroll
	.globl _ScrollUpdateRow
	.globl _ScrollUpdateColumn
	.globl _RefreshScroll
	.globl _MoveScroll
	.globl _GetScrollTile
	.globl _GetMapSize
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_scroll_w::
	.ds 2
_scroll_h::
	.ds 2
_scroll_tiles_w::
	.ds 2
_scroll_tiles_h::
	.ds 2
_scroll_collisions::
	.ds 256
_scroll_tile_info::
	.ds 256
_scroll_bank::
	.ds 1
_pending_h_x::
	.ds 2
_pending_h_y::
	.ds 2
_pending_h_i::
	.ds 1
_pending_w_x::
	.ds 2
_pending_w_y::
	.ds 2
_pending_w_i::
	.ds 1
_hud_map_offset::
	.ds 2
_tiles_bank_0::
	.ds 1
_tiles_0::
	.ds 2
_scroll_ptr::
	.ds 2
_scroll_cptr::
	.ds 2
_ScrollUpdateRow___save_10001_343:
	.ds 1
_ScrollUpdateColumn___save_10001_358:
	.ds 1
_MoveScroll_current_column_10000_369:
	.ds 2
_MoveScroll_new_column_10000_369:
	.ds 2
_MoveScroll_current_row_10000_369:
	.ds 2
_MoveScroll_new_row_10000_369:
	.ds 2
_MoveScroll___save_10000_369:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_scroll_top_movement_limit::
	.ds 1
_scroll_bottom_movement_limit::
	.ds 1
_scroll_map::
	.ds 2
_scroll_cmap::
	.ds 2
_scroll_x::
	.ds 2
_scroll_y::
	.ds 2
_scroll_x_vblank::
	.ds 2
_scroll_y_vblank::
	.ds 2
_scroll_target::
	.ds 2
_scroll_offset_x::
	.ds 1
_scroll_offset_y::
	.ds 1
_scroll_h_border::
	.ds 2
_clamp_enabled::
	.ds 1
_pending_h_map::
	.ds 2
_pending_w_map::
	.ds 2
_pending_h_cmap::
	.ds 2
_pending_w_cmap::
	.ds 2
_last_tile_loaded::
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
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;C:/CrossZGB/ZGB/common/src/Scroll.c:65: UINT16 ScrollSetTiles(UINT8 first_tile, UINT8 tiles_bank, const struct TilesInfo* tiles) {
;	---------------------------------
; Function ScrollSetTiles
; ---------------------------------
_ScrollSetTiles::
	add	sp, #-16
	ldhl	sp,	#14
	ld	(hl-), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:70: UINT16 offset = first_tile;
	ld	a, e
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
;C:/CrossZGB/ZGB/common/src/Scroll.c:72: if(first_tile == 0) {
	ldhl	sp,	#14
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;C:/CrossZGB/ZGB/common/src/Scroll.c:73: tiles_bank_0 = tiles_bank;
	dec	hl
	ld	a, (hl)
	ld	(#_tiles_bank_0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:74: tiles_0 = tiles;
	ldhl	sp,	#18
	ld	a, (hl)
	ld	(#_tiles_0),a
	ldhl	sp,	#19
	ld	a, (hl)
	ld	(#_tiles_0 + 1),a
00102$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:77: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#2
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:78: SWITCH_ROM(tiles_bank);
	ldhl	sp,	#13
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:79: n_tiles = tiles->num_frames;
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	ldhl	sp,	#15
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:80: palette_entries = tiles->color_data;
	ld	hl, #0x0006
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#3
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:85: set_bkg_data(first_tile, n_tiles, tiles->data);
	ld	l, c
	ld	h, b
	inc	hl
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#17
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/Scroll.c:88: last_tile_loaded = first_tile + n_tiles;
	ldhl	sp,	#14
	ld	a, (hl+)
	add	a, (hl)
	ld	(#_last_tile_loaded),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:89: for(i = first_tile; i != last_tile_loaded; ++i) {
	ldhl	sp,	#14
	ld	a, (hl+)
	ld	(hl), a
00110$:
	ld	a, (#_last_tile_loaded)
	ldhl	sp,	#15
	sub	a, (hl)
	jr	Z, 00103$
;C:/CrossZGB/ZGB/common/src/Scroll.c:90: scroll_tile_info[i] = palette_entries ? palette_entries[i - first_tile] : 0;
	ld	de, #_scroll_tile_info
	ldhl	sp,	#15
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00117$
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, e
	ld	(hl+), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	jr	00118$
00117$:
	xor	a, a
00118$:
	ldhl	sp,	#5
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:89: for(i = first_tile; i != last_tile_loaded; ++i) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00110$
00103$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:96: for(i = 0; i != last_bg_pal_loaded; ++ i) {
	ld	hl, #0x0003
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
	ld	c, #0x00
00113$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:97: if (memcmp(ZGB_Fading_BPal + (i * N_PALETTE_COLORS), tiles->pals, tiles->num_pals * PALETTE_SIZE) == 0)
	ldhl	sp,	#9
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
;C:/CrossZGB/ZGB/common/src/Scroll.c:96: for(i = 0; i != last_bg_pal_loaded; ++ i) {
	ld	a, (#_last_bg_pal_loaded)
	sub	a, c
	jr	Z, 00106$
;C:/CrossZGB/ZGB/common/src/Scroll.c:97: if (memcmp(ZGB_Fading_BPal + (i * N_PALETTE_COLORS), tiles->pals, tiles->num_pals * PALETTE_SIZE) == 0)
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, #0x00
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	ldhl	sp,	#11
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	e, l
	ld	d, a
	ldhl	sp,	#9
	ld	a, (hl)
	ld	b, #0x00
	add	a, a
	rl	b
	add	a, a
	rl	b
	ld	l, b
	add	a, a
	rl	l
	add	a, #<(_ZGB_Fading_BPal)
	ld	b, a
	ld	a, l
	adc	a, #>(_ZGB_Fading_BPal)
	push	bc
	push	af
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	push	hl
	push	de
	ld	e, b
	ld	d, a
	push	de
	call	_memcmp
	add	sp, #6
	pop	bc
	ld	a, d
	or	a, e
	jr	Z, 00106$
;C:/CrossZGB/ZGB/common/src/Scroll.c:96: for(i = 0; i != last_bg_pal_loaded; ++ i) {
	inc	c
	jr	00113$
00106$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:101: offset |= (UINT16)(i << 8);
	ldhl	sp,	#9
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl+), a
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/Scroll.c:103: if(i == last_bg_pal_loaded) {
	ld	a, (#_last_bg_pal_loaded)
	sub	a, c
	jr	NZ, 00108$
;C:/CrossZGB/ZGB/common/src/Scroll.c:105: last_bg_pal_loaded += SetPalette(BG_PALETTE, last_bg_pal_loaded, tiles->num_pals, tiles->pals, tiles_bank);
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#13
	ld	h, (hl)
	push	hl
	inc	sp
	push	bc
	push	af
	inc	sp
	ld	a, (_last_bg_pal_loaded)
	ld	e, a
	xor	a, a
	call	_SetPalette
	ld	hl, #_last_bg_pal_loaded
	ld	c, (hl)
	add	a, c
	ld	(hl), a
00108$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:110: SWITCH_ROM(__save);
	ldhl	sp,	#2
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:112: return offset;
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:113: }
	add	sp, #16
	pop	hl
	pop	af
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:115: void UpdateMapTile(UINT8 bg_or_win, UINT8 x, UINT8 y, UINT16 map_offset, UINT8 data, UINT8* attr) {
;	---------------------------------
; Function UpdateMapTile
; ---------------------------------
_UpdateMapTile::
	add	sp, #-3
	ld	c, e
;C:/CrossZGB/ZGB/common/src/Scroll.c:117: UINT8* addr = (bg_or_win == TARGET_BKG) ? get_bkg_xy_addr(x, y) : get_win_xy_addr(x, y);
	or	a, a
	jr	NZ, 00106$
	ldhl	sp,	#5
	ld	e, (hl)
	ld	a, c
	call	_get_bkg_xy_addr
	jr	00107$
00106$:
	ldhl	sp,	#5
	ld	e, (hl)
	ld	a, c
	call	_get_win_xy_addr
00107$:
	inc	sp
	inc	sp
	push	bc
;C:/CrossZGB/ZGB/common/src/Scroll.c:122: ScrollSetAttrTileAddr(addr, (UINT8)map_offset + data, (attr) ? *attr : (UINT8)(map_offset >> 8) + scroll_tile_info[(UINT8)map_offset + data]);
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00108$
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	jr	00109$
00108$:
	ldhl	sp,	#7
	ld	c, (hl)
	ldhl	sp,	#2
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#8
	ld	l, (hl)
	ld	b, #0x00
	ld	h, b
	add	hl, de
	ld	de, #_scroll_tile_info
	add	hl, de
	ld	a, (hl)
	add	a, c
00109$:
	ld	c, a
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#8
	add	a, (hl)
;C:/CrossZGB/ZGB/common/include/Scroll.h:162: set_vram_byte(addr, t);
	pop	de
	push	de
	call	_set_vram_byte
;C:/CrossZGB/ZGB/common/include/Scroll.h:164: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00104$
;C:/CrossZGB/ZGB/common/include/Scroll.h:165: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Scroll.h:166: set_vram_byte(addr, c);
	ld	a, c
	pop	de
	push	de
	call	_set_vram_byte
;C:/CrossZGB/ZGB/common/include/Scroll.h:167: VBK_REG = 0;
	ld	a, #0x00
	ldh	(_VBK_REG + 0), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:122: ScrollSetAttrTileAddr(addr, (UINT8)map_offset + data, (attr) ? *attr : (UINT8)(map_offset >> 8) + scroll_tile_info[(UINT8)map_offset + data]);
00104$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:123: }
	add	sp, #3
	pop	hl
	add	sp, #6
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:125: UINT16 LoadMap(UINT8 bg_or_win, UINT8 x, UINT8 y, UINT8 map_bank, struct MapInfo* map) {
;	---------------------------------
; Function LoadMap
; ---------------------------------
_LoadMap::
	add	sp, #-15
	ldhl	sp,	#9
	ld	(hl-), a
	ld	(hl), e
;C:/CrossZGB/ZGB/common/src/Scroll.c:130: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:131: SWITCH_ROM(map_bank);
	ldhl	sp,	#18
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:135: UINT8 load_tiles = (tiles_bank_0 != map->tiles_bank) || (tiles_0 != map->tiles); // If the tile set is the same as the one used for the scroll or the bg (which is stored in tiles_bank_0 and tiles0) then do not load the tiles again
	ldhl	sp,	#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0008
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	hl, #0x0009
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, (#_tiles_bank_0)
	ldhl	sp,	#10
	sub	a, (hl)
	jr	NZ, 00122$
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (#_tiles_0)
	ldhl	sp,	#6
	sub	a, (hl)
	jr	NZ, 00122$
	ld	a, (#_tiles_0 + 1)
	ldhl	sp,	#7
	sub	a, (hl)
	jr	NZ, 00122$
	xor	a, a
	jr	00123$
00122$:
	ld	a, #0x01
00123$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:136: if (load_tiles) {
	or	a, a
	jr	Z, 00107$
;C:/CrossZGB/ZGB/common/src/Scroll.c:137: if (map->extra_tiles) {
	ld	hl, #0x000c
	add	hl, bc
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	or	a, h
	jr	Z, 00104$
;C:/CrossZGB/ZGB/common/src/Scroll.c:138: map_offset = ScrollSetTiles(last_tile_loaded, map->extra_tiles_bank, map->extra_tiles);
	ld	a, c
	add	a, #0x0b
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	push	bc
	push	hl
	ld	e, a
	ld	a, (_last_tile_loaded)
	call	_ScrollSetTiles
	ldhl	sp,	#3
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	bc
;C:/CrossZGB/ZGB/common/src/Scroll.c:139: if (map->tiles) ScrollSetTiles(last_tile_loaded, map->tiles_bank, map->tiles);
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00108$
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	push	bc
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ld	e, a
	ld	a, (_last_tile_loaded)
	call	_ScrollSetTiles
	pop	bc
	jr	00108$
00104$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:141: map_offset = ScrollSetTiles(last_tile_loaded, map->tiles_bank, map->tiles);
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	push	bc
	push	hl
	ldhl	sp,	#14
	ld	e, (hl)
	ld	a, (_last_tile_loaded)
	call	_ScrollSetTiles
	ldhl	sp,	#3
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	pop	bc
	jr	00108$
00107$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:144: map_offset = 0;
	xor	a, a
	ldhl	sp,	#1
	ld	(hl+), a
	ld	(hl), a
00108$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:148: UINT8* data = map->data;
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#13
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:149: UINT8* attrs = map->attributes;
	ld	hl, #0x0006
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#11
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:150: for (UINT8 j = 0; j < map->height; ++j) {
	ld	hl, #0x0002
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#10
	ld	(hl), #0x00
00117$:
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#10
	ld	e, (hl)
	ld	d, #0x00
	ld	a, e
	sub	a, c
	ld	a, d
	sbc	a, b
	jr	NC, 00112$
;C:/CrossZGB/ZGB/common/src/Scroll.c:151: for (UINT8 i = 0; i < map->width; ++i) {
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#10
	add	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ld	c, #0x00
00114$:
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	inc	de
	ld	a, (de)
	ld	l, a
	ld	e, c
	ld	d, #0x00
	ld	a, e
	sub	a, b
	ld	a, d
	sbc	a, l
	jr	NC, 00134$
;C:/CrossZGB/ZGB/common/src/Scroll.c:152: UpdateMapTile(bg_or_win, x + i, y + j, map_offset, *data, attrs);
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#8
	ld	a, (hl)
	add	a, c
	push	bc
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	push	bc
	inc	sp
	ldhl	sp,	#6
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	ldhl	sp,	#14
	ld	h, (hl)
	push	hl
	inc	sp
	ld	e, a
	ldhl	sp,	#17
	ld	a, (hl)
	call	_UpdateMapTile
	pop	bc
;C:/CrossZGB/ZGB/common/src/Scroll.c:154: ++data;
	ldhl	sp,	#13
	inc	(hl)
	jr	NZ, 00200$
	inc	hl
	inc	(hl)
00200$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:155: if (attrs)
	ldhl	sp,	#12
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00115$
;C:/CrossZGB/ZGB/common/src/Scroll.c:156: ++attrs;
	inc	(hl)
	jr	NZ, 00201$
	inc	hl
	inc	(hl)
00201$:
00115$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:151: for (UINT8 i = 0; i < map->width; ++i) {
	inc	c
	jr	00114$
00134$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:150: for (UINT8 j = 0; j < map->height; ++j) {
	ldhl	sp,	#10
	inc	(hl)
	jr	00117$
00112$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:160: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:163: return map_offset;
	ldhl	sp,	#1
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:164: }
	add	sp, #15
	pop	hl
	add	sp, #4
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:168: void ScrollSetMap(UINT8 map_bank, const struct MapInfo* map) {
;	---------------------------------
; Function ScrollSetMap
; ---------------------------------
_ScrollSetMap::
	dec	sp
	dec	sp
	ldhl	sp,	#1
;C:/CrossZGB/ZGB/common/src/Scroll.c:169: UINT8 __save = CURRENT_BANK;
	ld	(hl-), a
	ld	c, e
	ld	b, d
	ldh	a, (__current_bank + 0)
;C:/CrossZGB/ZGB/common/src/Scroll.c:170: SWITCH_ROM(map_bank);
	ld	(hl+), a
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:171: scroll_tiles_w = map->width;
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #_scroll_tiles_w
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:172: scroll_tiles_h = map->height;
	ld	hl, #0x0004
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #_scroll_tiles_h
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:173: scroll_map = map->data;
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #_scroll_map
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:174: scroll_cmap = map->attributes;
	ld	hl, #0x0006
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #_scroll_cmap
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:175: scroll_x = 0;
	xor	a, a
	ld	hl, #_scroll_x
	ld	(hl+), a
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:176: scroll_y = 0;
	xor	a, a
	ld	hl, #_scroll_y
	ld	(hl+), a
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:177: scroll_w = TILE_TO_PX(scroll_tiles_w);
	ld	a, (#_scroll_tiles_w)
	ld	(#_scroll_w),a
	ld	a, (#_scroll_tiles_w + 1)
	ld	(#_scroll_w + 1),a
	ld	a, #0x03
00112$:
	ld	hl, #_scroll_w
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00112$
;C:/CrossZGB/ZGB/common/src/Scroll.c:178: scroll_h = TILE_TO_PX(scroll_tiles_h);
	ld	a, (#_scroll_tiles_h)
	ld	(#_scroll_h),a
	ld	a, (#_scroll_tiles_h + 1)
	ld	(#_scroll_h + 1),a
	ld	a, #0x03
00113$:
	ld	hl, #_scroll_h
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00113$
;C:/CrossZGB/ZGB/common/src/Scroll.c:179: scroll_bank = map_bank;
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(#_scroll_bank),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:180: if (scroll_target) {
	ld	hl, #_scroll_target + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00102$
;C:/CrossZGB/ZGB/common/src/Scroll.c:181: scroll_x = scroll_target->x - (SCREEN_WIDTH >> 1);
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	add	a, #0xb0
	ld	hl, #_scroll_x
	ld	(hl+), a
	ld	a, b
	adc	a, #0xff
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:182: scroll_y = scroll_target->y - scroll_bottom_movement_limit; //Move the camera to its bottom limit
	ld	a, (_scroll_target)
	ld	hl, #_scroll_target + 1
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (_scroll_bottom_movement_limit)
	ld	e, a
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	hl, #_scroll_y
	ld	(hl+), a
	ld	a, b
	sbc	a, d
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:183: ClampScrollLimits();
	call	_ClampScrollLimits
00102$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:185: pending_h_i = 0;
;C:/CrossZGB/ZGB/common/src/Scroll.c:186: pending_w_i = 0;
	xor	a, a
	ld	(#_pending_h_i), a
	ld	(#_pending_w_i),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:187: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:188: }
	inc	sp
	inc	sp
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:190: void ScrollInitTilesFromMap(UINT8 first_tile, UINT8 map_bank, const struct MapInfo* map) {
;	---------------------------------
; Function ScrollInitTilesFromMap
; ---------------------------------
_ScrollInitTilesFromMap::
	dec	sp
	ld	(#_last_tile_loaded),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:192: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:193: SWITCH_ROM(map_bank);
	ld	a, e
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), e
;C:/CrossZGB/ZGB/common/src/Scroll.c:194: if (map->tiles) ScrollSetTiles(0, map->tiles_bank, map->tiles);
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0009
	add	hl, bc
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	or	a, h
	jr	Z, 00102$
	ld	a, c
	add	a, #0x08
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	push	bc
	push	hl
	ld	e, a
	xor	a, a
	call	_ScrollSetTiles
	pop	bc
00102$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:195: if (map->extra_tiles) ScrollSetTiles(last_tile_loaded, map->extra_tiles_bank, map->extra_tiles);
	ld	hl, #0x000c
	add	hl, bc
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	or	a, h
	jr	Z, 00104$
	ld	a, c
	add	a, #0x0b
	ld	c, a
	jr	NC, 00121$
	inc	b
00121$:
	ld	a, (bc)
	push	hl
	ld	e, a
	ld	a, (_last_tile_loaded)
	call	_ScrollSetTiles
00104$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:196: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:197: }
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:200: void ScrollCollisionsReset(void) {
;	---------------------------------
; Function ScrollCollisionsReset
; ---------------------------------
_ScrollCollisionsReset::
;C:/CrossZGB/ZGB/common/src/Scroll.c:201: memset(scroll_collisions, 0, sizeof(scroll_collisions));
	xor	a, a
	inc	a
	push	af
	ld	de, #0x0000
	push	de
	ld	de, #_scroll_collisions
	push	de
	call	_memset
	add	sp, #6
;C:/CrossZGB/ZGB/common/src/Scroll.c:202: }
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:204: void ScrollInitCollisionGroup(UINT8 group, const UINT8* coll_list) {
;	---------------------------------
; Function ScrollInitCollisionGroup
; ---------------------------------
_ScrollInitCollisionGroup::
	ld	c, a
;C:/CrossZGB/ZGB/common/src/Scroll.c:205: for (const UINT8 * ptr = coll_list; (*ptr); ptr++) 
00103$:
	ld	a, (de)
	or	a, a
	ret	Z
;C:/CrossZGB/ZGB/common/src/Scroll.c:206: scroll_collisions[*ptr] |= group;
	add	a, #<(_scroll_collisions)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_scroll_collisions)
	ld	h, a
	ld	a, (hl)
	or	a, c
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:205: for (const UINT8 * ptr = coll_list; (*ptr); ptr++) 
	inc	de
;C:/CrossZGB/ZGB/common/src/Scroll.c:207: }
	jr	00103$
;C:/CrossZGB/ZGB/common/src/Scroll.c:209: void ScrollInitCollisionGroupVector(UINT8 group, const UINT8* coll_vector) {
;	---------------------------------
; Function ScrollInitCollisionGroupVector
; ---------------------------------
_ScrollInitCollisionGroupVector::
	ld	c, a
;C:/CrossZGB/ZGB/common/src/Scroll.c:210: for (UINT8 idx = *coll_vector++; (idx); --idx) scroll_collisions[*coll_vector++] |= group;
	ld	a, (de)
	ld	b, a
	inc	de
00103$:
	ld	a, b
	or	a, a
	ret	Z
	ld	a, (de)
	inc	de
	add	a, #<(_scroll_collisions)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_scroll_collisions)
	ld	h, a
	ld	a, (hl)
	or	a, c
	ld	(hl), a
	dec	b
;C:/CrossZGB/ZGB/common/src/Scroll.c:211: }
	jr	00103$
;C:/CrossZGB/ZGB/common/src/Scroll.c:213: void ScrollRemoveCollisionGroupVector(UINT8 group, const UINT8* coll_vector) {
;	---------------------------------
; Function ScrollRemoveCollisionGroupVector
; ---------------------------------
_ScrollRemoveCollisionGroupVector::
	ld	b, a
;C:/CrossZGB/ZGB/common/src/Scroll.c:214: for (UINT8 idx = *coll_vector++; (idx); --idx) scroll_collisions[*coll_vector++] &= ~group;
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, b
	cpl
	ld	b, a
00103$:
	ld	a, c
	or	a, a
	ret	Z
	ld	a, (de)
	inc	de
	add	a, #<(_scroll_collisions)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_scroll_collisions)
	ld	h, a
	ld	a, (hl)
	and	a, b
	ld	(hl), a
	dec	c
;C:/CrossZGB/ZGB/common/src/Scroll.c:215: }
	jr	00103$
;C:/CrossZGB/ZGB/common/src/Scroll.c:217: void ScrollInitCollisions(const UINT8* coll_list, const UINT8* coll_list_down) {
;	---------------------------------
; Function ScrollInitCollisions
; ---------------------------------
_ScrollInitCollisions::
;C:/CrossZGB/ZGB/common/src/Scroll.c:218: ScrollCollisionsReset();
	push	bc
	push	de
	call	_ScrollCollisionsReset
	pop	de
	pop	bc
;C:/CrossZGB/ZGB/common/src/Scroll.c:219: if (coll_list) {
	ld	a, d
	or	a, e
	jr	Z, 00102$
;C:/CrossZGB/ZGB/common/src/Scroll.c:220: ScrollInitCollisionGroup((COLL_GROUP_DEFAULT | COLL_GROUP_DOWN), coll_list);
	push	bc
	ld	a, #0x81
	call	_ScrollInitCollisionGroup
	pop	bc
00102$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:222: if (coll_list_down) {
	ld	a, b
	or	a, c
	ret	Z
;C:/CrossZGB/ZGB/common/src/Scroll.c:223: ScrollInitCollisionGroup(COLL_GROUP_DOWN, coll_list_down);
	ld	e, c
	ld	d, b
	ld	a, #0x80
;C:/CrossZGB/ZGB/common/src/Scroll.c:225: }
	jp	_ScrollInitCollisionGroup
;C:/CrossZGB/ZGB/common/src/Scroll.c:227: void ScrollScreenRedraw(void) {
;	---------------------------------
; Function ScrollScreenRedraw
; ---------------------------------
_ScrollScreenRedraw::
	add	sp, #-4
;C:/CrossZGB/ZGB/common/src/Scroll.c:228: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:229: SWITCH_ROM(scroll_bank);
	ld	a, (_scroll_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:230: INT16 y = PX_TO_TILE(scroll_y);
	ld	a, (#_scroll_y)
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (#_scroll_y + 1)
	ldhl	sp,	#2
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:231: for (UINT8 i = 0u; i != (SCREEN_TILE_REFRES_H) && y != scroll_h; ++i, y++) {
	inc	hl
	inc	hl
	ld	(hl), #0x00
00104$:
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x15
	jr	Z, 00101$
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_scroll_h
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00131$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00101$
00131$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:232: ScrollUpdateRow(PX_TO_TILE(scroll_x) - SCREEN_PAD_LEFT,  y - SCREEN_PAD_TOP);
	ldhl	sp,#1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	ld	hl, #_scroll_x
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	dec	de
	call	_ScrollUpdateRow
;C:/CrossZGB/ZGB/common/src/Scroll.c:231: for (UINT8 i = 0u; i != (SCREEN_TILE_REFRES_H) && y != scroll_h; ++i, y++) {
	ldhl	sp,	#3
	inc	(hl)
	dec	hl
	dec	hl
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00101$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:234: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:235: }
	add	sp, #4
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:237: void InitScroll(UINT8 map_bank, const struct MapInfo* map, const UINT8* coll_list, const UINT8* coll_list_down) {
;	---------------------------------
; Function InitScroll
; ---------------------------------
_InitScroll::
	ld	c, a
;C:/CrossZGB/ZGB/common/src/Scroll.c:239: ScrollInitTilesFromMap(0, map_bank, map);
	push	bc
	push	de
	push	de
	ld	e, c
	xor	a, a
	call	_ScrollInitTilesFromMap
	pop	de
	pop	bc
;C:/CrossZGB/ZGB/common/src/Scroll.c:242: ScrollSetMap(map_bank, map);
	ld	a, c
	call	_ScrollSetMap
;C:/CrossZGB/ZGB/common/src/Scroll.c:245: ScrollInitCollisions(coll_list, coll_list_down);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_ScrollInitCollisions
;C:/CrossZGB/ZGB/common/src/Scroll.c:248: ScrollScreenRedraw();
	call	_ScrollScreenRedraw
;C:/CrossZGB/ZGB/common/src/Scroll.c:249: }
	pop	hl
	add	sp, #4
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:251: void ScrollUpdateRowR(void) {
;	---------------------------------
; Function ScrollUpdateRowR
; ---------------------------------
_ScrollUpdateRowR::
	dec	sp
;C:/CrossZGB/ZGB/common/src/Scroll.c:252: scroll_ptr = pending_w_map;
	ld	a, (#_pending_w_map)
	ld	(#_scroll_ptr),a
	ld	a, (#_pending_w_map + 1)
	ld	(#_scroll_ptr + 1),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:254: scroll_cptr = pending_w_cmap;
	ld	a, (#_pending_w_cmap)
	ld	(#_scroll_cptr),a
	ld	a, (#_pending_w_cmap + 1)
	ld	(#_scroll_cptr + 1),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:258: for (UINT8 i = MAX(SCREEN_RESTORE_W, pending_w_i); (i); --i) {
	ld	a, (#_pending_w_i)
	sub	a, #0x05
	jr	NC, 00109$
	ld	a, #0x05
	jr	00110$
00109$:
	ld	a, (_pending_w_i)
00110$:
	ldhl	sp,	#0
	ld	(hl), a
00105$:
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00103$
;C:/CrossZGB/ZGB/common/src/Scroll.c:259: UPDATE_TILE(pending_w_x++, pending_w_y);
	ld	a, (_pending_w_x)
	ld	e, a
	ld	hl, #_pending_w_x + 1
	ld	a, (hl-)
	ld	d, a
	inc	(hl)
	jr	NZ, 00140$
	inc	hl
	inc	(hl)
00140$:
	ld	a, (_pending_w_y)
	ld	c, a
	ld	hl, #_pending_w_y + 1
	ld	b, (hl)
	call	_UPDATE_TILE
;C:/CrossZGB/ZGB/common/src/Scroll.c:260: scroll_ptr++;
	ld	hl, #_scroll_ptr
	inc	(hl)
	jr	NZ, 00141$
	inc	hl
	inc	(hl)
00141$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:262: if (scroll_cptr) scroll_cptr++;
	ld	hl, #_scroll_cptr + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00106$
	inc	(hl)
	jr	NZ, 00142$
	inc	hl
	inc	(hl)
00142$:
00106$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:258: for (UINT8 i = MAX(SCREEN_RESTORE_W, pending_w_i); (i); --i) {
	ldhl	sp,	#0
	dec	(hl)
	jr	00105$
00103$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:265: pending_w_i = 0;
	xor	a, a
	ld	(#_pending_w_i),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:266: }
	inc	sp
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:268: void ScrollUpdateRowWithDelay(INT16 x, INT16 y) {
;	---------------------------------
; Function ScrollUpdateRowWithDelay
; ---------------------------------
_ScrollUpdateRowWithDelay::
;C:/CrossZGB/ZGB/common/src/Scroll.c:269: if (pending_w_i) ScrollUpdateRowR();
	ld	a, (#_pending_w_i)
	or	a, a
	jr	Z, 00102$
	push	bc
	push	de
	call	_ScrollUpdateRowR
	pop	de
	pop	bc
00102$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:271: pending_w_i = SCREEN_TILE_REFRES_W;
	ld	hl, #_pending_w_i
	ld	(hl), #0x17
;C:/CrossZGB/ZGB/common/src/Scroll.c:273: UINT16 offset = scroll_tiles_w * (pending_w_y = y) + (pending_w_x = x);
	ld	hl, #_pending_w_y
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	push	de
	ld	a, (_scroll_tiles_w)
	ld	e, a
	ld	hl, #_scroll_tiles_w + 1
	ld	d, (hl)
	call	__mulint
	pop	de
	ld	hl, #_pending_w_x
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	l, e
	ld	h, d
	add	hl, bc
	ld	c, l
	ld	b, h
;C:/CrossZGB/ZGB/common/src/Scroll.c:274: pending_w_map = scroll_map + offset;
	ld	a, (#_scroll_map)
	add	a, c
	ld	(#_pending_w_map),a
	ld	a, (#_scroll_map + 1)
	adc	a, b
	ld	(#_pending_w_map + 1),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:276: pending_w_cmap = (scroll_cmap) ? (scroll_cmap + offset) : NULL;
	ld	hl, #_scroll_cmap + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00105$
	ld	a, c
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
	jr	00106$
00105$:
	ld	bc, #0x0000
00106$:
	ld	hl, #_pending_w_cmap
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/Scroll.c:278: }
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:280: void ScrollUpdateRow(INT16 x, INT16 y) {
;	---------------------------------
; Function ScrollUpdateRow
; ---------------------------------
_ScrollUpdateRow::
	add	sp, #-1
;C:/CrossZGB/ZGB/common/src/Scroll.c:281: UINT16 offset = scroll_tiles_w * y + x;
	push	bc
	push	de
	ld	a, (_scroll_tiles_w)
	ld	e, a
	ld	hl, #_scroll_tiles_w + 1
	ld	d, (hl)
	call	__mulint
	pop	de
	ld	l, e
	ld	h, d
	add	hl, bc
	ld	c, l
	ld	b, h
;C:/CrossZGB/ZGB/common/src/Scroll.c:283: scroll_ptr = scroll_map + offset;
	ld	a, (#_scroll_map)
	add	a, c
	ld	(#_scroll_ptr),a
	ld	a, (#_scroll_map + 1)
	adc	a, b
	ld	(#_scroll_ptr + 1),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:285: scroll_cptr = (scroll_cmap) ? (scroll_cmap + offset) : NULL;
	ld	hl, #_scroll_cmap + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00109$
	ld	a, c
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
	jr	00110$
00109$:
	ld	bc, #0x0000
00110$:
	ld	hl, #_scroll_cptr
	ld	(hl), c
	inc	hl
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/Scroll.c:291: __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	(#_ScrollUpdateRow___save_10001_343),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:292: SWITCH_ROM(scroll_bank);
	ld	a, (_scroll_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:293: for (UINT8 i = SCREEN_TILE_REFRES_W; (i); --i) {
	ldhl	sp,	#2
	ld	(hl), #0x17
00105$:
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00103$
;C:/CrossZGB/ZGB/common/src/Scroll.c:294: UPDATE_TILE(x++, y);
	ld	a, e
	ld	l, d
	inc	de
	push	de
	push	hl
	ldhl	sp,	#4
	ld	c, (hl)
	ldhl	sp,	#5
	ld	b, (hl)
	pop	hl
	ld	e, a
	ld	d, l
	call	_UPDATE_TILE
	pop	de
;C:/CrossZGB/ZGB/common/src/Scroll.c:295: scroll_ptr++;
	ld	hl, #_scroll_ptr
	inc	(hl)
	jr	NZ, 00140$
	inc	hl
	inc	(hl)
00140$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:297: if (scroll_cptr) scroll_cptr++;
	ld	hl, #_scroll_cptr + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00106$
	inc	(hl)
	jr	NZ, 00141$
	inc	hl
	inc	(hl)
00141$:
00106$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:293: for (UINT8 i = SCREEN_TILE_REFRES_W; (i); --i) {
	ldhl	sp,	#2
	dec	(hl)
	jr	00105$
00103$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:300: SWITCH_ROM(__save);
	ld	a, (_ScrollUpdateRow___save_10001_343)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:301: }
	add	sp, #3
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:303: void ScrollUpdateColumnR(void) {
;	---------------------------------
; Function ScrollUpdateColumnR
; ---------------------------------
_ScrollUpdateColumnR::
;C:/CrossZGB/ZGB/common/src/Scroll.c:304: scroll_ptr = pending_h_map;
	ld	a, (#_pending_h_map)
	ld	(#_scroll_ptr),a
	ld	a, (#_pending_h_map + 1)
	ld	(#_scroll_ptr + 1),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:306: scroll_cptr = pending_h_cmap;
	ld	a, (#_pending_h_cmap)
	ld	(#_scroll_cptr),a
	ld	a, (#_pending_h_cmap + 1)
	ld	(#_scroll_cptr + 1),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:310: for (UINT8 i = MAX(SCREEN_RESTORE_H, pending_h_i); (i); --i) {
	ld	a, (#_pending_h_i)
	sub	a, #0x05
	jr	NC, 00109$
	ld	e, #0x05
	jr	00110$
00109$:
	ld	a, (_pending_h_i)
	ld	e, a
00110$:
00105$:
	ld	a, e
	or	a, a
	jr	Z, 00103$
;C:/CrossZGB/ZGB/common/src/Scroll.c:311: UPDATE_TILE(pending_h_x, pending_h_y++);
	ld	a, (_pending_h_y)
	ld	c, a
	ld	hl, #_pending_h_y + 1
	ld	a, (hl-)
	ld	b, a
	inc	(hl)
	jr	NZ, 00140$
	inc	hl
	inc	(hl)
00140$:
	push	de
	ld	a, (_pending_h_x)
	ld	e, a
	ld	hl, #_pending_h_x + 1
	ld	d, (hl)
	call	_UPDATE_TILE
	pop	de
;C:/CrossZGB/ZGB/common/src/Scroll.c:312: scroll_ptr += scroll_tiles_w;
	ld	a, (#_scroll_ptr)
	ld	hl, #_scroll_tiles_w
	add	a, (hl)
	ld	hl, #_scroll_ptr
	ld	(hl+), a
	ld	a, (hl)
	ld	hl, #_scroll_tiles_w + 1
	adc	a, (hl)
	ld	(#_scroll_ptr + 1),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:314: if (scroll_cptr) scroll_cptr += scroll_tiles_w;
	ld	hl, #_scroll_cptr + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00106$
	ld	a, (hl)
	ld	hl, #_scroll_tiles_w
	add	a, (hl)
	ld	hl, #_scroll_cptr
	ld	(hl+), a
	ld	a, (hl)
	ld	hl, #_scroll_tiles_w + 1
	adc	a, (hl)
	ld	(#_scroll_cptr + 1),a
00106$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:310: for (UINT8 i = MAX(SCREEN_RESTORE_H, pending_h_i); (i); --i) {
	dec	e
	jr	00105$
00103$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:317: pending_h_i = 0;
	xor	a, a
	ld	(#_pending_h_i),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:318: }
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:320: void ScrollUpdateColumnWithDelay(INT16 x, INT16 y) {
;	---------------------------------
; Function ScrollUpdateColumnWithDelay
; ---------------------------------
_ScrollUpdateColumnWithDelay::
;C:/CrossZGB/ZGB/common/src/Scroll.c:321: if (pending_h_i) ScrollUpdateColumnR();
	ld	a, (#_pending_h_i)
	or	a, a
	jr	Z, 00102$
	push	bc
	push	de
	call	_ScrollUpdateColumnR
	pop	de
	pop	bc
00102$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:323: pending_h_i = SCREEN_TILE_REFRES_H;
	ld	hl, #_pending_h_i
	ld	(hl), #0x15
;C:/CrossZGB/ZGB/common/src/Scroll.c:325: UINT16 offset = scroll_tiles_w * (pending_h_y = y) + (pending_h_x = x);
	ld	hl, #_pending_h_y
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	push	de
	ld	a, (_scroll_tiles_w)
	ld	e, a
	ld	hl, #_scroll_tiles_w + 1
	ld	d, (hl)
	call	__mulint
	pop	de
	ld	hl, #_pending_h_x
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ld	l, e
	ld	h, d
	add	hl, bc
	ld	c, l
	ld	b, h
;C:/CrossZGB/ZGB/common/src/Scroll.c:326: pending_h_map = scroll_map + offset;
	ld	a, (#_scroll_map)
	add	a, c
	ld	(#_pending_h_map),a
	ld	a, (#_scroll_map + 1)
	adc	a, b
	ld	(#_pending_h_map + 1),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:328: pending_h_cmap = (scroll_cmap) ? (scroll_cmap + offset) : NULL;
	ld	hl, #_scroll_cmap + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00105$
	ld	a, c
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
	jr	00106$
00105$:
	ld	bc, #0x0000
00106$:
	ld	hl, #_pending_h_cmap
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/Scroll.c:330: }
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:332: void ScrollUpdateColumn(INT16 x, INT16 y) {
;	---------------------------------
; Function ScrollUpdateColumn
; ---------------------------------
_ScrollUpdateColumn::
	add	sp, #-5
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/Scroll.c:333: UINT16 offset = scroll_tiles_w * y + x;
	push	bc
	ld	a, (_scroll_tiles_w)
	ld	e, a
	ld	hl, #_scroll_tiles_w + 1
	ld	d, (hl)
	call	__mulint
	pop	de
	ldhl	sp,	#2
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
;C:/CrossZGB/ZGB/common/src/Scroll.c:335: scroll_ptr = scroll_map + offset;
	ld	a, (#_scroll_map)
	add	a, c
	ld	(#_scroll_ptr),a
	ld	a, (#_scroll_map + 1)
	adc	a, b
	ld	(#_scroll_ptr + 1),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:337: scroll_cptr = (scroll_cmap) ? (scroll_cmap + offset) : NULL;
	ld	hl, #_scroll_cmap + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00109$
	ld	a, c
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
	jr	00110$
00109$:
	ld	bc, #0x0000
00110$:
	ld	hl, #_scroll_cptr
	ld	(hl), c
	inc	hl
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/Scroll.c:343: __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	(#_ScrollUpdateColumn___save_10001_358),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:344: SWITCH_ROM(scroll_bank);
	ld	a, (_scroll_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:345: for (UINT8 i = SCREEN_TILE_REFRES_H; (i); --i) {
	ldhl	sp,	#4
	ld	(hl), #0x15
00105$:
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00103$
;C:/CrossZGB/ZGB/common/src/Scroll.c:346: UPDATE_TILE(x, y++);
	dec	hl
	dec	hl
	ld	c, e
	ld	b, d
	inc	de
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_UPDATE_TILE
	pop	de
;C:/CrossZGB/ZGB/common/src/Scroll.c:347: scroll_ptr += scroll_tiles_w;
	ld	a, (#_scroll_ptr)
	ld	hl, #_scroll_tiles_w
	add	a, (hl)
	ld	hl, #_scroll_ptr
	ld	(hl+), a
	ld	a, (hl)
	ld	hl, #_scroll_tiles_w + 1
	adc	a, (hl)
	ld	hl, #_scroll_ptr + 1
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:349: if (scroll_ptr) scroll_ptr += scroll_tiles_w;
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00106$
	ld	a, (hl)
	ld	hl, #_scroll_tiles_w
	add	a, (hl)
	ld	hl, #_scroll_ptr
	ld	(hl+), a
	ld	a, (hl)
	ld	hl, #_scroll_tiles_w + 1
	adc	a, (hl)
	ld	(#_scroll_ptr + 1),a
00106$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:345: for (UINT8 i = SCREEN_TILE_REFRES_H; (i); --i) {
	ldhl	sp,	#4
	dec	(hl)
	jr	00105$
00103$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:352: SWITCH_ROM(__save);
	ld	a, (_ScrollUpdateColumn___save_10001_358)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:353: }
	add	sp, #5
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:355: void RefreshScroll(void) {
;	---------------------------------
; Function RefreshScroll
; ---------------------------------
_RefreshScroll::
	add	sp, #-4
;C:/CrossZGB/ZGB/common/src/Scroll.c:356: if (scroll_target) {
	ld	hl, #_scroll_target + 1
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00108$
;C:/CrossZGB/ZGB/common/src/Scroll.c:357: UINT16 ny = scroll_y;
	ld	a, (#_scroll_y)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_scroll_y + 1)
	ldhl	sp,	#1
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:359: if (scroll_bottom_movement_limit < (scroll_target->y - scroll_y)) ny = scroll_target->y - scroll_bottom_movement_limit;
	ld	a, (_scroll_target)
	ld	hl, #_scroll_target + 1
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	b, a
	ld	c, (hl)
	ld	a, (_scroll_y)
	ld	e, a
	ld	hl, #_scroll_y + 1
	ld	d, (hl)
	ld	a, b
	sub	a, e
	ld	e, a
	ld	a, c
	sbc	a, d
	ld	d, a
	ld	a, (_scroll_bottom_movement_limit)
	ld	l, a
	ld	h, #0x00
	ld	a, l
	sub	a, e
	ld	a, h
	sbc	a, d
	jr	NC, 00104$
	ld	a, (_scroll_bottom_movement_limit)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
	ld	e, b
	ld	d, c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
	jr	00105$
00104$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:360: else if (scroll_top_movement_limit > (scroll_target->y - scroll_y)) ny = scroll_target->y - scroll_top_movement_limit;
	ld	a, (_scroll_top_movement_limit)
	ld	l, a
	ld	h, #0x00
	ld	a, e
	sub	a, l
	ld	a, d
	sbc	a, h
	jr	NC, 00105$
	ld	a, (_scroll_top_movement_limit)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
	ld	e, b
	ld	d, c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
00105$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:362: MoveScroll(scroll_target->x - (SCREEN_WIDTH >> 1), ny);
	ld	hl, #_scroll_target
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	add	a, #0xb0
	ld	e, a
	ld	a, b
	adc	a, #0xff
	pop	bc
	push	bc
	ld	d, a
	call	_MoveScroll
00108$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:364: }
	add	sp, #4
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:366: void MoveScroll(INT16 x, INT16 y) {
;	---------------------------------
; Function MoveScroll
; ---------------------------------
_MoveScroll::
	dec	sp
	dec	sp
;C:/CrossZGB/ZGB/common/src/Scroll.c:370: __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	(#_MoveScroll___save_10000_369),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:371: SWITCH_ROM(scroll_bank);
	ld	a, (_scroll_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:373: current_column = PX_TO_TILE(scroll_x);
	ld	a, (#_scroll_x)
	ld	(#_MoveScroll_current_column_10000_369),a
	ld	a, (#_scroll_x + 1)
	ld	hl, #_MoveScroll_current_column_10000_369 + 1
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:374: current_row    = PX_TO_TILE(scroll_y);
	ld	a, (#_scroll_y)
	ld	(#_MoveScroll_current_row_10000_369),a
	ld	a, (#_scroll_y + 1)
	ld	hl, #_MoveScroll_current_row_10000_369 + 1
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:376: scroll_x = x;
	ld	hl, #_scroll_x
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/Scroll.c:377: scroll_y = y;
	ld	hl, #_scroll_y
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/Scroll.c:378: ClampScrollLimits();
	call	_ClampScrollLimits
;C:/CrossZGB/ZGB/common/src/Scroll.c:380: new_column     = PX_TO_TILE(scroll_x);
	ld	a, (#_scroll_x)
	ld	(#_MoveScroll_new_column_10000_369),a
	ld	a, (#_scroll_x + 1)
	ld	hl, #_MoveScroll_new_column_10000_369 + 1
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:381: new_row        = PX_TO_TILE(scroll_y);
	ld	a, (#_scroll_y)
	ld	(#_MoveScroll_new_row_10000_369),a
	ld	a, (#_scroll_y + 1)
	ld	hl, #_MoveScroll_new_row_10000_369 + 1
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
;C:/CrossZGB/ZGB/common/src/Scroll.c:383: if (current_column != new_column) {
	ld	a, (#_MoveScroll_current_column_10000_369)
	ld	hl, #_MoveScroll_new_column_10000_369
	sub	a, (hl)
	jr	NZ, 00168$
	ld	a, (#_MoveScroll_current_column_10000_369 + 1)
	ld	hl, #_MoveScroll_new_column_10000_369 + 1
	sub	a, (hl)
	jr	Z, 00105$
00168$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:385: ScrollUpdateColumnWithDelay(new_column - SCREEN_PAD_LEFT + SCREEN_TILE_REFRES_W - 1, new_row - SCREEN_PAD_TOP);
	ld	hl, #_MoveScroll_new_row_10000_369
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
;C:/CrossZGB/ZGB/common/src/Scroll.c:384: if (new_column > current_column) {
	ld	de, #_MoveScroll_current_column_10000_369
	ld	hl, #_MoveScroll_new_column_10000_369
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
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
	jr	NC, 00102$
;C:/CrossZGB/ZGB/common/src/Scroll.c:385: ScrollUpdateColumnWithDelay(new_column - SCREEN_PAD_LEFT + SCREEN_TILE_REFRES_W - 1, new_row - SCREEN_PAD_TOP);
	ld	hl, #_MoveScroll_new_column_10000_369
	ld	a, (hl+)
	add	a, #0x15
	ld	e, a
	ld	a, (hl)
	adc	a, #0x00
	ld	d, a
	call	_ScrollUpdateColumnWithDelay
	jr	00105$
00102$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:387: ScrollUpdateColumnWithDelay(new_column - SCREEN_PAD_LEFT,                            new_row - SCREEN_PAD_TOP);
	ld	hl, #_MoveScroll_new_column_10000_369
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	dec	de
	call	_ScrollUpdateColumnWithDelay
00105$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:391: if (current_row != new_row) {
	ld	a, (#_MoveScroll_current_row_10000_369)
	ld	hl, #_MoveScroll_new_row_10000_369
	sub	a, (hl)
	jr	NZ, 00171$
	ld	a, (#_MoveScroll_current_row_10000_369 + 1)
	ld	hl, #_MoveScroll_new_row_10000_369 + 1
	sub	a, (hl)
	jr	Z, 00112$
00171$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:387: ScrollUpdateColumnWithDelay(new_column - SCREEN_PAD_LEFT,                            new_row - SCREEN_PAD_TOP);
	ld	hl, #_MoveScroll_new_column_10000_369
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
;C:/CrossZGB/ZGB/common/src/Scroll.c:392: if (new_row > current_row) {
	ld	de, #_MoveScroll_current_row_10000_369
	ld	hl, #_MoveScroll_new_row_10000_369
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00172$
	bit	7, d
	jr	NZ, 00173$
	cp	a, a
	jr	00173$
00172$:
	bit	7, d
	jr	Z, 00173$
	scf
00173$:
	jr	NC, 00109$
;C:/CrossZGB/ZGB/common/src/Scroll.c:393: ScrollUpdateRowWithDelay(new_column - SCREEN_PAD_LEFT, new_row - SCREEN_PAD_TOP + SCREEN_TILE_REFRES_H - 1);
	ld	hl, #_MoveScroll_new_row_10000_369
	ld	a, (hl+)
	add	a, #0x13
	ld	c, a
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
	pop	de
	push	de
	call	_ScrollUpdateRowWithDelay
	jr	00112$
00109$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:394: } else if (new_row >= SCREEN_PAD_TOP) {
	ld	hl, #_MoveScroll_new_row_10000_369
	ld	a, (hl+)
	sub	a, #0x01
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	ld	e, a
	bit	7, e
	jr	Z, 00174$
	bit	7, d
	jr	NZ, 00175$
	cp	a, a
	jr	00175$
00174$:
	bit	7, d
	jr	Z, 00175$
	scf
00175$:
	jr	C, 00112$
;C:/CrossZGB/ZGB/common/src/Scroll.c:395: ScrollUpdateRowWithDelay(new_column - SCREEN_PAD_LEFT, new_row - SCREEN_PAD_TOP);
	ld	hl, #_MoveScroll_new_row_10000_369
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	pop	de
	push	de
	call	_ScrollUpdateRowWithDelay
00112$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:399: if (pending_w_i) {
	ld	a, (#_pending_w_i)
	or	a, a
	jr	Z, 00114$
;C:/CrossZGB/ZGB/common/src/Scroll.c:400: ScrollUpdateRowR();
	call	_ScrollUpdateRowR
00114$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:402: if (pending_h_i) {
	ld	a, (#_pending_h_i)
	or	a, a
	jr	Z, 00116$
;C:/CrossZGB/ZGB/common/src/Scroll.c:403: ScrollUpdateColumnR();
	call	_ScrollUpdateColumnR
00116$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:405: SWITCH_ROM(__save);
	ld	a, (_MoveScroll___save_10000_369)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:406: }
	inc	sp
	inc	sp
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:408: UINT8 GetScrollTile(UINT16 x, UINT16 y) {
;	---------------------------------
; Function GetScrollTile
; ---------------------------------
_GetScrollTile::
	ld	l, b
;C:/CrossZGB/ZGB/common/src/Scroll.c:410: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	b, a
;C:/CrossZGB/ZGB/common/src/Scroll.c:411: SWITCH_ROM(scroll_bank);
	ld	a, (_scroll_bank)
	ldh	(__current_bank + 0), a
	ld	(_rROMB0), a
;C:/CrossZGB/ZGB/common/include/Scroll.h:151: return scroll_map + (scroll_tiles_w * y + x);
	push	bc
	push	de
	ld	b, l
	ld	a, (_scroll_tiles_w)
	ld	e, a
	ld	hl, #_scroll_tiles_w + 1
	ld	d, (hl)
	call	__mulint
	ld	l, c
	ld	h, b
	pop	de
	pop	bc
	add	hl, de
	ld	a, l
	ld	d, h
	ld	hl, #_scroll_map
	add	a, (hl)
	inc	hl
	ld	e, a
	ld	a, d
	adc	a, (hl)
	ld	d, a
;C:/CrossZGB/ZGB/common/src/Scroll.c:412: ret = *GetScrollTilePtr(x, y);
	ld	a, (de)
	ld	c, a
;C:/CrossZGB/ZGB/common/src/Scroll.c:413: SWITCH_ROM(__save);
	ld	a, b
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/Scroll.c:414: return ret;
	ld	a, c
;C:/CrossZGB/ZGB/common/src/Scroll.c:415: }
	ret
;C:/CrossZGB/ZGB/common/src/Scroll.c:417: void GetMapSize(UINT8 map_bank, const struct MapInfo* map, UINT16* tiles_w, UINT16* tiles_h) {
;	---------------------------------
; Function GetMapSize
; ---------------------------------
_GetMapSize::
	add	sp, #-5
	ld	c, a
	ldhl	sp,	#3
	ld	(hl), e
	inc	hl
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/Scroll.c:418: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Scroll.c:419: SWITCH_ROM(map_bank);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;C:/CrossZGB/ZGB/common/src/Scroll.c:420: if (tiles_w) *tiles_w = map->width;
	ldhl	sp,	#8
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00102$
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a,	(hl+)
	ld	h, (hl)
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
00102$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:421: if (tiles_h) *tiles_h = map->height;
	ldhl	sp,	#10
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00104$
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00104$:
;C:/CrossZGB/ZGB/common/src/Scroll.c:422: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Scroll.c:423: }
	add	sp, #5
	pop	hl
	add	sp, #4
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
__xinit__scroll_top_movement_limit:
	.db #0x1e	; 30
__xinit__scroll_bottom_movement_limit:
	.db #0x64	; 100	'd'
__xinit__scroll_map:
	.dw #0x0000
__xinit__scroll_cmap:
	.dw #0x0000
__xinit__scroll_x:
	.dw #0x0000
__xinit__scroll_y:
	.dw #0x0000
__xinit__scroll_x_vblank:
	.dw #0x0000
__xinit__scroll_y_vblank:
	.dw #0x0000
__xinit__scroll_target:
	.dw #0x0000
__xinit__scroll_offset_x:
	.db #0x00	; 0
__xinit__scroll_offset_y:
	.db #0x00	; 0
__xinit__scroll_h_border:
	.dw #0x0000
__xinit__clamp_enabled:
	.db #0x01	; 1
__xinit__pending_h_map:
	.dw #0x0000
__xinit__pending_w_map:
	.dw #0x0000
__xinit__pending_h_cmap:
	.dw #0x0000
__xinit__pending_w_cmap:
	.dw #0x0000
__xinit__last_tile_loaded:
	.db #0x00	; 0
	.area _CABS (ABS)
