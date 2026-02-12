;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Vector
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcpy
	.globl _BufferExchange
	.globl _BufferRotate
	.globl _VectorRemovePos
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
;C:/CrossZGB/ZGB/common/src/Vector.c:5: void BufferExchange(UINT8* v, UINT16 xy) NAKED {
;	---------------------------------
; Function BufferExchange
; ---------------------------------
_BufferExchange::
;C:/CrossZGB/ZGB/common/src/Vector.c:63: __endasm;
	ld	a, e
	add	c
	ld	l, a
	adc	d
	sub	l
	ld	h, a
	ld	c, (hl)
	push	hl
	ld	a, e
	add	b
	ld	l, a
	adc	d
	sub	l
	ld	h, a
	ld	a, (hl)
	ld	(hl), c
	pop	hl
	ld	(hl), a
	ret
;C:/CrossZGB/ZGB/common/src/Vector.c:64: }
;C:/CrossZGB/ZGB/common/src/Vector.c:66: void BufferRotate(UINT8* v, UINT8 len) NAKED {
;	---------------------------------
; Function BufferRotate
; ---------------------------------
_BufferRotate::
;C:/CrossZGB/ZGB/common/src/Vector.c:116: __endasm;
	sub	#1
	ret	c
	ret	z
	ld	c, a
	ld	h, d
	ld	l, e
	inc	de
	ld	b, (hl)
1$:
	ld	a, (de)
	ld	(hl+), a
	inc	de
	dec	c
	jr	nz, 1$
	ld	(hl), b
	ret
;C:/CrossZGB/ZGB/common/src/Vector.c:117: }
;C:/CrossZGB/ZGB/common/src/Vector.c:119: void VectorRemovePos(UINT8* v, UINT8 pos) {
;	---------------------------------
; Function VectorRemovePos
; ---------------------------------
_VectorRemovePos::
	dec	sp
	dec	sp
	ld	c, a
;C:/CrossZGB/ZGB/common/src/Vector.c:120: memcpy(&v[pos + 1], &v[pos + 2], (UINT8)((UINT8)(v[0]--) - pos));
	ld	a, (de)
	ld	b, a
	dec	a
	ld	(de), a
	ld	a, b
	sub	a, c
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ld	l, c
	ld	h, #0x00
	ld	c, l
	ld	b, h
	inc	hl
	inc	bc
	inc	bc
	ld	a, c
	add	a, e
	ld	c, a
	ld	a, b
	adc	a, d
	ld	b, a
	add	hl, de
	ld	e, l
	ld	d, h
	pop	hl
	push	hl
	push	hl
;C:/CrossZGB/ZGB/common/src/Vector.c:121: }
	call	_memcpy
	pop	hl
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
