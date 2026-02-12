;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module MapManager
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _copy_level_desc_stage
	.globl _copy_level_desc_scroll
	.globl _copy_level_buffers
	.globl _GetTileReplacement
	.globl _SpriteManagerAdd
	.globl _UpdateMapTile
	.globl _InitScroll
	.globl _memcpy
	.globl _set_bkg_tile_xy
	.globl _set_vram_byte
	.globl _ram_scroll_cptr
	.globl _ram_scroll_ptr
	.globl _dynamic_map_active
	.globl _replace_ram
	.globl _replace_ptr
	.globl _current_size_b
	.globl _current_size_a
	.globl _current_level_size
	.globl _current_level
	.globl _current_level_bank
	.globl _current_level_desc
	.globl _levels
	.globl _memcpy_banked
	.globl _RevertSRAM
	.globl _RestoreDefaultScroll
	.globl _UPDATE_TILE
	.globl _InitDynaStage
	.globl _InitDynaScroll
	.globl _CollideDynaTile
	.globl _ReplaceDynaTile
	.globl _UpdateDynaTile
	.globl _DynaTileAt
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_current_level_desc::
	.ds 14
_current_level_bank::
	.ds 1
_current_level::
	.ds 1
_current_level_size::
	.ds 2
_current_size_a::
	.ds 2
_current_size_b::
	.ds 2
_replace_ptr::
	.ds 2
_replace_ram::
	.ds 1
_dynamic_map_active::
	.ds 1
__save:
	.ds 1
_ram_scroll_ptr::
	.ds 2
_ram_scroll_cptr::
	.ds 2
_UPDATE_TILE_replacement_10000_284:
	.ds 1
_UPDATE_TILE_type_30000_292:
	.ds 1
_UPDATE_TILE_i_50000_297:
	.ds 1
_UPDATE_TILE_id_50000_297:
	.ds 2
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
;MapManager.c:33: void * memcpy_banked(void *dest, const void *src, size_t len, uint8_t bank) NONBANKED {
;	---------------------------------
; Function memcpy_banked
; ---------------------------------
_memcpy_banked::
;MapManager.c:34: _save = _current_bank;
	ldh	a, (__current_bank + 0)
	ld	(#__save),a
;MapManager.c:35: SWITCH_ROM(bank);
	ldhl	sp,	#4
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;MapManager.c:36: void * res = memcpy(dest, src, len);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_memcpy
;MapManager.c:37: SWITCH_ROM(_save);
	ld	a, (__save)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;MapManager.c:38: return res;
;MapManager.c:39: }
	pop	hl
	add	sp, #3
	jp	(hl)
_levels:
	.byte ___bank_medamayaki
	.dw _medamayaki
;MapManager.c:59: void UPDATE_TILE(INT16 x, INT16 y) NONBANKED {
;	---------------------------------
; Function UPDATE_TILE
; ---------------------------------
_UPDATE_TILE::
	add	sp, #-6
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;MapManager.c:65: ram_scroll_ptr  = scroll_ptr;
	ld	a, (#_scroll_ptr)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_scroll_ptr + 1)
	ldhl	sp,	#1
	ld	(hl), a
;MapManager.c:63: if (dynamic_map_active) {
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00105$
;MapManager.c:65: ram_scroll_ptr  = scroll_ptr;
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(#_ram_scroll_ptr),a
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(#_ram_scroll_ptr + 1),a
;MapManager.c:66: ram_scroll_cptr = scroll_cptr;
	ld	a, (#_scroll_cptr)
	ld	(#_ram_scroll_cptr),a
	ld	a, (#_scroll_cptr + 1)
	ld	(#_ram_scroll_cptr + 1),a
;MapManager.c:68: ENABLE_RAM;
	ld	hl, #_rRAMG
	ld	(hl), #0x0a
;MapManager.c:71: if ((ram_scroll_ptr - scroll_map) >= BUFFER_SIZE) {
	ld	a, (#_ram_scroll_ptr)
	ld	hl, #_scroll_map
	sub	a, (hl)
	ld	a, (#_ram_scroll_ptr + 1)
	ld	hl, #_scroll_map + 1
	sbc	a, (hl)
	xor	a, #0x80
	sub	a, #0xa0
	jr	C, 00102$
;MapManager.c:72: ram_scroll_ptr  -= BUFFER_SIZE;
	ld	hl, #_ram_scroll_ptr
	ld	a, (hl)
	ld	(hl+),a
	ld	a,(hl)
	add	a,#0xe0
	ld	(hl), a
;MapManager.c:73: ram_scroll_cptr -= BUFFER_SIZE;
	ld	hl, #_ram_scroll_cptr
	ld	a, (hl)
	ld	(hl+),a
	ld	a,(hl)
	add	a,#0xe0
	ld	(hl), a
;MapManager.c:74: SWITCH_RAM(RAM_DATA_B);
	ld	hl, #_rRAMB
	ld	(hl), #0x02
	jr	00105$
00102$:
;MapManager.c:76: SWITCH_RAM(RAM_DATA_A);
	ld	hl, #_rRAMB
	ld	(hl), #0x01
00105$:
;MapManager.c:81: if(((UINT16)x >= scroll_tiles_w) || ((UINT16)y >= scroll_tiles_h)) { //This also checks x < 0 || y < 0
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_scroll_tiles_w
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00117$
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_scroll_tiles_h
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00118$
00117$:
;MapManager.c:82: replacement = 0;
	xor	a, a
	ld	(#_UPDATE_TILE_replacement_10000_284),a
	jp	00119$
00118$:
;MapManager.c:87: if (dynamic_map_active) {
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00107$
;MapManager.c:88: replacement = *ram_scroll_ptr;
	ld	a, (_ram_scroll_ptr)
	ld	hl, #_ram_scroll_ptr + 1
	ld	h, (hl)
	ld	l, a
	ld	a, (hl)
	ld	(#_UPDATE_TILE_replacement_10000_284),a
;MapManager.c:89: type = GetTileReplacement(ram_scroll_ptr, &replacement);
	ld	bc, #_UPDATE_TILE_replacement_10000_284
	ld	a, (_ram_scroll_ptr)
	ld	e, a
	ld	hl, #_ram_scroll_ptr + 1
	ld	d, (hl)
	call	_GetTileReplacement
	ld	(#_UPDATE_TILE_type_30000_292),a
	jr	00108$
00107$:
;MapManager.c:91: replacement = *scroll_ptr;
	pop	de
	push	de
	ld	a, (de)
	ld	(#_UPDATE_TILE_replacement_10000_284),a
;MapManager.c:92: type = GetTileReplacement(scroll_ptr, &replacement);
	ld	bc, #_UPDATE_TILE_replacement_10000_284
	ld	a, (_scroll_ptr)
	ld	e, a
	ld	hl, #_scroll_ptr + 1
	ld	d, (hl)
	call	_GetTileReplacement
	ld	(#_UPDATE_TILE_type_30000_292),a
00108$:
;MapManager.c:96: if(type != 255u) {
	ld	a, (#_UPDATE_TILE_type_30000_292)
	inc	a
	jp	Z, 00119$
;MapManager.c:99: id = SPRITE_UNIQUE_ID(x, y);
	ldhl	sp,	#4
	ld	a, (hl-)
	dec	hl
	ld	c, #0x00
	ld	b, (hl)
	ld	e, #0x00
	ld	(_UPDATE_TILE_id_50000_297), a
	ld	a, b
	ld	(_UPDATE_TILE_id_50000_297 + 1), a
;MapManager.c:100: for (i = VECTOR_LEN(sprite_manager_updatables); (i); i--) {
	ld	a, (#_sprite_manager_updatables + 0)
	ld	(#_UPDATE_TILE_i_50000_297),a
00132$:
	ld	hl, #_UPDATE_TILE_i_50000_297
	ld	a, (hl)
	or	a, a
	jr	Z, 00112$
;MapManager.c:101: Sprite* s = sprite_manager_sprites[sprite_manager_updatables[i]];
	ld	a, #<(_sprite_manager_updatables)
	add	a, (hl)
	ld	c, a
	ld	a, #>(_sprite_manager_updatables)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	l, a
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_sprite_manager_sprites
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;MapManager.c:102: if ((s->type == type) && (s->unique_id == id)) {
	ld	hl, #0x001d
	add	hl, bc
	ld	a, (hl)
	ld	hl, #_UPDATE_TILE_type_30000_292
	sub	a, (hl)
	jr	NZ, 00133$
	ld	hl, #0x001f
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #_UPDATE_TILE_id_50000_297
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00241$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00112$
00241$:
;MapManager.c:103: break;
00133$:
;MapManager.c:100: for (i = VECTOR_LEN(sprite_manager_updatables); (i); i--) {
	ld	hl, #_UPDATE_TILE_i_50000_297
	dec	(hl)
	jr	00132$
00112$:
;MapManager.c:106: if (i == 0) {
	ld	a, (#_UPDATE_TILE_i_50000_297)
	or	a, a
	jr	NZ, 00119$
;MapManager.c:107: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#1
	ld	(hl), a
;MapManager.c:108: SWITCH_ROM(spriteDataBanks[type]);
	ld	a, #<(_spriteDataBanks)
	ld	hl, #_UPDATE_TILE_type_30000_292
	add	a, (hl)
	ld	c, a
	ld	a, #>(_spriteDataBanks)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;MapManager.c:109: UINT16 sprite_y = TILE_TO_PX(y + 1) - spriteDatas[type]->height;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	a, (_UPDATE_TILE_type_30000_292)
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
;MapManager.c:110: SWITCH_ROM(__save);
	ldhl	sp,	#1
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;MapManager.c:111: SpriteManagerAdd(type, TILE_TO_PX(x), sprite_y);
	ldhl	sp,	#4
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
	ld	a, (_UPDATE_TILE_type_30000_292)
	call	_SpriteManagerAdd
00119$:
;MapManager.c:118: ScrollSetAttrTileXY(SCREEN_BKG_OFFSET_X + x + scroll_offset_x, y + scroll_offset_y, replacement, ((ram_scroll_cptr) ? *ram_scroll_cptr : scroll_tile_info[replacement]));
	ld	a, (_UPDATE_TILE_replacement_10000_284)
	ld	d, a
	ldhl	sp,	#2
	ld	a, (hl+)
	inc	hl
	ld	c, a
	ld	a, (_scroll_offset_y)
	ld	b, (hl)
	ld	hl, #_scroll_offset_x
	ld	l, (hl)
	add	a, c
	ld	e, a
	ld	a, l
	add	a, b
	ldhl	sp,	#1
	ld	(hl), a
;MapManager.c:117: if (dynamic_map_active) {
	ld	a, (#_dynamic_map_active)
	or	a, a
	jr	Z, 00122$
;MapManager.c:118: ScrollSetAttrTileXY(SCREEN_BKG_OFFSET_X + x + scroll_offset_x, y + scroll_offset_y, replacement, ((ram_scroll_cptr) ? *ram_scroll_cptr : scroll_tile_info[replacement]));
	ld	hl, #_ram_scroll_cptr + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00136$
	ld	l, (hl)
	ld	a, (_ram_scroll_cptr + 1)
	ld	h, a
	ld	c, (hl)
	jr	00137$
00136$:
	ld	a, #<(_scroll_tile_info)
	ld	hl, #_UPDATE_TILE_replacement_10000_284
	add	a, (hl)
	ld	c, a
	ld	a, #>(_scroll_tile_info)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
00137$:
	ldhl	sp,	#1
	ld	a, (hl)
;C:/CrossZGB/ZGB/common/include/Scroll.h:178: UINT8* addr = set_bkg_tile_xy(x, y, t);
	push	bc
	push	de
	inc	sp
	call	_set_bkg_tile_xy
	ld	e, c
	ld	d, b
	pop	bc
;C:/CrossZGB/ZGB/common/include/Scroll.h:180: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00126$
;C:/CrossZGB/ZGB/common/include/Scroll.h:181: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Scroll.h:182: set_vram_byte(addr, c);
	ld	a, c
	call	_set_vram_byte
;C:/CrossZGB/ZGB/common/include/Scroll.h:183: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;MapManager.c:118: ScrollSetAttrTileXY(SCREEN_BKG_OFFSET_X + x + scroll_offset_x, y + scroll_offset_y, replacement, ((ram_scroll_cptr) ? *ram_scroll_cptr : scroll_tile_info[replacement]));
00126$:
;MapManager.c:42: SWITCH_RAM(RAM_DEFAULT);
;MapManager.c:43: DISABLE_RAM;
	xor	a, a
	ld	(#_rRAMB), a
	ld	(#_rRAMG),a
;MapManager.c:119: RevertSRAM();
	jr	00134$
00122$:
;MapManager.c:121: ScrollSetAttrTileXY(SCREEN_BKG_OFFSET_X + x + scroll_offset_x, y + scroll_offset_y, replacement, ((scroll_cptr) ? *scroll_cptr : scroll_tile_info[replacement]));
	ld	hl, #_scroll_cptr + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00138$
	ld	l, (hl)
	ld	a, (_scroll_cptr + 1)
	ld	h, a
	ld	c, (hl)
	jr	00139$
00138$:
	ld	a, #<(_scroll_tile_info)
	ld	hl, #_UPDATE_TILE_replacement_10000_284
	add	a, (hl)
	ld	c, a
	ld	a, #>(_scroll_tile_info)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	c, a
00139$:
	ldhl	sp,	#1
	ld	a, (hl)
;C:/CrossZGB/ZGB/common/include/Scroll.h:178: UINT8* addr = set_bkg_tile_xy(x, y, t);
	push	bc
	push	de
	inc	sp
	call	_set_bkg_tile_xy
	ld	e, c
	ld	d, b
	pop	bc
;C:/CrossZGB/ZGB/common/include/Scroll.h:180: if (_cpu == CGB_TYPE) {
	ld	a, (#__cpu)
	sub	a, #0x11
	jr	NZ, 00134$
;C:/CrossZGB/ZGB/common/include/Scroll.h:181: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Scroll.h:182: set_vram_byte(addr, c);
	ld	a, c
	call	_set_vram_byte
;C:/CrossZGB/ZGB/common/include/Scroll.h:183: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;MapManager.c:121: ScrollSetAttrTileXY(SCREEN_BKG_OFFSET_X + x + scroll_offset_x, y + scroll_offset_y, replacement, ((scroll_cptr) ? *scroll_cptr : scroll_tile_info[replacement]));
00134$:
;MapManager.c:125: }
	add	sp, #6
	ret
;MapManager.c:127: void copy_level_buffers(void) NONBANKED {
;	---------------------------------
; Function copy_level_buffers
; ---------------------------------
_copy_level_buffers::
	dec	sp
	dec	sp
;MapManager.c:131: current_level_size = (current_level_desc.width * current_level_desc.height);
	ld	de, #(_current_level_desc + 2)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #_current_level_desc + 4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	__mulint
	ld	hl, #_current_level_size
	ld	a, c
	ld	(hl+), a
;MapManager.c:133: current_size_a = MIN(current_level_size, BUFFER_SIZE);
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x00
	ld	a, (hl)
	sbc	a, #0x20
	jr	NC, 00106$
	dec	hl
	ld	a, (hl+)
	ld	c, (hl)
	jr	00107$
00106$:
	xor	a, a
	ld	c, #0x20
00107$:
	ld	hl, #_current_size_a
	ld	(hl+), a
	ld	(hl), c
;MapManager.c:135: current_size_b = (current_level_size > BUFFER_SIZE) ? current_level_size - BUFFER_SIZE : 0;
	ld	hl, #_current_level_size
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x20
	sbc	a, (hl)
	jr	NC, 00108$
	ld	hl, #_current_level_size
	ld	a, (hl+)
	ld	c,a
	ld	a,(hl)
	add	a,#0xe0
	ld	b, a
	jr	00109$
00108$:
	ld	bc, #0x0000
00109$:
	ld	hl, #_current_size_b
	ld	a, c
;MapManager.c:141: memcpy_banked(buffer_data_b, current_level_desc.data + BUFFER_SIZE, current_size_b, current_level_bank);
;MapManager.c:139: if (current_size_b) {
	ld	(hl+), a
	ld	(hl), b
	or	a, b
	jr	Z, 00102$
;MapManager.c:140: SWITCH_RAM(RAM_DATA_B);
	ld	hl, #_rRAMB
	ld	(hl), #0x02
;MapManager.c:141: memcpy_banked(buffer_data_b, current_level_desc.data + BUFFER_SIZE, current_size_b, current_level_bank);
	ld	hl, #_current_level_desc
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	add	a, #0x20
	ld	b, a
	ld	a, (_current_level_bank)
	push	af
	inc	sp
	ld	a, (_current_size_b)
	ld	e, a
	ld	hl, #_current_size_b + 1
	ld	d, (hl)
	push	de
	ld	de, #_buffer_data_b
	call	_memcpy_banked
00102$:
;MapManager.c:144: SWITCH_RAM(RAM_DATA_A);
	ld	hl, #_rRAMB
	ld	(hl), #0x01
;MapManager.c:145: memcpy_banked(buffer_data_a, current_level_desc.data, current_size_a, current_level_bank);
	ld	hl, #_current_level_desc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (_current_level_bank)
	push	af
	inc	sp
	ld	a, (_current_size_a)
	ld	e, a
	ld	hl, #_current_size_a + 1
	ld	d, (hl)
	push	de
	ld	de, #_buffer_data_a
	call	_memcpy_banked
;MapManager.c:146: current_level_desc.data = buffer_data_a;
	ld	hl, #_current_level_desc
	ld	(hl), #<(_buffer_data_a)
	inc	hl
	ld	(hl), #>(_buffer_data_a)
;MapManager.c:42: SWITCH_RAM(RAM_DEFAULT);
;MapManager.c:43: DISABLE_RAM;
	xor	a, a
	ld	(#_rRAMB), a
	ld	(#_rRAMG),a
;MapManager.c:149: RevertSRAM();
;MapManager.c:151: }
	inc	sp
	inc	sp
	ret
;MapManager.c:153: void copy_level_desc_scroll(UINT8 map_bank, const struct MapInfo* map) NONBANKED {
;	---------------------------------
; Function copy_level_desc_scroll
; ---------------------------------
_copy_level_desc_scroll::
	push	de
;MapManager.c:157: ENABLE_RAM;
	ld	hl, #_rRAMG
	ld	(hl), #0x0a
;MapManager.c:158: SWITCH_RAM(RAM_DEFAULT);
	ld	hl, #_rRAMB
	ld	(hl), #0x00
;MapManager.c:160: current_level_bank = map_bank;
	ld	(#_current_level_bank),a
;MapManager.c:162: memcpy_banked(&current_level_desc, &map, sizeof(current_level_desc), current_level_bank);
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	a, (_current_level_bank)
	push	af
	inc	sp
	ld	de, #0x000e
	push	de
	ld	de, #_current_level_desc
	call	_memcpy_banked
;MapManager.c:164: copy_level_buffers();
;MapManager.c:166: }
	call	_copy_level_buffers
	pop	hl
	ret
;MapManager.c:168: void copy_level_desc_stage(void) NONBANKED {
;	---------------------------------
; Function copy_level_desc_stage
; ---------------------------------
_copy_level_desc_stage::
;MapManager.c:172: ENABLE_RAM;
	ld	hl, #_rRAMG
	ld	(hl), #0x0a
;MapManager.c:173: SWITCH_RAM(RAM_DEFAULT);
	xor	a, a
	ld	(#_rRAMB),a
;MapManager.c:175: current_level_bank = levels[savegame.buffer_level].bank;
	ld	bc, #_levels+0
	ld	a, (#(_savegame + 11) + 0)
	ld	e, a
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, bc
	ld	a, (hl)
	ld	(#_current_level_bank),a
;MapManager.c:177: memcpy_banked(&current_level_desc, levels[savegame.buffer_level].map, sizeof(current_level_desc), current_level_bank);
	ld	a, (#(_savegame + 11) + 0)
	ld	e, a
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, bc
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (_current_level_bank)
	push	af
	inc	sp
	ld	de, #0x000e
	push	de
	ld	de, #_current_level_desc
	call	_memcpy_banked
;MapManager.c:179: copy_level_buffers();
;MapManager.c:181: }
	jp	_copy_level_buffers
;MapManager.c:183: void InitDynaStage(UINT8 level) NONBANKED {
;	---------------------------------
; Function InitDynaStage
; ---------------------------------
_InitDynaStage::
	ld	c, a
;MapManager.c:184: dynamic_map_active = TRUE;
	ld	hl, #_dynamic_map_active
	ld	(hl), #0x01
;MapManager.c:185: ENABLE_RAM;
	ld	hl, #_rRAMG
	ld	(hl), #0x0a
;MapManager.c:186: SWITCH_RAM(RAM_DEFAULT);
	xor	a, a
	ld	(#_rRAMB),a
;MapManager.c:187: savegame.buffer_level = level;
	ld	hl, #(_savegame + 11)
	ld	(hl), c
;MapManager.c:188: copy_level_desc_stage();
	call	_copy_level_desc_stage
;MapManager.c:189: InitScroll(current_level_bank, &current_level_desc, 0, NULL);
	ld	de, #0x0000
	push	de
	push	de
	ld	de, #_current_level_desc
	ld	a, (_current_level_bank)
	call	_InitScroll
;MapManager.c:190: }
	ret
;MapManager.c:192: void InitDynaScroll(UINT8 map_bank, const struct MapInfo* map, const UINT8* coll_list, const UINT8* coll_list_down) NONBANKED {
;	---------------------------------
; Function InitDynaScroll
; ---------------------------------
_InitDynaScroll::
;MapManager.c:193: dynamic_map_active = TRUE;
	ld	hl, #_dynamic_map_active
	ld	(hl), #0x01
;MapManager.c:194: copy_level_desc_scroll(map_bank, map);
	call	_copy_level_desc_scroll
;MapManager.c:195: InitScroll(current_level_bank, &current_level_desc, coll_list, coll_list_down);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #_current_level_desc
	ld	a, (_current_level_bank)
	call	_InitScroll
;MapManager.c:196: }
	pop	hl
	add	sp, #4
	jp	(hl)
;MapManager.c:213: void CollideDynaTile(UINT16 tileX, UINT16 tileY, UINT8 tileNew, UINT8 collisionOperation, UINT8 collisionCompare) NONBANKED {
;	---------------------------------
; Function CollideDynaTile
; ---------------------------------
_CollideDynaTile::
	add	sp, #-3
	ldhl	sp,	#1
	ld	a, c
	ld	(hl+), a
;MapManager.c:214: CalculateOffset(tileX, tileY);
	ld	a, b
	ld	(hl-), a
	push	de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_CalculateOffset
	pop	de
;MapManager.c:215: UINT8 ok = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
;MapManager.c:216: if ((collisionOperation == EQUALS) && (scroll_collisions[*replace_ptr] == collisionCompare)) {
	ld	a, (_replace_ptr)
	ld	c, a
	ld	hl, #_replace_ptr + 1
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl)
	dec	a
	jr	NZ, 00105$
	ld	a, (bc)
	add	a, #<(_scroll_collisions)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_scroll_collisions)
	ld	h, a
	ld	a, (hl)
	ldhl	sp,	#7
	sub	a, (hl)
	jr	NZ, 00105$
;MapManager.c:217: ok = 1;
	ldhl	sp,	#0
	ld	(hl), #0x01
	jr	00106$
00105$:
;MapManager.c:218: } else if ((collisionOperation == AND) && (scroll_collisions[*replace_ptr] & collisionCompare)) {
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	NZ, 00106$
	ld	a, (bc)
	add	a, #<(_scroll_collisions)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_scroll_collisions)
	ld	h, a
	ld	a, (hl)
	ldhl	sp,	#7
	and	a, (hl)
	jr	Z, 00106$
;MapManager.c:219: ok = 1;
	ldhl	sp,	#0
	ld	(hl), #0x01
00106$:
;MapManager.c:221: if (ok) {
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00109$
;MapManager.c:222: *replace_ptr = tileNew;
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(bc), a
;MapManager.c:223: UpdateMapTile(TARGET_BKG, tileX, tileY, tileNew, 0, NULL);
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#1
	ld	a, (hl)
	ld	hl, #0x0000
	push	hl
	ld	h, #0x00
	push	hl
	inc	sp
	push	bc
	push	af
	inc	sp
	xor	a, a
	call	_UpdateMapTile
00109$:
;MapManager.c:42: SWITCH_RAM(RAM_DEFAULT);
;MapManager.c:43: DISABLE_RAM;
	xor	a, a
	ld	(#_rRAMB), a
	ld	(#_rRAMG),a
;MapManager.c:225: RevertSRAM();
;MapManager.c:226: }
	add	sp, #3
	pop	hl
	add	sp, #3
	jp	(hl)
;MapManager.c:228: void ReplaceDynaTile(UINT16 tileX, UINT16 tileY, UINT8 tileNew, UINT8 tileCompare) NONBANKED {
;	---------------------------------
; Function ReplaceDynaTile
; ---------------------------------
_ReplaceDynaTile::
	push	bc
;MapManager.c:229: CalculateOffset(tileX, tileY);
	push	de
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_CalculateOffset
	pop	de
;MapManager.c:230: if (*replace_ptr == tileCompare) {
	ld	a, (_replace_ptr)
	ld	c, a
	ld	hl, #_replace_ptr + 1
	ld	b, (hl)
	ld	a, (bc)
	ldhl	sp,	#5
	sub	a, (hl)
	jr	NZ, 00102$
;MapManager.c:231: *replace_ptr = tileNew;
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(bc), a
;MapManager.c:232: UpdateMapTile(TARGET_BKG, tileX, tileY, tileNew, 0, NULL);
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#0
	ld	a, (hl)
	ld	hl, #0x0000
	push	hl
	ld	h, #0x00
	push	hl
	inc	sp
	push	bc
	push	af
	inc	sp
	xor	a, a
	call	_UpdateMapTile
00102$:
;MapManager.c:42: SWITCH_RAM(RAM_DEFAULT);
;MapManager.c:43: DISABLE_RAM;
	xor	a, a
	ld	(#_rRAMB), a
	ld	(#_rRAMG),a
;MapManager.c:234: RevertSRAM();
;MapManager.c:235: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;MapManager.c:237: void UpdateDynaTile(UINT16 tileX, UINT16 tileY, UINT8 tileNew) NONBANKED {
;	---------------------------------
; Function UpdateDynaTile
; ---------------------------------
_UpdateDynaTile::
	push	bc
;MapManager.c:238: CalculateOffset(tileX, tileY);
	push	de
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_CalculateOffset
	pop	de
;MapManager.c:239: *replace_ptr = tileNew;
	ld	a, (_replace_ptr)
	ld	c, a
	ld	hl, #_replace_ptr + 1
	ld	b, (hl)
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(bc), a
;MapManager.c:240: UpdateMapTile(TARGET_BKG, tileX, tileY, tileNew, 0, NULL);
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#0
	ld	a, (hl)
	ld	hl, #0x0000
	push	hl
	ld	h, #0x00
	push	hl
	inc	sp
	push	bc
	push	af
	inc	sp
	xor	a, a
	call	_UpdateMapTile
;MapManager.c:42: SWITCH_RAM(RAM_DEFAULT);
;MapManager.c:43: DISABLE_RAM;
	xor	a, a
	ld	(#_rRAMB), a
	ld	(#_rRAMG),a
;MapManager.c:241: RevertSRAM();
;MapManager.c:242: }
	inc	sp
	inc	sp
	pop	hl
	inc	sp
	jp	(hl)
;MapManager.c:244: UINT8 DynaTileAt(UINT16 tileX, UINT16 tileY) NONBANKED {
;	---------------------------------
; Function DynaTileAt
; ---------------------------------
_DynaTileAt::
;MapManager.c:245: CalculateOffset(tileX, tileY);
	call	_CalculateOffset
;MapManager.c:246: UINT8 return_value = *replace_ptr;
	ld	a, (_replace_ptr)
	ld	hl, #_replace_ptr + 1
	ld	h, (hl)
	ld	l, a
	ld	l, (hl)
;MapManager.c:42: SWITCH_RAM(RAM_DEFAULT);
;MapManager.c:43: DISABLE_RAM;
	xor	a, a
	ld	(_rRAMB), a
	ld	(_rRAMG), a
;MapManager.c:248: return return_value;
	ld	a, l
;MapManager.c:249: }
	ret
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;MapManager.c:41: inline void RevertSRAM(void) {
;	---------------------------------
; Function RevertSRAM
; ---------------------------------
_RevertSRAM::
;MapManager.c:42: SWITCH_RAM(RAM_DEFAULT);
;MapManager.c:43: DISABLE_RAM;
	xor	a, a
	ld	(#_rRAMB), a
	ld	(#_rRAMG),a
;MapManager.c:44: }
	ret
;MapManager.c:46: inline void RestoreDefaultScroll(void) {
;	---------------------------------
; Function RestoreDefaultScroll
; ---------------------------------
_RestoreDefaultScroll::
;MapManager.c:47: dynamic_map_active = 0;
	xor	a, a
	ld	(#_dynamic_map_active),a
;MapManager.c:48: }
	ret
;MapManager.c:199: static void CalculateOffset(UINT16 tileX, UINT16 tileY) {
;	---------------------------------
; Function CalculateOffset
; ---------------------------------
_CalculateOffset:
	add	sp, #-4
	ldhl	sp,	#2
	ld	(hl), e
	inc	hl
	ld	(hl), d
	inc	sp
	inc	sp
	push	bc
;MapManager.c:200: ENABLE_RAM;
	ld	hl, #_rRAMG
	ld	(hl), #0x0a
;MapManager.c:201: UINT16 current_tile = (tileY * current_level_desc.width) + tileX;
	ld	hl, #(_current_level_desc + 2)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	call	__mulint
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
;MapManager.c:202: if (current_tile >= BUFFER_SIZE) {
	ld	a, b
	sub	a, #0x20
	jr	C, 00102$
;MapManager.c:203: replace_ptr = buffer_data_b + current_tile - BUFFER_SIZE;
	ld	hl, #_buffer_data_b
	add	hl, bc
	ld	c, l
	ld	a,h
	add	a,#0xe0
	ld	hl, #_replace_ptr
	ld	(hl), c
	inc	hl
	ld	(hl), a
;MapManager.c:204: replace_ram = RAM_DATA_B;
	ld	hl, #_replace_ram
	ld	(hl), #0x02
	jr	00103$
00102$:
;MapManager.c:206: replace_ptr = buffer_data_a + current_tile;
	ld	hl, #_buffer_data_a
	add	hl, bc
	ld	c, l
	ld	a, h
	ld	hl, #_replace_ptr
	ld	(hl), c
	inc	hl
	ld	(hl), a
;MapManager.c:207: replace_ram = RAM_DATA_A;
	ld	hl, #_replace_ram
	ld	(hl), #0x01
00103$:
;MapManager.c:209: SWITCH_RAM(replace_ram);
	ld	a, (#_replace_ram)
	ld	(#_rRAMB),a
;MapManager.c:210: }
	add	sp, #4
	ret
	.area _CODE
	.area _INITIALIZER
__xinit____CRASH_HANDLER_INIT:
	.dw ___HandleCrash
	.area _CABS (ABS)
