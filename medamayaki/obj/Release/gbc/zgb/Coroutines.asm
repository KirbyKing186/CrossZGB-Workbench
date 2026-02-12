;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Coroutines
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _coro_finalize
	.globl _coro_current_context
	.globl _coro_main_context
	.globl _coro_yield
	.globl _coro_init
	.globl _coro_continue
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_coro_main_context::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_coro_current_context::
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
;C:/CrossZGB/ZGB/common/src/Coroutines.c:10: bool coro_yield(void) NONBANKED NAKED {
;	---------------------------------
; Function coro_yield
; ---------------------------------
_coro_yield::
;C:/CrossZGB/ZGB/common/src/Coroutines.c:86: __endasm;
	ldhl	sp, #-2
	ld	d, h
	ld	e, l
	ld	hl, #_coro_current_context
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	or	h
	ret	z
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldh	a, (__current_bank)
	push	af
	ld	hl, #_coro_main_context
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	sp, hl
	pop	af
	ldh	(__current_bank), a
	ld	(_rROMB0), a
	xor	a
	ld	hl, #_coro_current_context
	ld	(hl+), a
	ld	(hl), a
	inc	a
	ret
;C:/CrossZGB/ZGB/common/src/Coroutines.c:87: }
;C:/CrossZGB/ZGB/common/src/Coroutines.c:89: bool coro_finalize(void) NONBANKED NAKED {
;	---------------------------------
; Function coro_finalize
; ---------------------------------
_coro_finalize::
;C:/CrossZGB/ZGB/common/src/Coroutines.c:125: __endasm;
	ld	hl, #_coro_main_context
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	sp, hl
	pop	af
	ldh	(__current_bank), a
	ld	(_rROMB0), a
	xor	a
	ld	hl, #_coro_current_context
	ld	(hl+), a
	ld	(hl), a
	ret
;C:/CrossZGB/ZGB/common/src/Coroutines.c:126: }
;C:/CrossZGB/ZGB/common/src/Coroutines.c:128: void coro_init(coro_context_t * context, coro_t coro, uint8_t coro_bank, void * user_data, uint16_t stack_size) NONBANKED {
;	---------------------------------
; Function coro_init
; ---------------------------------
_coro_init::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
;C:/CrossZGB/ZGB/common/src/Coroutines.c:129: uint16_t * stack = context->stack + ((stack_size >> 1) - 1);
	ld	a, d
	ld	(hl-), a
	inc	sp
	inc	sp
	push	bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	dec	de
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
;C:/CrossZGB/ZGB/common/src/Coroutines.c:130: *stack = (uint16_t)user_data;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/Coroutines.c:132: stack = (uint16_t *)((uint8_t *)stack - 6); // match SM83 banked call convention
	ld	a, c
	add	a, #0xfa
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
;C:/CrossZGB/ZGB/common/src/Coroutines.c:138: *stack-- = (uint16_t *)coro_finalize;
	ld	de, #_coro_finalize
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	dec	bc
	dec	bc
;C:/CrossZGB/ZGB/common/src/Coroutines.c:139: *stack = (uint16_t *)coro;
	pop	de
	push	de
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/Coroutines.c:141: *--stack = coro_bank << 8;                  // coroutine bank
	dec	bc
	dec	bc
	ldhl	sp,	#6
	ld	d, (hl)
	ld	e, #0x00
	ld	l, c
	ld	h, b
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/Coroutines.c:148: context->SP = stack;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
	inc	hl
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/Coroutines.c:149: }
	add	sp, #4
	pop	hl
	add	sp, #5
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/Coroutines.c:151: bool coro_continue(coro_context_t * context) NONBANKED NAKED {
;	---------------------------------
; Function coro_continue
; ---------------------------------
_coro_continue::
;C:/CrossZGB/ZGB/common/src/Coroutines.c:199: __endasm;
	ldh	a, (__current_bank)
	push	af
	ld	(_coro_main_context), sp
	ld	hl, #_coro_current_context
	ld	(hl), e
	inc	hl
	ld	(hl), d
	ld	h, d
	ld	l, e
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	sp, hl
	pop	af
	ldh	(__current_bank), a
	ld	(_rROMB0), a
	ret
;C:/CrossZGB/ZGB/common/src/Coroutines.c:200: }
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _INITIALIZER
__xinit__coro_current_context:
	.dw #0x0000
	.area _CABS (ABS)
