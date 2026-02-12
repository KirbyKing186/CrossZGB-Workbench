;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module StateGame
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _Destroy_StateGame
	.globl _Update_StateGame
	.globl _Start_StateGame
	.globl _RestoreDefaultScroll
	.globl _InitDynaStage
	.globl _RestoreDefaultInterrupts
	.globl _InitSpecialInterrupts
	.globl _SpriteManagerAdd
	.globl _ScrollInitCollisionGroupVector
	.globl ___bank_StateGame
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
	.area _CODE_255
;StateGame.c:27: void START(void) {
;	---------------------------------
; Function Start_StateGame
; ---------------------------------
_Start_StateGame::
;StateGame.c:43: InitDynaStage(0);
	xor	a, a
	call	_InitDynaStage
;StateGame.c:46: ScrollInitCollisionGroupVector(COLLISION_ALL,      collision_all);
	ld	de, #_collision_all
	ld	a, #0x0f
	call	_ScrollInitCollisionGroupVector
;StateGame.c:47: ScrollInitCollisionGroupVector(COLLISION_TOP,      collision_top);
	ld	de, #_collision_top
	ld	a, #0x01
	call	_ScrollInitCollisionGroupVector
;StateGame.c:48: ScrollInitCollisionGroupVector(COLLISION_PLATFORM, collision_platform);
	ld	de, #_collision_platform
	ld	a, #0x81
	call	_ScrollInitCollisionGroupVector
;StateGame.c:49: ScrollInitCollisionGroupVector(COLLISION_BOTTOM,   collision_bottom);
	ld	de, #_collision_bottom
	ld	a, #0x02
	call	_ScrollInitCollisionGroupVector
;StateGame.c:50: ScrollInitCollisionGroupVector(COLLISION_LEFT,     collision_left);
	ld	de, #_collision_left
	ld	a, #0x04
	call	_ScrollInitCollisionGroupVector
;StateGame.c:51: ScrollInitCollisionGroupVector(COLLISION_RIGHT,    collision_right);
	ld	de, #_collision_right
	ld	a, #0x08
	call	_ScrollInitCollisionGroupVector
;StateGame.c:52: ScrollInitCollisionGroupVector(COLLISION_SLOPE_45_RIGHT,      collision_slope_45_right);
	ld	de, #_collision_slope_45_right
	ld	a, #0x20
	call	_ScrollInitCollisionGroupVector
;StateGame.c:53: ScrollInitCollisionGroupVector(COLLISION_SLOPE_225_RIGHT_BOT, collision_slope_225_right_bottom);
	ld	de, #_collision_slope_225_right_bottom
	ld	a, #0x40
	call	_ScrollInitCollisionGroupVector
;StateGame.c:54: ScrollInitCollisionGroupVector(COLLISION_SLOPE_225_RIGHT_TOP, collision_slope_225_right_top);
	ld	de, #_collision_slope_225_right_top
	ld	a, #0x60
	call	_ScrollInitCollisionGroupVector
;StateGame.c:55: ScrollInitCollisionGroupVector(COLLISION_SLOPE_45_LEFT,       collision_slope_45_left);
	ld	de, #_collision_slope_45_left
	ld	a, #0x30
	call	_ScrollInitCollisionGroupVector
;StateGame.c:56: ScrollInitCollisionGroupVector(COLLISION_SLOPE_225_LEFT_BOT,  collision_slope_225_left_bottom);
	ld	de, #_collision_slope_225_left_bottom
	ld	a, #0x50
	call	_ScrollInitCollisionGroupVector
;StateGame.c:57: ScrollInitCollisionGroupVector(COLLISION_SLOPE_225_LEFT_TOP,  collision_slope_225_left_top);
	ld	de, #_collision_slope_225_left_top
	ld	a, #0x70
	call	_ScrollInitCollisionGroupVector
;StateGame.c:63: InitSpecialInterrupts(RGB8(0x10, 0x90, 0xF8), RGB_WHITE, 8);
	ld	a, #0x08
	push	af
	inc	sp
	ld	bc, #0x7fff
	ld	de, #0x7e42
	call	_InitSpecialInterrupts
;StateGame.c:65: fade_mode = FADE_OFF;
	xor	a, a
	ld	(#_fade_mode),a
;StateGame.c:70: SpriteManagerAdd(SpritePlayer, TILE_TO_PX(6), TILE_TO_PX(17));
	ld	de, #0x0088
	push	de
	ld	de, #0x0030
	xor	a, a
	call	_SpriteManagerAdd
;StateGame.c:72: }
	ret
___bank_StateGame	=	0x00ff
_collision_all:
	.db #0x24	; 36
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
	.db #0x25	; 37
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
_collision_top:
	.db #0x00	; 0
_collision_platform:
	.db #0x02	; 2
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
_collision_bottom:
	.db #0x00	; 0
_collision_left:
	.db #0x00	; 0
_collision_right:
	.db #0x00	; 0
_collision_slope_45_right:
	.db #0x02	; 2
	.db #0x33	; 51	'3'
	.db #0x34	; 52	'4'
_collision_slope_225_right_bottom:
	.db #0x02	; 2
	.db #0x37	; 55	'7'
	.db #0x39	; 57	'9'
_collision_slope_225_right_top:
	.db #0x01	; 1
	.db #0x38	; 56	'8'
_collision_slope_45_left:
	.db #0x02	; 2
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
_collision_slope_225_left_bottom:
	.db #0x02	; 2
	.db #0x3a	; 58
	.db #0x3b	; 59
_collision_slope_225_left_top:
	.db #0x01	; 1
	.db #0x3c	; 60
;StateGame.c:74: void UPDATE(void) {
;	---------------------------------
; Function Update_StateGame
; ---------------------------------
_Update_StateGame::
;StateGame.c:75: }
	ret
;StateGame.c:77: void DESTROY(void) {
;	---------------------------------
; Function Destroy_StateGame
; ---------------------------------
_Destroy_StateGame::
;StateGame.c:79: RestoreDefaultScroll();
	call	_RestoreDefaultScroll
;StateGame.c:81: RestoreDefaultInterrupts();
;StateGame.c:82: }
	jp	_RestoreDefaultInterrupts
	.area _CODE_255
	.area _INITIALIZER
__xinit____CRASH_HANDLER_INIT:
	.dw ___HandleCrash
	.area _CABS (ABS)
