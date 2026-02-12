;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module OAMManager
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memset
	.globl _hide_sprites_range
	.globl _oam1
	.globl _oam0
	.globl _oam
	.globl _next_oam_idx
	.globl _SwapOAMs
	.globl _ClearOAMs
	.globl _InitOAMs
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
_next_oam_idx::
	.ds 1
_oam::
	.ds 2
_oam0::
	.ds 2
_oam1::
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
;C:/CrossZGB/ZGB/common/src/OAMManager.c:28: void SwapOAMs(void) {
;	---------------------------------
; Function SwapOAMs
; ---------------------------------
_SwapOAMs::
;C:/CrossZGB/ZGB/common/src/OAMManager.c:32: hide_sprites_range(next_oam_idx, MAX_HARDWARE_SPRITES);
	ld	e, #0x28
	ld	a, (_next_oam_idx)
	call	_hide_sprites_range
;C:/CrossZGB/ZGB/common/src/OAMManager.c:35: if ((_shadow_OAM_base = __render_shadow_OAM) == (UINT8)((UINT16)mirror_OAM >> 8)) {
	ld	hl, #___render_shadow_OAM
	ld	a, (hl)
	ldh	(__shadow_OAM_base + 0), a
	ld	a, #>(_mirror_OAM)
	sub	a, (hl)
	jr	NZ, 00102$
;C:/CrossZGB/ZGB/common/src/OAMManager.c:36: __render_shadow_OAM = (UINT8)((UINT16)(oam = (UINT8*)shadow_OAM) >> 8);
	ld	hl, #_oam
	ld	(hl), #<(_shadow_OAM)
	inc	hl
	ld	(hl), #>(_shadow_OAM)
	ld	hl, #___render_shadow_OAM
	ld	(hl), #>(_shadow_OAM)
	jr	00103$
00102$:
;C:/CrossZGB/ZGB/common/src/OAMManager.c:38: __render_shadow_OAM = (UINT8)((UINT16)(oam = (UINT8*)mirror_OAM) >> 8);
	ld	hl, #_oam
	ld	a, #<(_mirror_OAM)
	ld	(hl+), a
	ld	(hl), #>(_mirror_OAM)
	ld	hl, #___render_shadow_OAM
	ld	(hl), #>(_mirror_OAM)
00103$:
;C:/CrossZGB/ZGB/common/src/OAMManager.c:40: next_oam_idx = 0;
	xor	a, a
	ld	(#_next_oam_idx),a
;C:/CrossZGB/ZGB/common/src/OAMManager.c:42: scroll_x_vblank = scroll_x, scroll_y_vblank = scroll_y;
	ld	a, (#_scroll_x)
	ld	(#_scroll_x_vblank),a
	ld	a, (#_scroll_x + 1)
	ld	(#_scroll_x_vblank + 1),a
	ld	a, (#_scroll_y)
	ld	(#_scroll_y_vblank),a
	ld	a, (#_scroll_y + 1)
	ld	(#_scroll_y_vblank + 1),a
;C:/CrossZGB/ZGB/common/src/OAMManager.c:43: }
	ret
;C:/CrossZGB/ZGB/common/src/OAMManager.c:45: void ClearOAMs(void) {
;	---------------------------------
; Function ClearOAMs
; ---------------------------------
_ClearOAMs::
;C:/CrossZGB/ZGB/common/src/OAMManager.c:46: __render_shadow_OAM = (UINT8)((UINT16)shadow_OAM >> 8);
	ld	hl, #___render_shadow_OAM
	ld	(hl), #>(_shadow_OAM)
;C:/CrossZGB/ZGB/common/src/OAMManager.c:47: hide_sprites_range(0, MAX_HARDWARE_SPRITES);
	ld	e, #0x28
	xor	a, a
	call	_hide_sprites_range
;C:/CrossZGB/ZGB/common/src/OAMManager.c:48: _shadow_OAM_base = __render_shadow_OAM; // emulate SwapOAMs()
	ld	hl, #___render_shadow_OAM
	ld	a, (hl)
	ldh	(__shadow_OAM_base + 0), a
;C:/CrossZGB/ZGB/common/src/OAMManager.c:49: __render_shadow_OAM = (UINT8)((UINT16)mirror_OAM >> 8);
	ld	(hl), #>(_mirror_OAM)
;C:/CrossZGB/ZGB/common/src/OAMManager.c:50: hide_sprites_range(0, MAX_HARDWARE_SPRITES);
	ld	e, #0x28
	xor	a, a
	call	_hide_sprites_range
;C:/CrossZGB/ZGB/common/src/OAMManager.c:51: next_oam_idx = 0;
	xor	a, a
	ld	(#_next_oam_idx),a
;C:/CrossZGB/ZGB/common/src/OAMManager.c:52: }
	ret
;C:/CrossZGB/ZGB/common/src/OAMManager.c:54: void InitOAMs(void) {
;	---------------------------------
; Function InitOAMs
; ---------------------------------
_InitOAMs::
;C:/CrossZGB/ZGB/common/src/OAMManager.c:55: memset(mirror_OAM, 0, sizeof(mirror_OAM));
	xor	a, a
	and	a
	push	af
	ld	de, #0x0000
	push	de
	ld	de, #_mirror_OAM
	push	de
	call	_memset
	add	sp, #6
;C:/CrossZGB/ZGB/common/src/OAMManager.c:56: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__next_oam_idx:
	.db #0x00	; 0
__xinit__oam:
	.dw _shadow_OAM
__xinit__oam0:
	.dw _shadow_OAM
__xinit__oam1:
	.dw _mirror_OAM
	.area _CABS (ABS)
