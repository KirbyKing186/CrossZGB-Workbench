;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module DefAnimHandler
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _GetSpriteAnimation
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
___save:
	.ds 1
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
;C:/CrossZGB/ZGB/common/src/DefAnimHandler.c:9: const metasprite_t * GetSpriteAnimation(Sprite * sprite, UINT16 anim_idx) {
;	---------------------------------
; Function GetSpriteAnimation
; ---------------------------------
_GetSpriteAnimation::
	push	bc
;C:/CrossZGB/ZGB/common/src/DefAnimHandler.c:10: __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
	ld	(#___save),a
;C:/CrossZGB/ZGB/common/src/DefAnimHandler.c:11: SWITCH_ROM(sprite->mt_sprite_bank);
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldh	(__current_bank + 0), a
	ld	a, (bc)
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/DefAnimHandler.c:12: struct metasprite_t * res = sprite->mt_sprite_info->metasprites[anim_idx];
	ld	hl, #0x0007
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0009
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	add	a, a
	rl	e
	ld	l, a
	ld	h, e
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;C:/CrossZGB/ZGB/common/src/DefAnimHandler.c:13: SWITCH_ROM(__save);
	ld	a, (___save)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/DefAnimHandler.c:14: return res;
;C:/CrossZGB/ZGB/common/src/DefAnimHandler.c:15: }
	inc	sp
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
