;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Window
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _InitWindow
	.globl _SetWindowPos
	.globl _LCD_isr
	.globl _set_interrupts
	.globl _add_LCD
	.globl _win_x
	.globl _win_stop
	.globl _win_start
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
_win_start::
	.ds 1
_win_stop::
	.ds 1
_win_x::
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
;C:/CrossZGB/ZGB/common/src/Window.c:8: void LCD_isr(void) NONBANKED {
;	---------------------------------
; Function LCD_isr
; ---------------------------------
_LCD_isr::
;C:/CrossZGB/ZGB/common/src/Window.c:9: if (LYC_REG == win_start) {
	ldh	a, (_LYC_REG + 0)
	ld	hl, #_win_start
	sub	a, (hl)
	jr	NZ, 00102$
;C:/CrossZGB/ZGB/common/src/Window.c:10: WX_REG = win_x;
	ld	a, (#_win_x)
	ldh	(_WX_REG + 0), a
;C:/CrossZGB/ZGB/common/src/Window.c:11: SHOW_WIN; HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/Window.c:12: LYC_REG = win_stop;
	ld	a, (#_win_stop)
	ldh	(_LYC_REG + 0), a
	ret
00102$:
;C:/CrossZGB/ZGB/common/src/Window.c:14: WX_REG = 0;
	xor	a, a
	ldh	(_WX_REG + 0), a
;C:/CrossZGB/ZGB/common/src/Window.c:15: HIDE_WIN; SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/Window.c:16: LYC_REG = win_start;
	ld	a, (#_win_start)
	ldh	(_LYC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/Window.c:18: }
	ret
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;C:/CrossZGB/ZGB/common/src/Window.c:20: void SetWindowPos(UINT8 x, UINT8 y, UINT8 h) {
;	---------------------------------
; Function SetWindowPos
; ---------------------------------
_SetWindowPos::
	ld	c, a
;C:/CrossZGB/ZGB/common/src/Window.c:21: if ((h) && (y < DEVICE_SCREEN_PX_HEIGHT)) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	ld	a, e
	sub	a, #0x90
	jr	NC, 00102$
;C:/CrossZGB/ZGB/common/src/Window.c:22: win_x = WX_REG = x;
	ld	a, c
	ldh	(_WX_REG + 0), a
	ld	hl, #_win_x
	ld	(hl), c
;C:/CrossZGB/ZGB/common/src/Window.c:23: WY_REG = y;
	ld	a, e
	ldh	(_WY_REG + 0), a
;C:/CrossZGB/ZGB/common/src/Window.c:24: win_stop = (((UINT16)(y) + h) < LYC_SYNC_VALUE) ? (y + h) : LYC_SYNC_VALUE;
	ld	c, e
	ld	b, #0x00
	ldhl	sp,	#2
	ld	a, (hl)
	ld	h, #0x00
	ld	l, a
	add	hl, bc
	ld	a, l
	sub	a, #0x96
	ld	a, h
	sbc	a, #0x00
	jr	NC, 00107$
	ld	a, e
	ldhl	sp,	#2
	add	a, (hl)
	jr	00108$
00107$:
	ld	a, #0x96
00108$:
	ld	(#_win_stop),a
;C:/CrossZGB/ZGB/common/src/Window.c:25: LYC_REG = win_start = (y) ? (y - 1u) : (LYC_SYNC_VALUE + 1u);
	ld	a, e
	or	a, a
	jr	Z, 00109$
	ld	a, e
	dec	a
	jr	00110$
00109$:
	ld	a, #0x97
00110$:
	ld	(#_win_start),a
	ldh	(_LYC_REG + 0), a
	jr	00105$
00102$:
;C:/CrossZGB/ZGB/common/src/Window.c:27: LYC_REG = LYC_NEVER_FIRE;
	ld	a, #0xa0
	ldh	(_LYC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/Window.c:28: HIDE_WIN; SHOW_SPRITES;		
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
00105$:
;C:/CrossZGB/ZGB/common/src/Window.c:30: }
	pop	hl
	inc	sp
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/Window.c:34: void InitWindow(void) {
;	---------------------------------
; Function InitWindow
; ---------------------------------
_InitWindow::
;C:/CrossZGB/ZGB/common/src/Window.c:40: }
	di
;C:/CrossZGB/ZGB/common/src/Window.c:38: STAT_REG |= STATF_LYC;
	ldh	a, (_STAT_REG + 0)
	or	a, #0x40
	ldh	(_STAT_REG + 0), a
;C:/CrossZGB/ZGB/common/src/Window.c:39: add_LCD(LCD_isr);
	ld	de, #_LCD_isr
	call	_add_LCD
	ei
;C:/CrossZGB/ZGB/common/src/Window.c:41: set_interrupts(IE_REG | LCD_IFLAG);
	ldh	a, (_IE_REG + 0)
	set	1, a
;C:/CrossZGB/ZGB/common/src/Window.c:43: }
	jp	_set_interrupts
	.area _CODE
	.area _INITIALIZER
__xinit__win_start:
	.db #0x91	; 145
__xinit__win_stop:
	.db #0x96	; 150
__xinit__win_x:
	.db #0x07	; 7
	.area _CABS (ABS)
