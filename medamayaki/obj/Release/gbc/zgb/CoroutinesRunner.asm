;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module CoroutinesRunner
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _coro_init
	.globl _coro_free_ctx
	.globl _coro_contexts
	.globl _coro_runner_init
	.globl _coro_runner_alloc
	.globl _coro_runner_free
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_coro_contexts::
	.ds 1600
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_coro_free_ctx::
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
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:34: static void __initializer__(void) NONBANKED NAKED {
;	---------------------------------
; Function __initializer__
; ---------------------------------
___initializer__:
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:46: __endasm;
;	we inject the call to the coro_runner_init() in the _GSINIT section,
;	so there will be no need to call it explicitly in the game code
	.AREA	_GSINIT
	call	_coro_runner_init
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:47: }
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:10: void coro_runner_init(void) {
;	---------------------------------
; Function coro_runner_init
; ---------------------------------
_coro_runner_init::
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:11: coro_free_ctx = NULL;
	xor	a, a
	ld	hl, #_coro_free_ctx
	ld	(hl+), a
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:12: for (coro_runner_context_t * i = coro_contexts; i != (coro_contexts + CORO_MAX_CONTEXTS); i++) {
	ld	bc, #_coro_contexts
00103$:
	ld	a, #<((_coro_contexts + 1600))
	sub	a, c
	jr	NZ, 00122$
	ld	a, #>((_coro_contexts + 1600))
	sub	a, b
	ret	Z
00122$:
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:13: i->next = coro_free_ctx;
	ld	hl, #0x0062
	add	hl, bc
	ld	a, (_coro_free_ctx)
	ld	(hl+), a
	ld	a, (_coro_free_ctx + 1)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:14: coro_free_ctx = i;
	ld	hl, #_coro_free_ctx
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:12: for (coro_runner_context_t * i = coro_contexts; i != (coro_contexts + CORO_MAX_CONTEXTS); i++) {
	ld	hl, #0x0064
	add	hl, bc
	ld	c, l
	ld	b, h
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:16: }
	jr	00103$
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:18: void * coro_runner_alloc(coro_t coro, uint8_t coro_bank, void * user_data) {
;	---------------------------------
; Function coro_runner_alloc
; ---------------------------------
_coro_runner_alloc::
	add	sp, #-5
	ldhl	sp,	#3
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:19: if (coro_free_ctx) {
	ld	hl, #_coro_free_ctx + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00102$
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:20: coro_runner_context_t * tmp = coro_free_ctx;
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_coro_free_ctx + 1)
	ldhl	sp,	#1
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:21: coro_free_ctx = tmp->next;
	pop	de
	push	de
	ld	hl, #0x0062
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ld	hl, #_coro_free_ctx
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:22: coro_init(&tmp->coro_context, coro, coro_bank, user_data, CORO_STACK_SIZE);
	pop	de
	push	de
	ld	bc, #0x0060
	push	bc
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	push	af
	inc	sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_coro_init
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:23: return tmp;
	pop	bc
	push	bc
	jr	00103$
00102$:
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:25: return NULL;
	ld	bc, #0x0000
00103$:
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:26: }
	add	sp, #5
	pop	hl
	pop	af
	jp	(hl)
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:28: void coro_runner_free(void * ctx) {
;	---------------------------------
; Function coro_runner_free
; ---------------------------------
_coro_runner_free::
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:29: if (!ctx) return;
	ld	a, d
	or	a, e
	ret	Z
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:30: ((coro_runner_context_t *)ctx)->next = coro_free_ctx;
	ld	hl, #0x0062
	add	hl, de
	ld	a, (_coro_free_ctx)
	ld	(hl+), a
	ld	a, (_coro_free_ctx + 1)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:31: coro_free_ctx = (coro_runner_context_t *)ctx;
	ld	hl, #_coro_free_ctx
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/CoroutinesRunner.c:32: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__coro_free_ctx:
	.dw #0x0000
	.area _CABS (ABS)
