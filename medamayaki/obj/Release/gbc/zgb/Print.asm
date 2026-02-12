;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Print
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _UpdateMapTile
	.globl _set_sprite_data
	.globl _set_bkg_data
	.globl _memcpy
	.globl _uitoa
	.globl _itoa
	.globl _font_offset
	.globl _print_target
	.globl _print_y
	.globl _print_x
	.globl _print_render
	.globl _font_tiledata_bank
	.globl _font_tiledata
	.globl _font_current_offset
	.globl _default_recode_table
	.globl b_InitDefaultRecode
	.globl _InitDefaultRecode
	.globl _InitRecodeTable
	.globl _Printf
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_font_current_offset::
	.ds 2
_font_tiledata::
	.ds 2
_font_tiledata_bank::
	.ds 1
_Printf_tmp_10000_268:
	.ds 10
_Printf_old_x_10000_268:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_print_render::
	.ds 1
_print_x::
	.ds 1
_print_y::
	.ds 1
_print_target::
	.ds 1
_font_offset::
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
;C:/CrossZGB/ZGB/common/src/Print.c:32: void InitRecodeTable(const UINT8* recode_table, UINT8 bank) NONBANKED {
;	---------------------------------
; Function InitRecodeTable
; ---------------------------------
_InitRecodeTable::
	ld	c, e
	ld	b, d
	ld	e, a
;C:/CrossZGB/ZGB/common/src/Print.c:33: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	d, a
;C:/CrossZGB/ZGB/common/src/Print.c:34: SWITCH_ROM(bank);
	ld	a, e
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), e
;C:/CrossZGB/ZGB/common/src/Print.c:35: memcpy(font_recode_table, recode_table + ' ', RECODE_TABLE_SIZE);
	ld	hl, #0x0020
	add	hl, bc
	ld	c, l
	ld	b, h
	push	de
	ld	hl, #0x0060
	push	hl
	ld	de, #_font_recode_table
	call	_memcpy
	pop	de
;C:/CrossZGB/ZGB/common/src/Print.c:36: SWITCH_ROM(__save);
	ld	a, d
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/Print.c:37: }
	ret
;C:/CrossZGB/ZGB/common/src/Print.c:39: UINT8 Printf(const unsigned char* txt, ...) NONBANKED { 
;	---------------------------------
; Function Printf
; ---------------------------------
_Printf::
	add	sp, #-7
;C:/CrossZGB/ZGB/common/src/Print.c:43: const unsigned char *ptr = txt; 
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Print.c:46: old_x = print_x;
	ld	a, (#_print_x)
	ld	(#_Printf_old_x_10000_268),a
;C:/CrossZGB/ZGB/common/src/Print.c:51: va_start(list, txt); 
	ldhl	sp,#11
	ld	c, l
	ld	b, h
	inc	sp
	inc	sp
	push	bc
;C:/CrossZGB/ZGB/common/src/Print.c:52: while(*ptr) {
00118$:
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00120$
;C:/CrossZGB/ZGB/common/src/Print.c:53: c = (*ptr++) & 0x7fu; // support only ascii
	dec	hl
	inc	(hl)
	jr	NZ, 00213$
	inc	hl
	inc	(hl)
00213$:
	and	a, #0x7f
	ldhl	sp,	#2
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/Print.c:54: if (c == '%') {
	ld	a, (hl)
	sub	a, #0x25
	jp	NZ, 00108$
;C:/CrossZGB/ZGB/common/src/Print.c:55: switch(c = *(ptr++) & 0x7fu) {
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	inc	(hl)
	jr	NZ, 00216$
	inc	hl
	inc	(hl)
00216$:
	res	7, a
	ldhl	sp,	#2
;C:/CrossZGB/ZGB/common/src/Print.c:58: itoa(va_arg(list, INT16), tmp, 10);
	ld	(hl+), a
	pop	de
	push	de
	inc	de
	inc	de
	ld	c, e
	ld	b, d
	dec	bc
	dec	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/Print.c:55: switch(c = *(ptr++) & 0x7fu) {
	cp	a, #0x64
	jr	Z, 00102$
	cp	a, #0x69
	jr	Z, 00102$
	cp	a, #0x73
	jr	Z, 00104$
	sub	a, #0x75
	jr	Z, 00103$
	jr	00108$
;C:/CrossZGB/ZGB/common/src/Print.c:57: case 'i':
00102$:
;C:/CrossZGB/ZGB/common/src/Print.c:58: itoa(va_arg(list, INT16), tmp, 10);
	ld	bc, #_Printf_tmp_10000_268
	inc	sp
	inc	sp
	push	de
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, #0x0a
	push	af
	inc	sp
	push	bc
	push	hl
	call	_itoa
	add	sp, #5
;C:/CrossZGB/ZGB/common/src/Print.c:59: Printf(tmp);
	ld	bc, #_Printf_tmp_10000_268
	push	bc
	call	_Printf
	pop	hl
;C:/CrossZGB/ZGB/common/src/Print.c:60: continue;
	jr	00118$
;C:/CrossZGB/ZGB/common/src/Print.c:61: case 'u':
00103$:
;C:/CrossZGB/ZGB/common/src/Print.c:62: uitoa(va_arg(list, INT16), tmp, 10);
	ld	bc, #_Printf_tmp_10000_268
	inc	sp
	inc	sp
	push	de
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, #0x0a
	push	af
	inc	sp
	push	bc
	push	hl
	call	_uitoa
	add	sp, #5
;C:/CrossZGB/ZGB/common/src/Print.c:63: Printf(tmp);
	ld	de, #_Printf_tmp_10000_268
	push	de
	call	_Printf
	pop	hl
;C:/CrossZGB/ZGB/common/src/Print.c:64: continue;
	jp	00118$
;C:/CrossZGB/ZGB/common/src/Print.c:65: case 's':
00104$:
;C:/CrossZGB/ZGB/common/src/Print.c:66: Printf(va_arg(list, char*));
	inc	sp
	inc	sp
	push	de
	ld	l, c
	ld	h, b
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_Printf
	pop	hl
;C:/CrossZGB/ZGB/common/src/Print.c:67: continue;
	jp	00118$
;C:/CrossZGB/ZGB/common/src/Print.c:70: }
00108$:
;C:/CrossZGB/ZGB/common/src/Print.c:72: c = font_recode_table[((c < ' ') ? 0u : (c - ' '))];
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x20
	jr	NC, 00127$
	xor	a, a
	jr	00128$
00127$:
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0xe0
00128$:
	ld	l, a
	ld	h, #0x00
	ld	de, #_font_recode_table
	add	hl, de
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/Print.c:73: if (print_render) {
	ld	a, (#_print_render)
	or	a, a
	jp	Z, 00116$
;C:/CrossZGB/ZGB/common/src/Print.c:74: UINT8 __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	c, a
;C:/CrossZGB/ZGB/common/src/Print.c:75: SWITCH_ROM(font_tiledata_bank);
	ld	a, (_font_tiledata_bank)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Print.c:77: set_native_tile_data(font_current_offset, 1, font_tiledata + ((UINT16)c << 4));
	ld	l, b
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	ld	d, h
	ld	hl, #_font_tiledata
	add	a, (hl)
	inc	hl
	ld	e, a
	ld	a, d
	adc	a, (hl)
	ld	d, a
	ld	a, (_font_current_offset)
	ld	b, a
;c:\crosszgb\gbdk\include\gb\gb.h:2145: if (first_tile < 256) {
;c:\crosszgb\gbdk\include\gb\gb.h:2146: set_bkg_data(first_tile, nb_tiles, data);
;c:\crosszgb\gbdk\include\gb\gb.h:2145: if (first_tile < 256) {
	ld	a, (#_font_current_offset + 1)
	sub	a, #0x01
	jr	NC, 00122$
;c:\crosszgb\gbdk\include\gb\gb.h:2146: set_bkg_data(first_tile, nb_tiles, data);
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_bkg_data
	add	sp, #4
	jr	00124$
00122$:
;c:\crosszgb\gbdk\include\gb\gb.h:2148: set_sprite_data(first_tile - 256, nb_tiles, data);
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;C:/CrossZGB/ZGB/common/src/Print.c:77: set_native_tile_data(font_current_offset, 1, font_tiledata + ((UINT16)c << 4));
00124$:
;C:/CrossZGB/ZGB/common/src/Print.c:85: SWITCH_ROM(__save);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;C:/CrossZGB/ZGB/common/src/Print.c:88: if(print_target == PRINT_BKG)
	ld	a, (#_print_target)
	or	a, a
	jr	NZ, 00110$
;C:/CrossZGB/ZGB/common/src/Print.c:90: UpdateMapTile(print_target, print_x + scroll_offset_x, print_y + scroll_offset_y, font_current_offset, 0, NULL);
	ld	a, (#_print_y)
	ld	hl, #_scroll_offset_y
	add	a, (hl)
	ld	b, a
	ld	a, (#_print_x)
	ld	hl, #_scroll_offset_x
	add	a, (hl)
	ld	e, a
	ld	hl, #0x0000
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	a, (_font_current_offset)
	ld	l, a
	ld	a, (_font_current_offset + 1)
	ld	h, a
	push	hl
	push	bc
	inc	sp
	ld	a, (_print_target)
	call	_UpdateMapTile
	jr	00111$
00110$:
;C:/CrossZGB/ZGB/common/src/Print.c:93: UpdateMapTile(print_target, print_x, print_y, font_current_offset, 0, NULL);
	ld	de, #0x0000
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	a, (_font_current_offset)
	ld	e, a
	ld	hl, #_font_current_offset + 1
	ld	d, (hl)
	push	de
	ld	a, (_print_y)
	push	af
	inc	sp
	ld	a, (_print_x)
	ld	e, a
	ld	a, (_print_target)
	call	_UpdateMapTile
00111$:
;C:/CrossZGB/ZGB/common/src/Print.c:95: font_current_offset++;
	ld	hl, #_font_current_offset
	inc	(hl)
	jr	NZ, 00117$
	inc	hl
	inc	(hl)
	jr	00117$
00116$:
;C:/CrossZGB/ZGB/common/src/Print.c:98: if(print_target == PRINT_BKG)
	ld	a, (#_print_target)
	or	a, a
	jr	NZ, 00113$
;C:/CrossZGB/ZGB/common/src/Print.c:100: UpdateMapTile(print_target, print_x + scroll_offset_x, print_y + scroll_offset_y, font_offset, c, NULL);
	ld	a, (#_print_y)
	ld	hl, #_scroll_offset_y
	add	a, (hl)
	ld	d, a
	ld	a, (#_print_x)
	ld	hl, #_scroll_offset_x
	add	a, (hl)
	ld	e, a
	ld	hl, #0x0000
	push	hl
	push	bc
	inc	sp
	ld	a, (_font_offset)
	ld	c, a
	ld	hl, #_font_offset + 1
	ld	b, (hl)
	push	bc
	push	de
	inc	sp
	ld	a, (_print_target)
	call	_UpdateMapTile
	jr	00117$
00113$:
;C:/CrossZGB/ZGB/common/src/Print.c:103: UpdateMapTile(print_target, print_x, print_y, font_offset, c, NULL);
	ld	de, #0x0000
	push	de
	push	bc
	inc	sp
	ld	a, (_font_offset)
	ld	e, a
	ld	hl, #_font_offset + 1
	ld	d, (hl)
	push	de
	ld	a, (_print_y)
	push	af
	inc	sp
	ld	a, (_print_x)
	ld	e, a
	ld	a, (_print_target)
	call	_UpdateMapTile
00117$:
;C:/CrossZGB/ZGB/common/src/Print.c:106: print_x++;
	ld	hl, #_print_x
	inc	(hl)
	jp	00118$
00120$:
;C:/CrossZGB/ZGB/common/src/Print.c:110: return print_x - old_x;
	ld	a, (#_print_x)
	ld	hl, #_Printf_old_x_10000_268
	sub	a, (hl)
;C:/CrossZGB/ZGB/common/src/Print.c:111: }
	add	sp, #7
	ret
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE_1
;C:/CrossZGB/ZGB/common/src/Print.c:28: void InitDefaultRecode(void) BANKED {
;	---------------------------------
; Function InitDefaultRecode
; ---------------------------------
	b_InitDefaultRecode	= 1
_InitDefaultRecode::
;C:/CrossZGB/ZGB/common/src/Print.c:29: memcpy(font_recode_table, default_recode_table, RECODE_TABLE_SIZE);
	ld	de, #0x0060
	push	de
	ld	bc, #_default_recode_table
	ld	de, #_font_recode_table
	call	_memcpy
;C:/CrossZGB/ZGB/common/src/Print.c:30: }
	ret
_default_recode_table:
	.db #0x00	; 0
	.db #0x25	; 37
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x2b	; 43
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x11	; 17
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _CODE_1
	.area _INITIALIZER
__xinit__print_render:
	.db #0x00	; 0
__xinit__print_x:
	.db #0x00	; 0
__xinit__print_y:
	.db #0x00	; 0
__xinit__print_target:
	.db #0x00	; 0
__xinit__font_offset:
	.dw #0x0000
	.area _CABS (ABS)
