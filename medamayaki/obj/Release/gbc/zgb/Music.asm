;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Music
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sfx_play_isr
	.globl _stop_music_on_new_state
	.globl _last_music_bank
	.globl _last_music
	.globl _sfx_priority
	.globl _music_mute_mask
	.globl _music_paused
	.globl _MUSIC_isr
	.globl ___PlayMusic
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_MUSIC_isr_old_mute_mask_10000_173:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_music_paused::
	.ds 1
_music_mute_mask::
	.ds 1
_sfx_priority::
	.ds 1
_last_music::
	.ds 2
_last_music_bank::
	.ds 1
_stop_music_on_new_state::
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
;C:/CrossZGB/ZGB/common/src/Music.c:79: static UINT8 old_mute_mask = ~MUTE_MASK_NONE;
	ld	hl, #_MUSIC_isr_old_mute_mask_10000_173
	ld	(hl), #0xff
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
;C:/CrossZGB/ZGB/common/src/Music.c:78: void MUSIC_isr(void) NONBANKED {
;	---------------------------------
; Function MUSIC_isr
; ---------------------------------
_MUSIC_isr::
;C:/CrossZGB/ZGB/common/src/Music.c:80: if (old_mute_mask != music_mute_mask) {
	ld	a, (#_MUSIC_isr_old_mute_mask_10000_173)
	ld	hl, #_music_mute_mask
	sub	a, (hl)
	jr	Z, 00102$
;C:/CrossZGB/ZGB/common/src/Music.c:82: old_mute_mask = music_mute_mask;
	ld	a, (#_music_mute_mask)
	ld	(#_MUSIC_isr_old_mute_mask_10000_173),a
00102$:
;C:/CrossZGB/ZGB/common/src/Music.c:85: if (sfx_play_bank != SFX_STOP_BANK) {
	ld	a, (#_sfx_play_bank)
	inc	a
	jr	Z, 00106$
;C:/CrossZGB/ZGB/common/src/Music.c:86: if (!sfx_play_isr()) {
	call	_sfx_play_isr
	or	a, a
	jr	NZ, 00106$
;C:/CrossZGB/ZGB/common/src/Music.c:88: sfx_sound_cut_mask(music_mute_mask);
	ld	a, (_music_mute_mask)
	ld	c, a
;C:/CrossZGB/ZGB/common/include/Sound.h:62: if (mask & SFX_CH_1) NR12_REG = 0, NR14_REG = SFX_CH_RETRIGGER;
	rrca
	jr	NC, 00112$
	xor	a, a
	ldh	(_NR12_REG + 0), a
	ld	a, #0xc0
	ldh	(_NR14_REG + 0), a
00112$:
;C:/CrossZGB/ZGB/common/include/Sound.h:63: if (mask & SFX_CH_2) NR22_REG = 0, NR24_REG = SFX_CH_RETRIGGER;
	bit	1, c
	jr	Z, 00114$
	xor	a, a
	ldh	(_NR22_REG + 0), a
	ld	a, #0xc0
	ldh	(_NR24_REG + 0), a
00114$:
;C:/CrossZGB/ZGB/common/include/Sound.h:64: if (mask & SFX_CH_3) NR32_REG = 0;
	bit	2, c
	jr	Z, 00116$
	xor	a, a
	ldh	(_NR32_REG + 0), a
00116$:
;C:/CrossZGB/ZGB/common/include/Sound.h:65: if (mask & SFX_CH_4) NR42_REG = 0, NR44_REG = SFX_CH_RETRIGGER;
	bit	3, c
	jr	Z, 00118$
	xor	a, a
	ldh	(_NR42_REG + 0), a
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
00118$:
;C:/CrossZGB/ZGB/common/include/Sound.h:66: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;C:/CrossZGB/ZGB/common/src/Music.c:91: music_mute_mask = old_mute_mask = MUTE_MASK_NONE;
	xor	a, a
	ld	(#_MUSIC_isr_old_mute_mask_10000_173), a
	ld	(#_music_mute_mask),a
;C:/CrossZGB/ZGB/common/src/Music.c:93: sfx_priority = SFX_PRIORITY_MINIMAL;
	xor	a, a
	ld	(#_sfx_priority),a
;C:/CrossZGB/ZGB/common/src/Music.c:94: sfx_play_bank = SFX_STOP_BANK;
	ld	hl, #_sfx_play_bank
	ld	(hl), #0xff
00106$:
;C:/CrossZGB/ZGB/common/src/Music.c:98: if (music_paused)
	ld	a, (#_music_paused)
	or	a, a
;C:/CrossZGB/ZGB/common/src/Music.c:99: return;
	ret	NZ
;C:/CrossZGB/ZGB/common/src/Music.c:100: if (last_music_bank == SFX_STOP_BANK)
	ld	a, (#_last_music_bank)
	inc	a
	ret	Z
;C:/CrossZGB/ZGB/common/src/Music.c:101: return;
;C:/CrossZGB/ZGB/common/src/Music.c:125: }
	ret
;C:/CrossZGB/ZGB/common/src/Music.c:127: void __PlayMusic(void* music, UINT8 bank, UINT8 loop) NONBANKED {
;	---------------------------------
; Function __PlayMusic
; ---------------------------------
___PlayMusic::
	ld	c, a
;C:/CrossZGB/ZGB/common/src/Music.c:129: if(music != last_music) {
	ld	hl, #_last_music
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00112$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	Z, 00102$
00112$:
;C:/CrossZGB/ZGB/common/src/Music.c:131: UBYTE __save = CURRENT_BANK;
	ldh	a, (__current_bank + 0)
;C:/CrossZGB/ZGB/common/src/Music.c:149: SWITCH_ROM(__save);
	ldh	(__current_bank + 0), a
	ld	(#_rROMB0),a
;C:/CrossZGB/ZGB/common/src/Music.c:150: last_music = music;
	ld	hl, #_last_music
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;C:/CrossZGB/ZGB/common/src/Music.c:151: last_music_bank = bank;
	ld	hl, #_last_music_bank
	ld	(hl), c
00102$:
;C:/CrossZGB/ZGB/common/src/Music.c:153: music_paused = 0;
	xor	a, a
	ld	(#_music_paused),a
;C:/CrossZGB/ZGB/common/src/Music.c:154: }
	pop	hl
	inc	sp
	jp	(hl)
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
	.area _INITIALIZER
__xinit__music_paused:
	.db #0x01	; 1
__xinit__music_mute_mask:
	.db #0x00	; 0
__xinit__sfx_priority:
	.db #0x00	; 0
__xinit__last_music:
	.dw #0x0000
__xinit__last_music_bank:
	.db #0xff	; 255
__xinit__stop_music_on_new_state:
	.db #0x01	; 1
	.area _CABS (ABS)
