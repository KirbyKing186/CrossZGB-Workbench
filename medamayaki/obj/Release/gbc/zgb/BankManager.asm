;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module BankManager
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bank_stack
	.globl _bank_stackSTACK
	.globl _PushBank
	.globl _PopBank
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_bank_stackSTACK::
	.ds 10
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_bank_stack::
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
;C:/CrossZGB/ZGB/common/src/BankManager.c:7: void PushBank(UINT8 b) NONBANKED {
;	---------------------------------
; Function PushBank
; ---------------------------------
_PushBank::
	ld	c, a
;C:/CrossZGB/ZGB/common/src/BankManager.c:8: StackPush(bank_stack, CURRENT_BANK);
	ld	hl, #_bank_stack
	inc	(hl)
	jr	NZ, 00103$
	inc	hl
	inc	(hl)
00103$:
	ld	a, (_bank_stack)
	ld	e, a
	ld	hl, #_bank_stack + 1
	ld	d, (hl)
	ldh	a, (__current_bank + 0)
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/BankManager.c:9: SWITCH_ROM(b);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;C:/CrossZGB/ZGB/common/src/BankManager.c:10: }
	ret
;C:/CrossZGB/ZGB/common/src/BankManager.c:12: void PopBank(void) NONBANKED {
;	---------------------------------
; Function PopBank
; ---------------------------------
_PopBank::
;C:/CrossZGB/ZGB/common/src/BankManager.c:13: UINT8 b = StackPop(bank_stack); 
	ld	a, (_bank_stack)
	ld	hl, #_bank_stack + 1
	ld	h, (hl)
	ld	l, a
	ld	c, (hl)
	ld	hl, #_bank_stack
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/BankManager.c:14: SWITCH_ROM(b);
	ld	a, c
	ldh	(__current_bank + 0), a
	ld	hl, #_rROMB0
	ld	(hl), c
;C:/CrossZGB/ZGB/common/src/BankManager.c:15: }
	ret
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _INITIALIZER
__xinit__bank_stack:
	.dw (_bank_stackSTACK - 1)
	.area _CABS (ABS)
