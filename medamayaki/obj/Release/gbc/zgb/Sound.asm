;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module Sound
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sfx_buffer
	.globl _PlayFx
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_sfx_buffer::
	.ds 9
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
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:8: void PlayFx(SOUND_CHANNEL channel, UINT8 mute_frames, ...) {
;	---------------------------------
; Function PlayFx
; ---------------------------------
_PlayFx::
	add	sp, #-6
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:9: if (sfx_play_bank != SFX_STOP_BANK) return; // return is SFX is playing
	ld	a, (#_sfx_play_bank)
	inc	a
	jp	NZ, 00135$
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:11: sfx_buffer[0] = ((mute_frames & 0x0F) << 4) | 1; // one packet with delay and data
	ldhl	sp,	#9
	ld	a, (hl)
	swap a
	and	a, #0xf0
	set	0, a
	ld	(#_sfx_buffer),a
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:15: if (channel & CHANNEL_1) { 
	ldhl	sp,	#8
	ld	c, (hl)
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:16: sfx_buffer[1] = 0b11111000;
	ld	hl, #_sfx_buffer + 1
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:15: if (channel & CHANNEL_1) { 
	bit	0, c
	jr	Z, 00116$
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:16: sfx_buffer[1] = 0b11111000;
	ld	(hl), #0xf8
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:17: len = 5;
	ld	b, #0x05
	jr	00117$
00116$:
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:18: } else if (channel & CHANNEL_2) { 
	bit	1, c
	jr	Z, 00113$
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:19: sfx_buffer[1] = 0b01111001;
	ld	(hl), #0x79
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:20: len = 4;
	ld	b, #0x04
	jr	00117$
00113$:
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:21: } else if (channel & CHANNEL_3) { 
	bit	2, c
	jr	Z, 00110$
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:22: sfx_buffer[1] = 0b11111010;
	ld	(hl), #0xfa
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:23: len = 5;
	ld	b, #0x05
	jr	00117$
00110$:
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:24: } else if (channel & CHANNEL_4) { 
	bit	3, c
	jr	Z, 00107$
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:25: sfx_buffer[1] = 0b01111011;
	ld	(hl), #0x7b
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:26: len = 4;
	ld	b, #0x04
	jr	00117$
00107$:
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:27: } else if (channel & CHANNEL_5) {
	bit	4, c
	jr	Z, 00104$
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:28: sfx_buffer[1] = 0b11100100;
	ld	(hl), #0xe4
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:29: len = 3;
	ld	b, #0x03
	jr	00117$
00104$:
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:30: } else len = 0;
	ld	b, #0x00
00117$:
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:32: UINT8 *ptr = sfx_buffer + 2;
	ldhl	sp,	#0
	ld	a, #<((_sfx_buffer + 2))
	ld	(hl+), a
	ld	(hl), #>((_sfx_buffer + 2))
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:35: va_start(list, mute_frames);
	ldhl	sp,#10
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00133$:
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:37: *ptr++ = va_arg(list, INT16); // copy len registers to the temporary buffer
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:36: for(; len != 0; --len) {
	ld	a, b
	or	a, a
	jr	Z, 00118$
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:37: *ptr++ = va_arg(list, INT16); // copy len registers to the temporary buffer
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	inc	de
	inc	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	dec	de
	dec	de
	ld	a, (de)
	pop	hl
	push	hl
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:36: for(; len != 0; --len) {
	dec	b
	jr	00133$
00118$:
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:41: *ptr++ = 1; // one packet without delay and terminator
	pop	hl
	ld	(hl), #0x01
	push	hl
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:42: *ptr = 0x07; // add terminator
	ld	a, #0x07
	ld	(de), a
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:44: ExecuteSFX(CURRENT_BANK, sfx_buffer, channel, SFX_PRIORITY_NORMAL);
	ldh	a, (__current_bank + 0)
	ld	b, a
;C:/CrossZGB/ZGB/common/include/Sound.h:98: if (sfx_priority > priority) return;
	ld	a, #0x04
	ld	hl, #_sfx_priority
	sub	a, (hl)
	jr	C, 00135$
;C:/CrossZGB/ZGB/common/include/Sound.h:99: sfx_play_bank = SFX_STOP_BANK;
	ld	hl, #_sfx_play_bank
	ld	(hl), #0xff
;C:/CrossZGB/ZGB/common/include/Sound.h:100: sfx_priority = priority;
	ld	hl, #_sfx_priority
	ld	(hl), #0x04
;C:/CrossZGB/ZGB/common/include/Sound.h:101: sfx_sound_cut_mask(music_mute_mask);
	ld	a, (_music_mute_mask)
	ld	e, a
;C:/CrossZGB/ZGB/common/include/Sound.h:62: if (mask & SFX_CH_1) NR12_REG = 0, NR14_REG = SFX_CH_RETRIGGER;
	rrca
	jr	NC, 00122$
	xor	a, a
	ldh	(_NR12_REG + 0), a
	ld	a, #0xc0
	ldh	(_NR14_REG + 0), a
00122$:
;C:/CrossZGB/ZGB/common/include/Sound.h:63: if (mask & SFX_CH_2) NR22_REG = 0, NR24_REG = SFX_CH_RETRIGGER;
	bit	1, e
	jr	Z, 00124$
	xor	a, a
	ldh	(_NR22_REG + 0), a
	ld	a, #0xc0
	ldh	(_NR24_REG + 0), a
00124$:
;C:/CrossZGB/ZGB/common/include/Sound.h:64: if (mask & SFX_CH_3) NR32_REG = 0;
	bit	2, e
	jr	Z, 00126$
	xor	a, a
	ldh	(_NR32_REG + 0), a
00126$:
;C:/CrossZGB/ZGB/common/include/Sound.h:65: if (mask & SFX_CH_4) NR42_REG = 0, NR44_REG = SFX_CH_RETRIGGER;
	bit	3, e
	jr	Z, 00128$
	xor	a, a
	ldh	(_NR42_REG + 0), a
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
00128$:
;C:/CrossZGB/ZGB/common/include/Sound.h:66: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;C:/CrossZGB/ZGB/common/include/Sound.h:102: music_mute_mask = mute_mask;
	ld	hl, #_music_mute_mask
	ld	(hl), c
;C:/CrossZGB/ZGB/common/include/Sound.h:90: sfx_play_bank = SFX_STOP_BANK, sfx_frame_skip = 0, sfx_play_sample = sample, sfx_play_bank = bank;
	ld	hl, #_sfx_play_bank
	ld	(hl), #0xff
	xor	a, a
	ld	(#_sfx_frame_skip),a
	ld	hl, #_sfx_play_sample
	ld	a, #<(_sfx_buffer)
	ld	(hl+), a
	ld	(hl), #>(_sfx_buffer)
	ld	hl, #_sfx_play_bank
	ld	(hl), b
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:44: ExecuteSFX(CURRENT_BANK, sfx_buffer, channel, SFX_PRIORITY_NORMAL);
00135$:
;C:/CrossZGB/ZGB/common/src/gb/Sound.c:45: }
	add	sp, #6
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
