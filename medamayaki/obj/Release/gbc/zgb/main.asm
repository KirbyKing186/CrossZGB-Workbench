;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl b_InitSprites
	.globl _InitSprites
	.globl b_InitStates
	.globl _InitStates
	.globl _InitWindow
	.globl _VBL_isr
	.globl b_CheckSRAMIntegrity
	.globl _CheckSRAMIntegrity
	.globl b_SetDefaultColorPalettes
	.globl _SetDefaultColorPalettes
	.globl b_FadeOut
	.globl _FadeOut
	.globl b_FadeIn
	.globl _FadeIn
	.globl _SpriteManagerUpdate
	.globl _SpriteManagerReset
	.globl _MUSIC_isr
	.globl _SetWindowPos
	.globl _InitOAMs
	.globl _sgb_check
	.globl _cpu_fast
	.globl _display_off
	.globl _vsync
	.globl _set_interrupts
	.globl _joypad_ex
	.globl _joypad_init
	.globl _add_low_priority_TIM
	.globl _add_VBL
	.globl _vbl_count
	.globl _fade_mode
	.globl _state_running
	.globl __is_SGB
	.globl _current_state
	.globl _delta_time
	.globl _SetState
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_delta_time::
	.ds 1
_current_state::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
__is_SGB::
	.ds 1
_state_running::
	.ds 1
_fade_mode::
	.ds 1
_vbl_count::
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
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;C:/CrossZGB/ZGB/common/src/main.c:21: static void __force_use_font(void) NAKED { __asm__(".globl _font_recode_table"); }
;	---------------------------------
; Function __force_use_font
; ---------------------------------
___force_use_font:
	.globl	_font_recode_table
;C:/CrossZGB/ZGB/common/src/main.c:33: void SetState(UINT8 state) {
;	---------------------------------
; Function SetState
; ---------------------------------
_SetState::
	ld	(#_next_state),a
;C:/CrossZGB/ZGB/common/src/main.c:34: state_running = FALSE;
	xor	a, a
	ld	(#_state_running),a
;C:/CrossZGB/ZGB/common/src/main.c:35: next_state = state;
;C:/CrossZGB/ZGB/common/src/main.c:36: }
	ret
;C:/CrossZGB/ZGB/common/src/main.c:46: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
	dec	sp
;C:/CrossZGB/ZGB/common/src/main.c:49: for (UINT8 i = 4; i != 0; i--) vsync();
	ld	c, #0x04
00128$:
	ld	a, c
	or	a, a
	jr	Z, 00101$
	call	_vsync
	dec	c
	jr	00128$
00101$:
;C:/CrossZGB/ZGB/common/src/main.c:51: _is_SGB = sgb_check();
	call	_sgb_check
	ld	hl, #__is_SGB
	ld	(hl), e
;C:/CrossZGB/ZGB/common/src/main.c:53: cpu_fast();
	call	_cpu_fast
;C:/CrossZGB/ZGB/common/src/main.c:58: CheckSRAMIntegrity((UINT8*)&savegame, sizeof(Savegame));
	ld	de, #0x000c
	push	de
	ld	de, #_savegame
	push	de
	ld	e, #b_CheckSRAMIntegrity
	ld	hl, #_CheckSRAMIntegrity
	call	___sdcc_bcall_ehl
	add	sp, #4
;C:/CrossZGB/ZGB/common/include/Keys.h:12: joypad_init(4, &joypads);
	ld	de, #_joypads
	push	de
	ld	a, #0x04
	push	af
	inc	sp
	call	_joypad_init
	add	sp, #3
;C:/CrossZGB/ZGB/common/src/main.c:63: InitOAMs();
	call	_InitOAMs
;C:/CrossZGB/ZGB/common/include/Sound.h:35: NR52_REG = SFX_CH_ENABLE, NR51_REG = 0xFF, NR50_REG = 0x77;  // enable sound
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Sound.h:75: NR12_REG = NR22_REG = NR32_REG = NR42_REG = 0;
	xor	a, a
	ldh	(_NR42_REG + 0), a
	xor	a, a
	ldh	(_NR32_REG + 0), a
	xor	a, a
	ldh	(_NR22_REG + 0), a
	xor	a, a
	ldh	(_NR12_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Sound.h:76: NR14_REG = NR24_REG = NR44_REG = SFX_CH_RETRIGGER;
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
	ld	a, #0xc0
	ldh	(_NR24_REG + 0), a
	ld	a, #0xc0
	ldh	(_NR14_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Sound.h:77: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Music.h:87: }
	di
;C:/CrossZGB/ZGB/common/include/Music.h:77: TMA_REG = (_cpu == CGB_TYPE) ? 0x78u : 0xBCu;
	ld	a, (#__cpu)
	sub	a, #0x11
	ld	a, #0x78
	jr	Z, 00133$
	ld	a, #0xbc
00133$:
	ldh	(_TMA_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Music.h:81: TAC_REG = 0x04u;
	ld	a, #0x04
	ldh	(_TAC_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Music.h:82: add_low_priority_TIM(MUSIC_isr);
	ld	de, #_MUSIC_isr
	call	_add_low_priority_TIM
	ei
;C:/CrossZGB/ZGB/common/include/Music.h:89: set_interrupts(IE_REG | TIM_IFLAG);
	ldh	a, (_IE_REG + 0)
	set	2, a
	call	_set_interrupts
;C:/CrossZGB/ZGB/common/src/main.c:67: InitStates();
	ld	e, #b_InitStates
	ld	hl, #_InitStates
	call	___sdcc_bcall_ehl
;C:/CrossZGB/ZGB/common/src/main.c:68: InitSprites();
	ld	e, #b_InitSprites
	ld	hl, #_InitSprites
	call	___sdcc_bcall_ehl
;C:/CrossZGB/ZGB/common/src/main.c:73: }
	di
;C:/CrossZGB/ZGB/common/src/main.c:72: add_VBL(VBL_isr);
	ld	de, #_VBL_isr
	call	_add_VBL
	ei
;C:/CrossZGB/ZGB/common/src/main.c:75: InitWindow();
	call	_InitWindow
;C:/CrossZGB/ZGB/common/src/main.c:80: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/main.c:82: SHOW_SPRITES; SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/main.c:84: WY_REG = (UINT8)(DEVICE_WINDOW_PX_OFFSET_Y + DEVICE_SCREEN_PX_HEIGHT);
	ld	a, #0x90
	ldh	(_WY_REG + 0), a
;C:/CrossZGB/ZGB/common/src/main.c:90: SetDefaultColorPalettes();
	ld	e, #b_SetDefaultColorPalettes
	ld	hl, #_SetDefaultColorPalettes
	call	___sdcc_bcall_ehl
;C:/CrossZGB/ZGB/common/src/main.c:93: DISPLAY_OFF;
	call	_display_off
;C:/CrossZGB/ZGB/common/src/main.c:94: while(TRUE) {
00120$:
;C:/CrossZGB/ZGB/common/src/main.c:96: if (fade_mode != FADE_MANUAL) {
	ld	a, (#_fade_mode)
	sub	a, #0x02
	jr	Z, 00103$
;C:/CrossZGB/ZGB/common/src/main.c:97: BGP_REG = OBP0_REG = DMG_PALETTE(DMG_WHITE, DMG_LITE_GRAY, DMG_DARK_GRAY, DMG_BLACK);
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;C:/CrossZGB/ZGB/common/src/main.c:98: OBP1_REG = DMG_PALETTE(DMG_WHITE, DMG_WHITE, DMG_DARK_GRAY, DMG_BLACK);
	ld	a, #0xe0
	ldh	(_OBP1_REG + 0), a
00103$:
;C:/CrossZGB/ZGB/common/src/main.c:104: SpriteManagerReset();                           // reset sprite manager and remove all sprites
	call	_SpriteManagerReset
;C:/CrossZGB/ZGB/common/src/main.c:105: scroll_target = NULL;                           // reset scroll target
	xor	a, a
	ld	hl, #_scroll_target
	ld	(hl+), a
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/main.c:107: state_running = TRUE;
	ld	hl, #_state_running
	ld	(hl), #0x01
;C:/CrossZGB/ZGB/common/src/main.c:108: current_state = next_state;                     // switch to the next scene
	ld	a, (#_next_state)
	ld	(#_current_state),a
;C:/CrossZGB/ZGB/common/src/main.c:110: last_tile_loaded = 0;                           // reset tile allocator
;C:/CrossZGB/ZGB/common/src/main.c:112: last_bg_pal_loaded = 0;                         // reset palette allocator for CGB/SMS/GG
	xor	a, a
	ld	(#_last_tile_loaded), a
	ld	(#_last_bg_pal_loaded),a
;C:/CrossZGB/ZGB/common/src/main.c:114: scroll_x_vblank = scroll_offset_x = 0;          // reset the scroll position;
	xor	a, a
	ld	(#_scroll_offset_x), a
	ld	hl, #_scroll_x_vblank
	ld	(hl+), a
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/main.c:115: scroll_y_vblank = scroll_offset_y = 0;
	xor	a, a
	ld	(#_scroll_offset_y), a
	ld	hl, #_scroll_y_vblank
	ld	(hl+), a
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/main.c:117: HIDE_HUD;                                       // force hiding HUD
	xor	a, a
	push	af
	inc	sp
	ld	e, #0x00
	ld	a, #0x07
	call	_SetWindowPos
;C:/CrossZGB/ZGB/common/src/main.c:119: SWITCH_ROM(stateBanks[current_state]);          // switch to the current state bank and stay
	ld	a, #<(_stateBanks)
	ld	hl, #_current_state
	add	a, (hl)
	ld	c, a
	ld	a, #>(_stateBanks)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/main.c:121: startFuncs[current_state]();                    // initialize current state
	ld	bc, #_startFuncs+0
	ld	a, (_current_state)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	l, c
	ld	h, b
	call	___sdcc_call_hl
;C:/CrossZGB/ZGB/common/src/main.c:123: scroll_x_vblank = scroll_x, scroll_y_vblank = scroll_y;
	ld	a, (#_scroll_x)
	ld	(#_scroll_x_vblank),a
	ld	a, (#_scroll_x + 1)
	ld	(#_scroll_x_vblank + 1),a
	ld	a, (#_scroll_y)
	ld	(#_scroll_y_vblank),a
	ld	a, (#_scroll_y + 1)
	ld	(#_scroll_y_vblank + 1),a
;C:/CrossZGB/ZGB/common/src/main.c:125: if (VECTOR_LEN(sprite_manager_updatables)) {
	ld	a, (#_sprite_manager_updatables + 0)
	or	a, a
	jr	Z, 00105$
;C:/CrossZGB/ZGB/common/src/main.c:126: SpriteManagerUpdate();                  // render sprites on screen if START() of the state spawns any
	call	_SpriteManagerUpdate
;C:/CrossZGB/ZGB/common/src/main.c:127: vsync();                                // wait until sprites are actually rendered to OAM
	call	_vsync
00105$:
;C:/CrossZGB/ZGB/common/src/main.c:130: if (state_running) {                            // initialization function may change state in START()
	ld	a, (#_state_running)
	or	a, a
	jp	Z, 00118$
;C:/CrossZGB/ZGB/common/src/main.c:132: switch (fade_mode) {                    // show screen content
	ld	a, (#_fade_mode)
	dec	a
	jr	NZ, 00107$
;C:/CrossZGB/ZGB/common/src/main.c:133: case FADE_ON : FadeOut(); break;
	ld	e, #b_FadeOut
	ld	hl, #_FadeOut
	call	___sdcc_bcall_ehl
	jr	00108$
;C:/CrossZGB/ZGB/common/src/main.c:134: default: DISPLAY_ON; break;
00107$:
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;C:/CrossZGB/ZGB/common/src/main.c:135: }
00108$:
;C:/CrossZGB/ZGB/common/src/main.c:137: Void_Func_Void current_update = updateFuncs[current_state];
	ld	bc, #_updateFuncs+0
	ld	a, (_current_state)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/main.c:139: while (state_running) {
00111$:
	ld	a, (#_state_running)
	or	a, a
	jr	Z, 00113$
;C:/CrossZGB/ZGB/common/src/main.c:140: if (!vbl_count) vsync();        // wait VBlank if not slowdown
	ld	a, (#_vbl_count)
	or	a, a
	jr	NZ, 00110$
	call	_vsync
00110$:
;C:/CrossZGB/ZGB/common/src/main.c:142: delta_time = (vbl_count < 2u) ? 0u : 1u;
	ld	a, (#_vbl_count)
	sub	a, #0x02
	jr	NC, 00134$
	xor	a, a
	jr	00135$
00134$:
	ld	a, #0x01
00135$:
	ld	(#_delta_time),a
;C:/CrossZGB/ZGB/common/src/main.c:143: vbl_count = 0;
	xor	a, a
	ld	(#_vbl_count),a
;C:/CrossZGB/ZGB/common/include/Keys.h:16: old_joypads.joy0 = joypads.joy0, old_joypads.joy1 = joypads.joy1, old_joypads.joy2 = joypads.joy2, old_joypads.joy3 = joypads.joy3;
	ld	a, (#(_joypads + 1) + 0)
	ld	hl, #(_old_joypads + 1)
	ld	(hl+), a
	ld	a, (#(_joypads + 2) + 0)
	ld	(hl+), a
	ld	a, (#(_joypads + 3) + 0)
	ld	(hl+), a
	ld	a, (#(_joypads + 4) + 0)
	ld	(hl), a
;C:/CrossZGB/ZGB/common/include/Keys.h:17: joypad_ex(&joypads);
	ld	de, #_joypads
	call	_joypad_ex
;C:/CrossZGB/ZGB/common/src/main.c:147: SpriteManagerUpdate();          // render sprites on screen
	call	_SpriteManagerUpdate
;C:/CrossZGB/ZGB/common/src/main.c:149: current_update();               // update current state
	pop	hl
	push	hl
	call	___sdcc_call_hl
	jr	00111$
00113$:
;C:/CrossZGB/ZGB/common/src/main.c:152: switch (fade_mode) {                    // hide screen content
	ld	a, (#_fade_mode)
	or	a, a
	jr	Z, 00115$
	ld	a, (#_fade_mode)
	dec	a
	jr	NZ, 00118$
;C:/CrossZGB/ZGB/common/src/main.c:153: case FADE_ON : FadeIn(); break;
	ld	e, #b_FadeIn
	ld	hl, #_FadeIn
	call	___sdcc_bcall_ehl
	jr	00118$
;C:/CrossZGB/ZGB/common/src/main.c:154: case FADE_OFF: DISPLAY_OFF; break;
00115$:
	call	_display_off
;C:/CrossZGB/ZGB/common/src/main.c:155: }
00118$:
;C:/CrossZGB/ZGB/common/src/main.c:158: destroyFuncs[current_state]();                  // destroy current state
	ld	a, (_current_state)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	ld	de, #_destroyFuncs
	add	hl, de
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	ld	l, c
	ld	h, b
	call	___sdcc_call_hl
	jp	00120$
;C:/CrossZGB/ZGB/common/src/main.c:160: }
	inc	sp
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
__xinit___is_SGB:
	.db #0x00	; 0
__xinit__state_running:
	.db #0x00	; 0
__xinit__fade_mode:
	.db #0x01	; 1
__xinit__vbl_count:
	.db #0x00	; 0
	.area _CABS (ABS)
