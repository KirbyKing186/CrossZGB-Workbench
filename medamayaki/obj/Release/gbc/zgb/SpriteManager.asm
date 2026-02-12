;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module SpriteManager
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _SetPalette
	.globl _RefreshScroll
	.globl _DrawSprite
	.globl _InitSprite
	.globl _ClearOAMs
	.globl _SwapOAMs
	.globl _BufferExchange
	.globl _BufferRotate
	.globl _set_sprite_data
	.globl _memcmp
	.globl _memset
	.globl _THIS
	.globl _THIS_IDX
	.globl _enable_flickering
	.globl _last_sprite_pal_loaded
	.globl _last_sprite_loaded
	.globl _sprite_manager_sprites_pool
	.globl _prev_scroll_target
	.globl _sprite_manager_removal_check
	.globl _sprite_manager_updatables
	.globl _sprite_manager_sprites_poolSTACK
	.globl _sprite_manager_sprites
	.globl _sprite_manager_sprites_mem
	.globl _SpriteManagerReset
	.globl _SpriteManagerLoad
	.globl _SpriteManagerAdd
	.globl _SpriteManagerRemove
	.globl _SpriteManagerRemoveSprite
	.globl _SpriteManagerFlushRemove
	.globl _SpriteManagerUpdate
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_sprite_manager_sprites_mem::
	.ds 1040
_sprite_manager_sprites::
	.ds 40
_sprite_manager_sprites_poolSTACK::
	.ds 20
_sprite_manager_updatables::
	.ds 21
_sprite_manager_removal_check::
	.ds 1
_prev_scroll_target::
	.ds 2
_SpriteManagerUpdate___save_10000_312:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
___CRASH_HANDLER_INIT:
	.ds 2
_sprite_manager_sprites_pool::
	.ds 2
_last_sprite_loaded::
	.ds 2
_last_sprite_pal_loaded::
	.ds 1
_enable_flickering::
	.ds 1
_THIS_IDX::
	.ds 1
_THIS::
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
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:41: void SpriteManagerReset(void) {
;	---------------------------------
; Function SpriteManagerReset
; ---------------------------------
_SpriteManagerReset::
	dec	sp
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:42: prev_scroll_target = NULL;
	xor	a, a
	ld	hl, #_prev_scroll_target
	ld	(hl+), a
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:45: last_sprite_loaded = LAST_SPRITE_IDX;
	ld	hl, #_last_sprite_loaded
	ld	a, #0x80
	ld	(hl+), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:49: last_sprite_pal_loaded = 0;
	xor	a, a
	ld	(hl), a
	ld	(#_last_sprite_pal_loaded),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:51: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	c, a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:53: for(UINT8 i = 0u; i != VECTOR_LEN(sprite_manager_updatables); ++ i) {
	ld	b, #0x00
00104$:
	ld	a, (#_sprite_manager_updatables + 0)
	sub	a, b
	jr	Z, 00101$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:54: THIS = sprite_manager_sprites[VECTOR_GET(sprite_manager_updatables, i)];
	inc	b
	ld	a, #<(_sprite_manager_updatables)
	add	a, b
	ld	l, a
	ld	a, #>(_sprite_manager_updatables)
	adc	a, #0x00
	ld	h, a
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_sprite_manager_sprites
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #_THIS
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:55: SWITCH_ROM(spriteBanks[THIS->type]);
	ld	a, (_THIS)
	ld	hl, #_THIS + 1
	ld	d, (hl)
	add	a, #0x1d
	ld	e, a
	jr	NC, 00141$
	inc	d
00141$:
	ld	a, (de)
	add	a, #<(_spriteBanks)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_spriteBanks)
	ld	h, a
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (de)
	add	a, #<(_spriteBanks)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_spriteBanks)
	ld	h, a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:56: spriteDestroyFuncs[THIS->type]();
	ld	a, (de)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	ld	de, #_spriteDestroyFuncs
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	ld	bc, #00142$
	push	bc
	push	hl
	ret
00142$:
	pop	bc
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:53: for(UINT8 i = 0u; i != VECTOR_LEN(sprite_manager_updatables); ++ i) {
	jr	00104$
00101$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:58: SWITCH_ROM(__save);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:61: StackClear(sprite_manager_sprites_pool);
	ld	hl, #_sprite_manager_sprites_pool
	ld	(hl), #<((_sprite_manager_sprites_poolSTACK - 1))
	inc	hl
	ld	(hl), #>((_sprite_manager_sprites_poolSTACK - 1))
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:62: for(UINT8 i = 0; i != N_SPRITE_MANAGER_SPRITES; ++i) {
	ldhl	sp,	#0
	ld	(hl), #0x00
00107$:
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x14
	jr	Z, 00102$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:63: sprite_manager_sprites[i] = &sprite_manager_sprites_mem[i];
	ldhl	sp,	#0
	ld	c, (hl)
	ld	b, #0x00
	sla	c
	rl	b
	ld	hl, #_sprite_manager_sprites
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	ld	de, #_sprite_manager_sprites_mem
	add	hl, de
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:64: StackPush(sprite_manager_sprites_pool, i);
	ld	hl, #_sprite_manager_sprites_pool
	inc	(hl)
	jr	NZ, 00145$
	inc	hl
	inc	(hl)
00145$:
	ld	a, (_sprite_manager_sprites_pool)
	ld	c, a
	ld	hl, #_sprite_manager_sprites_pool + 1
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:62: for(UINT8 i = 0; i != N_SPRITE_MANAGER_SPRITES; ++i) {
	inc	(hl)
	jr	00107$
00102$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:66: ClearOAMs();
	call	_ClearOAMs
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:68: memset(spriteIdxs, LAST_SPRITE_IDX, SPRITES_ARRAY_LEN);
	ld	de, #0x0001
	push	de
	xor	a, a
	push	af
	ld	de, #_spriteIdxs
	push	de
	call	_memset
	add	sp, #6
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:69: memset(spriteIdxsH, LAST_SPRITE_IDX, SPRITES_ARRAY_LEN);
	ld	de, #0x0001
	push	de
	xor	a, a
	push	af
	ld	de, #_spriteIdxsH
	push	de
	call	_memset
	add	sp, #6
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:70: memset(spriteIdxsV, LAST_SPRITE_IDX, SPRITES_ARRAY_LEN);
	ld	de, #0x0001
	push	de
	xor	a, a
	push	af
	ld	de, #_spriteIdxsV
	push	de
	call	_memset
	add	sp, #6
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:71: memset(spriteIdxsHV, LAST_SPRITE_IDX, SPRITES_ARRAY_LEN);
	ld	de, #0x0001
	push	de
	xor	a, a
	push	af
	ld	de, #_spriteIdxsHV
	push	de
	call	_memset
	add	sp, #6
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:74: VECTOR_CLEAR(sprite_manager_updatables);
	ld	hl, #_sprite_manager_updatables
	ld	(hl), #0x00
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:75: sprite_manager_removal_check = FALSE;
	xor	a, a
	ld	(#_sprite_manager_removal_check),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:76: }
	inc	sp
	ret
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:78: void SpriteManagerLoad(UINT8 sprite_type) {
;	---------------------------------
; Function SpriteManagerLoad
; ---------------------------------
_SpriteManagerLoad::
	add	sp, #-16
	ldhl	sp,	#15
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:79: if (spriteIdxs[sprite_type] != LAST_SPRITE_IDX) // Already loaded
	ld	de, #_spriteIdxs
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x80
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:80: return;
	jp	NZ, 00119$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:82: if (last_sprite_loaded < -127) // No room for this sprite
	ld	hl, #_last_sprite_loaded
	ld	a, (hl+)
	sub	a, #0x81
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	ld	e, a
	bit	7, e
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
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:83: return;
	jp	C, 00119$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:89: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:90: SWITCH_ROM(spriteDataBanks[sprite_type]);
	ld	bc, #_spriteDataBanks+0
	ldhl	sp,	#15
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:92: const struct MetaSpriteInfo* data = spriteDatas[sprite_type];
	ld	bc, #_spriteDatas+0
	ldhl	sp,	#15
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#1
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:93: UINT8 n_tiles = data->num_tiles;
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	inc	bc
	inc	bc
	ld	a, (bc)
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:94: UINT8 n_pals = data->num_palettes;
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#4
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:97: last_sprite_loaded -= n_tiles;
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ld	hl, #_last_sprite_loaded
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	hl, #_last_sprite_loaded + 1
	ld	(hl-), a
	ld	(hl), e
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:101: spriteIdxs[sprite_type] = last_sprite_loaded;
	ld	a, (hl)
	ldhl	sp,	#13
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:102: spriteIdxsH[sprite_type] = last_sprite_loaded;
	ld	bc, #_spriteIdxsH+0
	ldhl	sp,	#15
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (_last_sprite_loaded)
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:103: spriteIdxsV[sprite_type] = last_sprite_loaded;
	ld	bc, #_spriteIdxsV+0
	ldhl	sp,	#15
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (_last_sprite_loaded)
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:104: spriteIdxsHV[sprite_type] = last_sprite_loaded;
	ld	bc, #_spriteIdxsHV+0
	ldhl	sp,	#15
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (_last_sprite_loaded)
	ld	(bc), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:106: UINT8 end = last_sprite_loaded + n_tiles;
	ld	a, (_last_sprite_loaded)
	ldhl	sp,	#3
	ld	c, (hl)
	add	a, c
	ldhl	sp,	#7
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:107: if((end - 1u) >= (UINT8)last_sprite_loaded) {
	ld	c, (hl)
	xor	a, a
	ld	b, a
	dec	bc
	ld	a, (#_last_sprite_loaded)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl+), a
	ld	(hl), #0x00
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:108: set_sprite_native_data(last_sprite_loaded, n_tiles, data->data);
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:110: set_sprite_native_data(last_sprite_loaded, n_tiles - end, data->data);
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:107: if((end - 1u) >= (UINT8)last_sprite_loaded) {
	ldhl	sp,	#9
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	C, 00106$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:108: set_sprite_native_data(last_sprite_loaded, n_tiles, data->data);
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#8
	ld	a, (hl)
;c:\crosszgb\gbdk\include\gb\gb.h:2185: set_sprite_data(first_tile, nb_tiles, data);
	push	bc
	ldhl	sp,	#5
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:108: set_sprite_native_data(last_sprite_loaded, n_tiles, data->data);
	jr	00126$
00106$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:110: set_sprite_native_data(last_sprite_loaded, n_tiles - end, data->data);
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#7
	sub	a, (hl)
	inc	hl
	ld	d, (hl)
;c:\crosszgb\gbdk\include\gb\gb.h:2185: set_sprite_data(first_tile, nb_tiles, data);
	push	bc
	push	af
	inc	sp
	push	de
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:111: set_sprite_native_data(0, end, data->data + ((n_tiles - end) << 4));
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ld	c, e
	ld	d, a
	ld	a, c
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	ld	e, a
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
;c:\crosszgb\gbdk\include\gb\gb.h:2185: set_sprite_data(first_tile, nb_tiles, data);
	push	hl
	ldhl	sp,	#9
	ld	h, (hl)
	ld	l, #0x00
	push	hl
	call	_set_sprite_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:152: for (i = 0; i != last_sprite_pal_loaded; ++i) {
00126$:
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ld	c, #0x00
00117$:
	ld	a, (#_last_sprite_pal_loaded)
	sub	a, c
	jr	Z, 00110$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:153: if (memcmp(ZGB_Fading_SPal + (i * N_PALETTE_COLORS), data->palettes, n_pals * PALETTE_SIZE) == 0)
	ldhl	sp,	#4
	ld	e, (hl)
	ld	d, #0x00
	sla	e
	rl	d
	sla	e
	rl	d
	sla	e
	rl	d
	ldhl	sp,	#11
	ld	a, e
	ld	(hl+), a
	ld	a, d
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	inc	de
	ld	a, (de)
	ld	e, b
	ld	d, a
	ld	l, c
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_ZGB_Fading_SPal)
	ld	b, a
	ld	a, h
	adc	a, #>(_ZGB_Fading_SPal)
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
	jr	Z, 00110$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:152: for (i = 0; i != last_sprite_pal_loaded; ++i) {
	inc	c
	jr	00117$
00110$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:158: spritePalsOffset[sprite_type] = i;
	ld	de, #_spritePalsOffset+0
	ldhl	sp,	#15
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:159: if (i == last_sprite_pal_loaded) {
	ld	a, (#_last_sprite_pal_loaded)
	sub	a, c
	jr	NZ, 00112$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:163: last_sprite_pal_loaded += SetPalette(SPRITES_PALETTE, last_sprite_pal_loaded, n_pals, data->palettes, CURRENT_BANK);
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldh	a, (__current_bank + 0)
	push	af
	inc	sp
	push	bc
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, (_last_sprite_pal_loaded)
	ld	e, a
	ld	a, #0x01
	call	_SetPalette
	ld	hl, #_last_sprite_pal_loaded
	ld	c, (hl)
	add	a, c
	ld	(hl), a
00112$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:169: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
00119$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:170: }
	add	sp, #16
	ret
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:172: Sprite* SpriteManagerAdd(UINT8 sprite_type, UINT16 x, UINT16 y) {
;	---------------------------------
; Function SpriteManagerAdd
; ---------------------------------
_SpriteManagerAdd::
	add	sp, #-9
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:176: if (VECTOR_LEN(sprite_manager_updatables) > (N_SPRITE_MANAGER_SPRITES - 1)) return NULL;
	ld	a, (#_sprite_manager_updatables + 0)
	cp	a, #0x14
	jr	C, 00102$
	ld	bc, #0x0000
	jp	00103$
00102$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:178: SpriteManagerLoad(sprite_type);
	ldhl	sp,	#8
	ld	a, (hl)
	call	_SpriteManagerLoad
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:180: sprite_idx = StackPop(sprite_manager_sprites_pool);
	ld	a, (_sprite_manager_sprites_pool)
	ld	hl, #_sprite_manager_sprites_pool + 1
	ld	h, (hl)
	ld	l, a
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ld	hl, #_sprite_manager_sprites_pool
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:181: sprite = sprite_manager_sprites[sprite_idx];
	ld	bc, #_sprite_manager_sprites+0
	ldhl	sp,	#5
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:182: sprite->type = sprite_type;
	ld	hl, #0x001d
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:183: sprite->marked_for_removal = FALSE;
	ld	hl, #0x001e
	add	hl, bc
	ld	(hl), #0x00
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:184: sprite->lim_x = SPRITE_LIMIT_X;
	ld	hl, #0x0019
	add	hl, bc
	ld	a, #0x20
	ld	(hl+), a
	ld	(hl), #0x00
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:185: sprite->lim_y = SPRITE_LIMIT_Y;
	ld	hl, #0x001b
	add	hl, bc
	ld	a, #0x20
	ld	(hl+), a
	ld	(hl), #0x00
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:186: sprite->mirror = NO_MIRROR;
	ld	hl, #0x0016
	add	hl, bc
	ld	(hl), #0x00
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:188: VectorAdd(sprite_manager_updatables, sprite_idx);
	ld	a, (#_sprite_manager_updatables + 0)
	inc	a
	ld	(#_sprite_manager_updatables),a
	add	a, #<(_sprite_manager_updatables)
	ld	e, a
	ld	a, #0x00
	adc	a, #>(_sprite_manager_updatables)
	ld	d, a
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:190: InitSprite(sprite, sprite_type);
	push	bc
	ldhl	sp,	#10
	ld	a, (hl)
	ld	e, c
	ld	d, b
	call	_InitSprite
	pop	bc
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:191: sprite->x = x;
	ld	e, c
	ld	d, b
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:192: sprite->y = y;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:193: sprite->unique_id = SPRITE_UNIQUE_ID(PX_TO_TILE(x), PX_TO_TILE(y + sprite->coll_h - 1));
	ld	hl, #0x001f
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	ld	hl, #0x0005
	add	hl, bc
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	dec	de
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ldhl	sp,	#2
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	ld	a, e
	ld	(hl-), a
	pop	de
	push	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:196: cached_sprite = THIS;
	ld	a, (#_THIS)
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (#_THIS + 1)
	ldhl	sp,	#3
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:197: cached_sprite_idx = THIS_IDX;
	ld	a, (#_THIS_IDX)
	ldhl	sp,	#4
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:198: THIS = sprite;
	ld	hl, #_THIS
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:199: THIS_IDX = VECTOR_LEN(sprite_manager_updatables) - 1;
	ld	a, (#_sprite_manager_updatables + 0)
	dec	a
	ld	(#_THIS_IDX),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:201: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#5
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:202: SWITCH_ROM(spriteBanks[sprite->type]);
	ld	hl, #0x001d
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, #<(_spriteBanks)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_spriteBanks)
	ld	h, a
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (de)
	add	a, #<(_spriteBanks)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_spriteBanks)
	ld	h, a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:203: spriteStartFuncs[sprite->type]();
	ld	a, (de)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	ld	de, #_spriteStartFuncs
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	ld	bc, #00112$
	push	bc
	ld	c, l
	ld	b, h
	push	bc
	ret
00112$:
	pop	bc
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:204: SWITCH_ROM(__save);
	ldhl	sp,	#5
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:207: THIS = cached_sprite;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_THIS),a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_THIS + 1),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:208: THIS_IDX = cached_sprite_idx;
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(#_THIS_IDX),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:209: return sprite;
00103$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:210: }
	add	sp, #9
	pop	hl
	pop	af
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:212: void SpriteManagerRemove(UINT8 idx) {
;	---------------------------------
; Function SpriteManagerRemove
; ---------------------------------
_SpriteManagerRemove::
	ld	e, a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:213: sprite_manager_sprites[VECTOR_GET(sprite_manager_updatables, idx)]->marked_for_removal = TRUE;
	ld	bc, #_sprite_manager_sprites+0
	inc	e
	ld	l, e
	ld	h, #0x00
	ld	de, #_sprite_manager_updatables
	add	hl, de
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x001e
	add	hl, bc
	ld	(hl), #0x01
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:214: sprite_manager_removal_check = TRUE;
	ld	hl, #_sprite_manager_removal_check
	ld	(hl), #0x01
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:215: }
	ret
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:217: void SpriteManagerRemoveSprite(Sprite* sprite) {
;	---------------------------------
; Function SpriteManagerRemoveSprite
; ---------------------------------
_SpriteManagerRemoveSprite::
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:218: sprite->marked_for_removal = TRUE;
	ld	hl, #0x001e
	add	hl, de
	ld	(hl), #0x01
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:219: sprite_manager_removal_check = TRUE;
	ld	hl, #_sprite_manager_removal_check
	ld	(hl), #0x01
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:220: }
	ret
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:222: void SpriteManagerFlushRemove(void) {
;	---------------------------------
; Function SpriteManagerFlushRemove
; ---------------------------------
_SpriteManagerFlushRemove::
	dec	sp
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:224: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ldhl	sp,	#0
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:227: SPRITEMANAGER_ITERATE(THIS_IDX, THIS) {
	xor	a, a
	ld	(#_THIS_IDX),a
	ld	hl, #_sprite_manager_updatables + 1
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_sprite_manager_sprites
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #_THIS
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	c, #0x00
00106$:
	ld	a, (#_sprite_manager_updatables + 0)
	ld	hl, #_THIS_IDX
	sub	a, (hl)
	jp	Z, 00104$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:228: UINT8 sprite_idx = VECTOR_GET(sprite_manager_updatables, THIS_IDX);
	ld	a, (#_THIS_IDX)
	inc	a
	ld	l, a
	ld	h, #0x00
	ld	de, #_sprite_manager_updatables
	add	hl, de
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:229: if (THIS->marked_for_removal) {
	ld	a, (_THIS)
	ld	e, a
	ld	hl, #_THIS + 1
	ld	d, (hl)
	ld	hl, #0x001e
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:231: SWITCH_ROM(spriteBanks[THIS->type]);
	ld	hl, #0x001d
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, #<(_spriteBanks)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_spriteBanks)
	ld	h, a
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (de)
	add	a, #<(_spriteBanks)
	ld	l, a
	ld	a, #0x00
	adc	a, #>(_spriteBanks)
	ld	h, a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:232: spriteDestroyFuncs[THIS->type]();
	ld	a, (de)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	ld	de, #_spriteDestroyFuncs
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	push	bc
	ld	bc, #00133$
	push	bc
	push	hl
	ret
00133$:
	pop	bc
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:234: StackPush(sprite_manager_sprites_pool, sprite_idx);
	ld	hl, #_sprite_manager_sprites_pool
	inc	(hl)
	jr	NZ, 00134$
	inc	hl
	inc	(hl)
00134$:
	ld	a, (_sprite_manager_sprites_pool)
	ld	hl, #_sprite_manager_sprites_pool + 1
	ld	h, (hl)
	ld	l, a
	ld	(hl), b
	jr	00107$
00102$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:237: VECTOR_SET_DIRECT(sprite_manager_updatables, current++, sprite_idx);
	inc	c
	ld	l, c
	ld	h, #0x00
	ld	de, #_sprite_manager_updatables
	add	hl, de
	ld	(hl), b
00107$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:227: SPRITEMANAGER_ITERATE(THIS_IDX, THIS) {
	ld	hl, #_THIS_IDX
	inc	(hl)
	ld	a, (hl)
	inc	a
	ld	l, a
	ld	h, #0x00
	ld	de, #_sprite_manager_updatables
	add	hl, de
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_sprite_manager_sprites
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #_THIS
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	jp	00106$
00104$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:241: VECTOR_LEN(sprite_manager_updatables) = current;
	ld	hl, #_sprite_manager_updatables
	ld	(hl), c
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:242: SWITCH_ROM(__save);
	ldhl	sp,	#0
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:243: sprite_manager_removal_check = FALSE;
	xor	a, a
	ld	(#_sprite_manager_removal_check),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:244: }
	inc	sp
	ret
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:249: void SpriteManagerUpdate(void) {
;	---------------------------------
; Function SpriteManagerUpdate
; ---------------------------------
_SpriteManagerUpdate::
	dec	sp
	dec	sp
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:253: __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	(#_SpriteManagerUpdate___save_10000_312),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:255: if (prev_scroll_target != scroll_target) {
	ld	a, (#_prev_scroll_target)
	ld	hl, #_scroll_target
	sub	a, (hl)
	jr	NZ, 00247$
	ld	a, (#_prev_scroll_target + 1)
	ld	hl, #_scroll_target + 1
	sub	a, (hl)
	jr	Z, 00108$
00247$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:257: if ((enable_flickering) && (scroll_target)) {
	ld	a, (#_enable_flickering)
	or	a, a
	jr	Z, 00105$
	ld	hl, #_scroll_target + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00105$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:258: for (UINT8 i = 0; i != VECTOR_LEN(sprite_manager_updatables); ++i) {
	ld	b, #0x00
00127$:
	ld	a, (#_sprite_manager_updatables + 0)
	sub	a, b
	jr	Z, 00105$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:259: if (sprite_manager_sprites[VECTOR_GET(sprite_manager_updatables, i)] == scroll_target) {
	ld	c, b
	inc	c
	ld	a, #<(_sprite_manager_updatables)
	add	a, c
	ld	l, a
	ld	a, #>(_sprite_manager_updatables)
	adc	a, #0x00
	ld	h, a
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	ld	de, #_sprite_manager_sprites
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (#_scroll_target)
	ldhl	sp,	#0
	sub	a, (hl)
	jr	NZ, 00128$
	ld	a, (#_scroll_target + 1)
	ldhl	sp,	#1
	sub	a, (hl)
	jr	NZ, 00128$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:260: VectorExchange(sprite_manager_updatables, 0, i);
	ld	de, #_sprite_manager_updatables
;C:/CrossZGB/ZGB/common/include/Vector.h:69: if ((pos1 < v[0]) && (pos2 < v[0])) BufferExchange(v, (UINT16)((pos1 + 1u) << 8) | (UINT8)(pos2 + 1u));
	ld	a, (de)
	ld	l, a
	xor	a, a
	sub	a, l
	jr	NC, 00105$
	ld	a, b
	sub	a, l
	jr	NC, 00105$
	ld	b, #0x01
	call	_BufferExchange
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:261: break;
	jr	00105$
00128$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:258: for (UINT8 i = 0; i != VECTOR_LEN(sprite_manager_updatables); ++i) {
	ld	b, c
	jr	00127$
00105$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:266: prev_scroll_target = scroll_target;
	ld	a, (#_scroll_target)
	ld	(#_prev_scroll_target),a
	ld	a, (#_scroll_target + 1)
	ld	(#_prev_scroll_target + 1),a
00108$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:269: if (enable_flickering) {
	ld	a, (#_enable_flickering)
	or	a, a
	jr	Z, 00110$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:270: VectorRotateFrom(sprite_manager_updatables, (scroll_target) ? 1 : 0);
	ld	hl, #_scroll_target + 1
	ld	a, (hl-)
	or	a, (hl)
	ld	e, #0x01
	jr	NZ, 00134$
	ld	e, #0x00
00134$:
	ld	hl, #_sprite_manager_updatables
;C:/CrossZGB/ZGB/common/include/Vector.h:65: if (pos < v[0]) BufferRotate(&v[pos + 1u], (v[0] - pos));
	ld	c, (hl)
	ld	a, e
	sub	a, c
	jr	NC, 00110$
	ld	a, c
	sub	a, e
	ld	c, a
	inc	e
	ld	d, #0x00
	add	hl, de
	ld	a, c
	ld	e, l
	ld	d, h
	call	_BufferRotate
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:270: VectorRotateFrom(sprite_manager_updatables, (scroll_target) ? 1 : 0);
00110$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:273: SPRITEMANAGER_ITERATE(THIS_IDX, THIS) {
	xor	a, a
	ld	(#_THIS_IDX),a
	ld	hl, #_sprite_manager_updatables + 1
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_sprite_manager_sprites
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #_THIS
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
00130$:
	ld	a, (#_sprite_manager_updatables + 0)
	ld	hl, #_THIS_IDX
	sub	a, (hl)
	jp	Z, 00116$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:275: if (THIS->marked_for_removal) continue;
	ld	a, (#_THIS)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_THIS + 1)
	ldhl	sp,	#1
	ld	(hl), a
	pop	de
	push	de
	ld	hl, #0x001e
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	NZ, 00115$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:277: SWITCH_ROM(spriteBanks[THIS->type]);
	pop	de
	push	de
	ld	hl, #0x001d
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_spriteBanks
	add	hl, de
	ld	a, (hl)
	ldh	(__current_bank + 0), a
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	ld	de, #_spriteBanks
	add	hl, de
	ld	a, (hl)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:279: spriteUpdateFuncs[THIS->type]();
	ld	a, (bc)
	ld	l, a
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_spriteUpdateFuncs
	add	hl, de
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	l, c
	ld	h, b
	call	___sdcc_call_hl
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:281: if (THIS == scroll_target) {
	ld	a, (#_THIS)
	ld	hl, #_scroll_target
	sub	a, (hl)
	jr	NZ, 00114$
	ld	a, (#_THIS + 1)
	ld	hl, #_scroll_target + 1
	sub	a, (hl)
	jr	NZ, 00114$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:282: RefreshScroll();
	call	_RefreshScroll
00114$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:285: DrawSprite();
	call	_DrawSprite
00115$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:273: SPRITEMANAGER_ITERATE(THIS_IDX, THIS) {
	ld	hl, #_THIS_IDX
	inc	(hl)
	ld	a, (hl)
	inc	a
	ld	l, a
	ld	h, #0x00
	ld	de, #_sprite_manager_updatables
	add	hl, de
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	ld	de, #_sprite_manager_sprites
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	hl, #_THIS
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	jp	00130$
00116$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:288: SWITCH_ROM(__save);
	ld	a, (_SpriteManagerUpdate___save_10000_312)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:290: SwapOAMs();
	call	_SwapOAMs
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:292: if (sprite_manager_removal_check) {
	ld	a, (#_sprite_manager_removal_check)
	or	a, a
	jr	Z, 00131$
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:293: SpriteManagerFlushRemove();
	inc	sp
	inc	sp
	jp	_SpriteManagerFlushRemove
00131$:
;C:/CrossZGB/ZGB/common/src/SpriteManager.c:295: }
	inc	sp
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
__xinit____CRASH_HANDLER_INIT:
	.dw ___HandleCrash
__xinit__sprite_manager_sprites_pool:
	.dw (_sprite_manager_sprites_poolSTACK - 1)
__xinit__last_sprite_loaded:
	.dw #0x0000
__xinit__last_sprite_pal_loaded:
	.db #0x00	; 0
__xinit__enable_flickering:
	.db #0x01	; 1
__xinit__THIS_IDX:
	.db #0x00	; 0
__xinit__THIS:
	.dw #0x0000
	.area _CABS (ABS)
