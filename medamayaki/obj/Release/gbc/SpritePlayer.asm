;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (MINGW64)
;--------------------------------------------------------
	.module SpritePlayer
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _Destroy_SpritePlayer
	.globl _Update_SpritePlayer
	.globl _Start_SpritePlayer
	.globl _PlayerAnimate
	.globl _PlayerDynaCollect
	.globl _PlayerDynaCollide
	.globl _PlayerVelocity
	.globl _DynaTileAt
	.globl _UpdateDynaTile
	.globl b_PlatformerUpdate
	.globl _PlatformerUpdate
	.globl b_SpriteCameraUpdate
	.globl _SpriteCameraUpdate
	.globl _tile_col_test_range_y
	.globl _ScrollScreenRedraw
	.globl _SetSpriteAnim
	.globl _idle_status
	.globl _shoulderbashing_cooldown
	.globl _shoulderbashing
	.globl _knockback_minimum
	.globl _knockback
	.globl _deceling
	.globl _turning
	.globl _falling
	.globl _jumping
	.globl _running
	.globl _jump_extra_count
	.globl _jump_add
	.globl ___bank_SpritePlayer
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_jump_add::
	.ds 1
_jump_extra_count::
	.ds 1
_running::
	.ds 1
_jumping::
	.ds 1
_falling::
	.ds 1
_turning::
	.ds 1
_deceling::
	.ds 1
_knockback::
	.ds 1
_knockback_minimum::
	.ds 1
_shoulderbashing::
	.ds 1
_shoulderbashing_cooldown::
	.ds 1
_idle_status::
	.ds 1
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
;SpritePlayer.c:61: void PlayerVelocity(Sprite* this) {
;	---------------------------------
; Function PlayerVelocity
; ---------------------------------
_PlayerVelocity::
	add	sp, #-12
;SpritePlayer.c:63: CUSTOM_DATA* data = (CUSTOM_DATA*)this->custom_data;
	ld	hl, #0x0024
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
;SpritePlayer.c:75: if (data->grounded) {
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
;SpritePlayer.c:79: data->vel.y = JUMP_VEL_Y;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
;SpritePlayer.c:66: if (!knockback) {
	ld	a, (#_knockback)
	or	a, a
	jr	NZ, 00116$
;SpritePlayer.c:67: if (KEY_PRESSED(INPUT_JUMP)) {
	ld	hl, #(_joypads + 1)
	ld	c, (hl)
	bit	4, c
	jr	Z, 00113$
;SpritePlayer.c:68: switch (jumping) {
	ld	a, (#_jumping)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_jumping)
	dec	a
	jr	Z, 00106$
	jr	00117$
;SpritePlayer.c:69: case 0:		// Jumping = 0: Not jumping.
00101$:
;SpritePlayer.c:70: if (KEY_TICKED(INPUT_JUMP)) {
	ld	a, (#(_old_joypads + 1) + 0)
	xor	a, c
	and	a, c
	bit	4, a
	jr	Z, 00117$
;SpritePlayer.c:75: if (data->grounded) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00117$
;SpritePlayer.c:78: data->grounded = 0;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x00
;SpritePlayer.c:79: data->vel.y = JUMP_VEL_Y;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, #0x20
	ld	(hl+), a
	ld	(hl), #0xd1
;SpritePlayer.c:81: jumping = 1;
	ld	hl, #_jumping
	ld	(hl), #0x01
;SpritePlayer.c:82: jump_add = JUMP_ADD_FRAMES;
	ld	hl, #_jump_add
	ld	(hl), #0x0c
;SpritePlayer.c:90: break;
	jr	00117$
;SpritePlayer.c:91: case 1:		// Jumping = 1: Applying vertical velocity while holding A (Skipped if JUMP_ADD_FRAMES is 0)
00106$:
;SpritePlayer.c:92: data->vel.y += JUMP_VEL_Y_ADD;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	add	a, #0xfe
	ld	b, a
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;SpritePlayer.c:93: if (--jump_add == 0) jumping = 2;
	ld	hl, #_jump_add
	dec	(hl)
	jr	NZ, 00117$
	ld	hl, #_jumping
	ld	(hl), #0x02
;SpritePlayer.c:96: }
	jr	00117$
00113$:
;SpritePlayer.c:97: } else if (jumping > 0) {
	ld	hl, #_jumping
	ld	a, (hl)
	or	a, a
	jr	Z, 00117$
;SpritePlayer.c:98: jumping = 0;
	ld	(hl), #0x00
;SpritePlayer.c:99: falling = 1;
	ld	hl, #_falling
	ld	(hl), #0x01
	jr	00117$
00116$:
;SpritePlayer.c:102: jumping = 0;
	xor	a, a
	ld	(#_jumping),a
00117$:
;SpritePlayer.c:92: data->vel.y += JUMP_VEL_Y_ADD;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
;SpritePlayer.c:111: if (!jumping) {
	ld	a, (#_jumping)
	or	a, a
	jr	NZ, 00121$
;SpritePlayer.c:113: data->vel.y = MIN(data->vel.y + ACCELERATION_VEL_Y, MAX_VEL_Y);
	ld	hl, #0x0708
	add	hl, bc
	ld	a, l
	sub	a, #0xb0
	ld	a, h
	rla
	ccf
	rra
	sbc	a, #0xb6
	jr	NC, 00184$
	ld	c, l
	ld	b, h
	jr	00185$
00184$:
	ld	bc, #0x36b0
00185$:
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00122$
00121$:
;SpritePlayer.c:116: data->vel.y = MIN(data->vel.y + ACCELERATION_VEL_Y_HELD, MAX_VEL_Y);
	ld	hl, #0x0258
	add	hl, bc
	ld	a, l
	sub	a, #0xb0
	ld	a, h
	rla
	ccf
	rra
	sbc	a, #0xb6
	jr	NC, 00186$
	ld	c, l
	ld	b, h
	jr	00187$
00186$:
	ld	bc, #0x36b0
00187$:
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;SpritePlayer.c:117: if (data->vel.y >= 0) {
	bit	7, b
	jr	NZ, 00122$
;SpritePlayer.c:118: jumping = 0;
	xor	a, a
	ld	(#_jumping),a
;SpritePlayer.c:119: falling = 1;
	ld	hl, #_falling
	ld	(hl), #0x01
00122$:
;SpritePlayer.c:125: running = turning = deceling = 0;
	xor	a, a
	ld	(#_deceling), a
	ld	(#_turning),a
	xor	a, a
	ld	(#_running),a
;SpritePlayer.c:126: INT16 prev_vel_x = data->vel.x;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;SpritePlayer.c:127: if ((!shoulderbashing_cooldown) || (--shoulderbashing_cooldown == 0)) {
	ld	hl, #_shoulderbashing_cooldown
	ld	a, (hl)
	or	a, a
	jr	Z, 00127$
	dec	(hl)
	jr	NZ, 00128$
00127$:
;SpritePlayer.c:128: if ((KEY_TICKED(J_B)) && (data->grounded) && (!shoulderbashing)) {
	ld	hl, #(_joypads + 1)
	ld	c, (hl)
	ld	a, (#(_old_joypads + 1) + 0)
	xor	a, c
	and	a, c
	bit	5, a
	jr	Z, 00128$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00128$
	ld	hl, #_shoulderbashing
	ld	a, (hl)
	or	a, a
	jr	NZ, 00128$
;SpritePlayer.c:129: shoulderbashing = SHOULDERBASH_TIME;
	ld	(hl), #0x28
00128$:
;SpritePlayer.c:134: if ((data->grounded) && (((KEY_TICKED(J_LEFT)) && (data->dir > 0)) || ((KEY_TICKED(J_RIGHT)) && (data->dir < 0)))) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	inc	sp
	inc	sp
	push	hl
;SpritePlayer.c:133: if (shoulderbashing) {
	ld	a, (#_shoulderbashing)
	or	a, a
	jp	Z, 00173$
;SpritePlayer.c:134: if ((data->grounded) && (((KEY_TICKED(J_LEFT)) && (data->dir > 0)) || ((KEY_TICKED(J_RIGHT)) && (data->dir < 0)))) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
;SpritePlayer.c:167: if (((prev_vel_x ^ data->dir) < 0) && (data->vel.x != 0)) {	// Turning
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
;SpritePlayer.c:134: if ((data->grounded) && (((KEY_TICKED(J_LEFT)) && (data->dir > 0)) || ((KEY_TICKED(J_RIGHT)) && (data->dir < 0)))) {
	ld	a, b
	or	a, a
	jr	Z, 00136$
	ld	hl, #(_joypads + 1)
	ld	b, (hl)
	ld	a, (#(_old_joypads + 1) + 0)
	xor	a, b
	and	a, b
	ld	b, a
	bit	1, b
	jr	Z, 00140$
	ld	e, c
	xor	a, a
	ld	d, a
	sub	a, c
	bit	7, e
	jr	Z, 00501$
	bit	7, d
	jr	NZ, 00502$
	cp	a, a
	jr	00502$
00501$:
	bit	7, d
	jr	Z, 00502$
	scf
00502$:
	jr	C, 00135$
00140$:
	bit	0, b
	jr	Z, 00136$
	bit	7, c
	jr	Z, 00136$
00135$:
;SpritePlayer.c:135: data->vel.x = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;SpritePlayer.c:136: shoulderbashing = 0;
	xor	a, a
	ld	(#_shoulderbashing),a
;SpritePlayer.c:137: shoulderbashing_cooldown = SHOULDERBASH_COOLDOWN;
	ld	hl, #_shoulderbashing_cooldown
	ld	(hl), #0x10
	jp	00174$
00136$:
;SpritePlayer.c:139: data->vel.x = SHOULDERBASH_VEL_X * data->dir;
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;SpritePlayer.c:140: if (shoulderbashing == 1) {
	ld	a, (#_shoulderbashing)
	dec	a
	jr	NZ, 00133$
;SpritePlayer.c:141: if (data->grounded) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00174$
;SpritePlayer.c:142: shoulderbashing = 0;
	xor	a, a
	ld	(#_shoulderbashing),a
;SpritePlayer.c:143: shoulderbashing_cooldown = SHOULDERBASH_COOLDOWN;
	ld	hl, #_shoulderbashing_cooldown
	ld	(hl), #0x10
	jp	00174$
00133$:
;SpritePlayer.c:146: shoulderbashing--;
	ld	hl, #_shoulderbashing
	dec	(hl)
	jp	00174$
00173$:
;SpritePlayer.c:150: if ((KEY_PRESSED(J_LEFT | J_RIGHT)) && (!knockback)) {
	ld	hl, #(_joypads + 1)
	ld	c, (hl)
	ld	a, c
	and	a, #0x03
	jp	Z, 00169$
	ld	a, (#_knockback)
	or	a, a
	jp	NZ, 00169$
;SpritePlayer.c:152: if (KEY_PRESSED(J_LEFT)) {
	bit	1, c
	jr	Z, 00143$
;SpritePlayer.c:153: data->dir = -1;
	pop	hl
	ld	(hl), #0xff
	push	hl
;SpritePlayer.c:154: data->vel.x = -data->vel.x;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00144$
00143$:
;SpritePlayer.c:156: data->dir = 1;
	pop	hl
	ld	(hl), #0x01
	push	hl
00144$:
;SpritePlayer.c:167: if (((prev_vel_x ^ data->dir) < 0) && (data->vel.x != 0)) {	// Turning
	pop	de
	push	de
	ld	a, (de)
	rlca
	sbc	a, a
	ld	e, a
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	a, (hl)
	xor	a, e
	bit	7,a
	jr	Z, 00146$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	or	a, c
	jr	Z, 00146$
;SpritePlayer.c:168: turning = 1;
	ld	hl, #_turning
	ld	(hl), #0x01
	jp	00153$
00146$:
;SpritePlayer.c:170: turning = 0;
	xor	a, a
	ld	(#_turning),a
;SpritePlayer.c:126: INT16 prev_vel_x = data->vel.x;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
;SpritePlayer.c:183: if (data->vel.x > MAX_VEL_X_WALK) {
	ld	(hl-), a
	ld	a, #0x58
	sub	a, (hl)
	inc	hl
	ld	a, #0x1b
	sbc	a, (hl)
	ld	a, #0x1b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00508$
	bit	7, d
	jr	NZ, 00509$
	cp	a, a
	jr	00509$
00508$:
	bit	7, d
	jr	Z, 00509$
	scf
00509$:
	jr	NC, 00150$
;SpritePlayer.c:184: data->vel.x = MAX(data->vel.x - DECELERATION_VEL_X, MAX_VEL_X_WALK);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0200
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	ld	a, #0x58
	sub	a, (hl)
	inc	hl
	ld	a, #0x1b
	sbc	a, (hl)
	ld	a, #0x1b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00510$
	bit	7, d
	jr	NZ, 00511$
	cp	a, a
	jr	00511$
00510$:
	bit	7, d
	jr	Z, 00511$
	scf
00511$:
	jr	NC, 00188$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00189$
00188$:
	ld	de, #0x1b58
00189$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00154$
00150$:
;SpritePlayer.c:186: data->vel.x = MIN(data->vel.x + ACCELERATION_VEL_X, MAX_VEL_X_WALK);
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0100
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, c
	sub	a, #0x58
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x9b
	jr	C, 00191$
	ld	bc, #0x1b58
00191$:
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00154$
00153$:
;SpritePlayer.c:192: data->vel.x += ACCELERATION_VEL_X_TURN;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	add	a, #0x08
	ld	b, a
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00154$:
;SpritePlayer.c:195: if (data->dir < 0) {
	pop	de
	push	de
	ld	a, (de)
	bit	7,a
	jp	Z, 00174$
;SpritePlayer.c:196: data->vel.x = -data->vel.x;
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jp	00174$
00169$:
;SpritePlayer.c:199: } else if (data->vel.x != 0) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	or	a, c
	jp	Z, 00174$
;SpritePlayer.c:200: deceling = 1;
	ld	hl, #_deceling
	ld	(hl), #0x01
;SpritePlayer.c:201: if (data->vel.x > 0) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
;SpritePlayer.c:134: if ((data->grounded) && (((KEY_TICKED(J_LEFT)) && (data->dir > 0)) || ((KEY_TICKED(J_RIGHT)) && (data->dir < 0)))) {
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#11
	ld	(hl), a
;SpritePlayer.c:201: if (data->vel.x > 0) {
	ldhl	sp,	#0
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00512$
	bit	7, d
	jr	NZ, 00513$
	cp	a, a
	jr	00513$
00512$:
	bit	7, d
	jr	Z, 00513$
	scf
00513$:
	jp	NC, 00164$
;SpritePlayer.c:202: if (data->grounded) {
	ldhl	sp,	#11
	ld	a, (hl)
	or	a, a
	jr	Z, 00158$
;SpritePlayer.c:203: data->vel.x = MAX(data->vel.x - DECELERATION_VEL_X, 0);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	ld	hl, #0x0200
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00514$
	bit	7, d
	jr	NZ, 00515$
	cp	a, a
	jr	00515$
00514$:
	bit	7, d
	jr	Z, 00515$
	scf
00515$:
	jr	NC, 00192$
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00193$
00192$:
	ld	de, #0x0000
00193$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jp	00174$
00158$:
;SpritePlayer.c:205: data->vel.x = MAX(data->vel.x - DECELERATION_VEL_X_AIR, 0);
	ldhl	sp,	#6
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	pop	de
	push	de
	ld	hl, #0x0100
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00516$
	bit	7, d
	jr	NZ, 00517$
	cp	a, a
	jr	00517$
00516$:
	bit	7, d
	jr	Z, 00517$
	scf
00517$:
	jr	C, 00195$
	xor	a, a
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), a
00195$:
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	jr	00174$
00164$:
;SpritePlayer.c:208: if (data->grounded) {
	ldhl	sp,	#11
	ld	a, (hl)
	or	a, a
	jr	Z, 00161$
;SpritePlayer.c:209: data->vel.x = MIN(data->vel.x + DECELERATION_VEL_X, 0);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	ld	hl, #0x0200
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00196$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00197$
00196$:
	ld	de, #0x0000
00197$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
	jr	00174$
00161$:
;SpritePlayer.c:211: data->vel.x = MIN(data->vel.x + DECELERATION_VEL_X_AIR, 0);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	pop	de
	push	de
	ld	hl, #0x0100
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00198$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	jr	00199$
00198$:
	ld	de, #0x0000
00199$:
	ld	a, e
	ld	(bc), a
	inc	bc
	ld	a, d
	ld	(bc), a
00174$:
;SpritePlayer.c:217: if (knockback) {
	ld	a, (#_knockback)
	or	a, a
	jr	Z, 00182$
;SpritePlayer.c:218: if ((!knockback_minimum) || (--knockback_minimum == 0)) {
	ld	hl, #_knockback_minimum
	ld	a, (hl)
	or	a, a
	jr	Z, 00177$
	dec	(hl)
	jr	NZ, 00182$
00177$:
;SpritePlayer.c:219: if (data->grounded) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00182$
;SpritePlayer.c:220: knockback = FALSE;
	xor	a, a
	ld	(#_knockback),a
;SpritePlayer.c:221: data->vel.x = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;SpritePlayer.c:222: data->vel.y = 0;
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00182$:
;SpritePlayer.c:227: }
	add	sp, #12
	ret
___bank_SpritePlayer	=	0x00ff
_anim_idle:
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
_anim_doze:
	.db #0x04	; 4
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
_anim_sleep:
	.db #0x0c	; 12
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
_anim_walk:
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0a	; 10
_anim_jump:
	.db #0x01	; 1
	.db #0x0b	; 11
_anim_bash:
	.db #0x04	; 4
	.db #0x0c	; 12
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
_anim_bash_knockback:
	.db #0x01	; 1
	.db #0x10	; 16
;SpritePlayer.c:229: void PlayerDynaCollide(Sprite* this) {
;	---------------------------------
; Function PlayerDynaCollide
; ---------------------------------
_PlayerDynaCollide::
	add	sp, #-16
	ldhl	sp,	#12
	ld	a, e
	ld	(hl+), a
;SpritePlayer.c:230: CUSTOM_DATA* data = (CUSTOM_DATA*)this->custom_data;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0024
	add	hl, de
	inc	sp
	inc	sp
;SpritePlayer.c:232: if (data->vel.x > 0) {
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	inc	de
	ld	a, (de)
	ld	c, a
	ld	e, c
	xor	a, a
	ld	d, a
	cp	a, b
	sbc	a, c
	bit	7, e
	jr	Z, 00614$
	bit	7, d
	jr	NZ, 00615$
	cp	a, a
	jr	00615$
00614$:
	bit	7, d
	jr	Z, 00615$
	scf
00615$:
	ld	a, #0x00
	rla
	ldhl	sp,	#11
	ld	(hl), a
	or	a, a
	jr	Z, 00102$
;SpritePlayer.c:233: tile_x = SUBPX_TO_TILE(data->pos.x + VEL_TO_SUBPX(data->vel.x) + PX_TO_SUBPX(this->coll_w) - 1);
	pop	de
	push	de
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	h, #0x00
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	dec	bc
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	jr	00103$
00102$:
;SpritePlayer.c:235: tile_x = SUBPX_TO_TILE(data->pos.x + VEL_TO_SUBPX(data->vel.x));
	pop	de
	push	de
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, c
	rlca
	sbc	a, a
	ld	b, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
00103$:
;SpritePlayer.c:237: UINT16 tile_y = SUBPX_TO_TILE(data->pos.y);
	pop	bc
	push	bc
	inc	bc
	inc	bc
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#14
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
;SpritePlayer.c:238: UINT16 tile_y_end = SUBPX_TO_TILE(data->pos.y + PX_TO_SUBPX(this->coll_h) - 1) - 1;	// Subtract one tile to get some leeway
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	b, a
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	dec	hl
	xor	a, a
	add	hl, hl
	rla
	ld	d, a
	ld	e, h
	dec	de
;SpritePlayer.c:239: if (tile_col_test_range_y((data->vel.x > 0) ? COLLISION_LEFT : COLLISION_RIGHT, tile_x, tile_y, tile_y_end)) {
	ldhl	sp,	#11
	ld	a, (hl)
	or	a, a
	ld	a, #0x04
	jr	NZ, 00218$
	ld	a, #0x08
00218$:
	push	de
	push	bc
	ldhl	sp,	#8
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_tile_col_test_range_y
	or	a, a
	jp	Z, 00215$
;SpritePlayer.c:240: switch (DynaTileAt(tile_x, tile_hit_y)) {
	ld	a, (_tile_hit_y)
	ld	c, a
	ld	hl, #_tile_hit_y + 1
	ld	b, (hl)
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_DynaTileAt
	cp	a, #0x1c
	jp	C, 00140$
	cp	a, #0x30
	jp	NC, 00140$
	add	a, #0xe4
	ld	c, a
	ld	b, #0x00
	ld	hl, #00616$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00616$:
	.dw	00227$
	.dw	00235$
	.dw	00231$
	.dw	00239$
	.dw	00243$
	.dw	00140$
	.dw	00140$
	.dw	00259$
	.dw	00247$
	.dw	00140$
	.dw	00140$
	.dw	00263$
	.dw	00251$
	.dw	00140$
	.dw	00140$
	.dw	00267$
	.dw	00255$
	.dw	00140$
	.dw	00140$
	.dw	00271$
;SpritePlayer.c:242: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
00227$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00147$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x02
	jp	NC, 00140$
;SpritePlayer.c:243: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00144$:
	ldhl	sp,	#15
;SpritePlayer.c:244: UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y, 0);
	ld	a,(hl)
	cp	a,#0x02
	jr	NC, 00148$
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_tile_hit_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_UpdateDynaTile
;SpritePlayer.c:243: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00144$
00148$:
;SpritePlayer.c:242: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00147$
;SpritePlayer.c:249: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
00231$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00153$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x02
	jp	NC, 00140$
;SpritePlayer.c:250: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00150$:
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, #0x02
	jr	NC, 00154$
;SpritePlayer.c:251: UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y - 1, 0);
	ld	c, (hl)
	ld	b, #0x00
	ld	a, c
	ld	hl, #_tile_hit_y
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
	dec	bc
	ldhl	sp,	#14
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	xor	a, a
	push	af
	inc	sp
	call	_UpdateDynaTile
;SpritePlayer.c:250: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00150$
00154$:
;SpritePlayer.c:249: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00153$
;SpritePlayer.c:256: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
00235$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00159$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x02
	jp	NC, 00140$
;SpritePlayer.c:257: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00156$:
	ldhl	sp,	#15
;SpritePlayer.c:258: UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y, 0);
	ld	a,(hl)
	cp	a,#0x02
	jr	NC, 00160$
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_tile_hit_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#14
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, e
	ld	(hl-), a
	dec	hl
	xor	a, a
	push	af
	inc	sp
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_UpdateDynaTile
;SpritePlayer.c:257: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00156$
00160$:
;SpritePlayer.c:256: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00159$
;SpritePlayer.c:263: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
00239$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00165$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x02
	jp	NC, 00140$
;SpritePlayer.c:264: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00162$:
	ldhl	sp,	#15
;SpritePlayer.c:265: UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y - 1, 0);
	ld	a,(hl)
	cp	a,#0x02
	jr	NC, 00166$
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_tile_hit_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	xor	a, a
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_UpdateDynaTile
;SpritePlayer.c:264: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00162$
00166$:
;SpritePlayer.c:263: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00165$
;SpritePlayer.c:270: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
00243$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00171$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00140$
;SpritePlayer.c:271: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00168$:
	ldhl	sp,	#15
;SpritePlayer.c:272: UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y, 0);
	ld	a,(hl)
	cp	a,#0x04
	jr	NC, 00172$
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_tile_hit_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#14
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_UpdateDynaTile
;SpritePlayer.c:271: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00168$
00172$:
;SpritePlayer.c:270: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00171$
;SpritePlayer.c:277: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
00247$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00177$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00140$
;SpritePlayer.c:278: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00174$:
	ldhl	sp,	#15
;SpritePlayer.c:279: UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y - 1, 0);
	ld	a,(hl)
	cp	a,#0x04
	jr	NC, 00178$
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_tile_hit_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	ldhl	sp,	#14
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	xor	a, a
	push	af
	inc	sp
	call	_UpdateDynaTile
;SpritePlayer.c:278: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00174$
00178$:
;SpritePlayer.c:277: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00177$
;SpritePlayer.c:284: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
00251$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00183$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00140$
;SpritePlayer.c:285: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00180$:
	ldhl	sp,	#15
;SpritePlayer.c:286: UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y - 2, 0);
	ld	a,(hl)
	cp	a,#0x04
	jr	NC, 00184$
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_tile_hit_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	dec	bc
	ldhl	sp,	#14
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	xor	a, a
	push	af
	inc	sp
	call	_UpdateDynaTile
;SpritePlayer.c:285: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00180$
00184$:
;SpritePlayer.c:284: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00183$
;SpritePlayer.c:291: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
00255$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00189$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00140$
;SpritePlayer.c:292: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00186$:
	ldhl	sp,	#15
;SpritePlayer.c:293: UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y - 3, 0);
	ld	a,(hl)
	cp	a,#0x04
	jr	NC, 00190$
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_tile_hit_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
	ldhl	sp,	#14
	ld	e, (hl)
	ld	d, #0x00
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	xor	a, a
	push	af
	inc	sp
	call	_UpdateDynaTile
;SpritePlayer.c:292: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00186$
00190$:
;SpritePlayer.c:291: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00189$
;SpritePlayer.c:298: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
00259$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00195$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00140$
;SpritePlayer.c:299: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00192$:
	ldhl	sp,	#15
;SpritePlayer.c:300: UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y, 0);
	ld	a,(hl)
	cp	a,#0x04
	jr	NC, 00196$
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_tile_hit_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#14
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, e
	ld	(hl-), a
	dec	hl
	xor	a, a
	push	af
	inc	sp
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_UpdateDynaTile
;SpritePlayer.c:299: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00192$
00196$:
;SpritePlayer.c:298: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00195$
;SpritePlayer.c:305: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
00263$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00201$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00140$
;SpritePlayer.c:306: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00198$:
	ldhl	sp,	#15
;SpritePlayer.c:307: UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y - 1, 0);
	ld	a,(hl)
	cp	a,#0x04
	jr	NC, 00202$
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_tile_hit_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	xor	a, a
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_UpdateDynaTile
;SpritePlayer.c:306: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00198$
00202$:
;SpritePlayer.c:305: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00201$
;SpritePlayer.c:312: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
00267$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00207$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00140$
;SpritePlayer.c:313: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00204$:
	ldhl	sp,	#15
;SpritePlayer.c:314: UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y - 2, 0);
	ld	a,(hl)
	cp	a,#0x04
	jr	NC, 00208$
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_tile_hit_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	dec	bc
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	xor	a, a
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_UpdateDynaTile
;SpritePlayer.c:313: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00204$
00208$:
;SpritePlayer.c:312: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00207$
;SpritePlayer.c:319: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
00271$:
	ldhl	sp,	#14
	ld	(hl), #0x00
00213$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00140$
;SpritePlayer.c:320: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00210$:
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00214$
;SpritePlayer.c:321: UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y - 3, 0);
	ld	c, (hl)
	ld	b, #0x00
	ld	a, c
	ld	hl, #_tile_hit_y
	add	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	adc	a, (hl)
	ld	b, a
	ld	a, c
	add	a, #0xfd
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	xor	a, a
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_UpdateDynaTile
;SpritePlayer.c:320: for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
	ldhl	sp,	#15
	inc	(hl)
	jr	00210$
00214$:
;SpritePlayer.c:319: for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00213$
;SpritePlayer.c:325: }
00140$:
;SpritePlayer.c:333: knockback = 1;
	ld	hl, #_knockback
	ld	(hl), #0x01
;SpritePlayer.c:334: knockback_minimum = KNOCKBACK_MINIMUM;
	ld	hl, #_knockback_minimum
	ld	(hl), #0x08
;SpritePlayer.c:335: shoulderbashing = 0;
	xor	a, a
	ld	(#_shoulderbashing),a
;SpritePlayer.c:336: shoulderbashing_cooldown = SHOULDERBASH_COOLDOWN;
	ld	hl, #_shoulderbashing_cooldown
	ld	(hl), #0x10
;SpritePlayer.c:337: data->vel.x = -KNOCKBACK_VEL_X * data->dir;
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
	inc	hl
	ld	(hl), b
;SpritePlayer.c:338: data->vel.y = KNOCKBACK_VEL_Y;
	pop	de
	push	de
	ld	hl, #0x0006
	add	hl, de
	ld	b,l
	ld	c,h
	ld	(hl), #0x68
	inc	hl
	ld	(hl), #0xc5
00215$:
;SpritePlayer.c:340: }
	add	sp, #16
	ret
;SpritePlayer.c:342: void PlayerDynaCollect(Sprite* this) {
;	---------------------------------
; Function PlayerDynaCollect
; ---------------------------------
_PlayerDynaCollect::
	add	sp, #-12
	ld	c, e
	ld	b, d
;SpritePlayer.c:344: UINT16 tile_x_end = PX_TO_TILE(this->x + this->coll_w - 1 - COLLECT_OFFSET);
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, c
	add	a, #0x04
	ld	e, a
	ld	a, b
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ld	d, #0x00
	ld	e, a
	add	hl, de
	ld	de, #0xfffb
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;SpritePlayer.c:345: UINT16 tile_y_end = PX_TO_TILE(this->y + this->coll_h - 1 - COLLECT_OFFSET);
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	hl, #0x0005
	add	hl, bc
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, c
	add	a, #0xfb
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
;SpritePlayer.c:346: for (UINT16 tile_y = PX_TO_TILE(this->y + COLLECT_OFFSET); tile_y <= tile_y_end; tile_y++) {
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	srl	(hl)
	dec	hl
	rr	(hl)
00152$:
	ldhl	sp,	#6
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jp	C, 00154$
;SpritePlayer.c:347: for (UINT16 tile_x = PX_TO_TILE(this->x + COLLECT_OFFSET); tile_x <= tile_x_end; tile_x++) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
00149$:
	ldhl	sp,	#4
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jp	C, 00153$
;SpritePlayer.c:348: switch (DynaTileAt(tile_x, tile_y)) {
	push	de
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_DynaTileAt
	ld	c, a
	pop	de
	ld	a, #0x0c
	sub	a, c
	jp	C, 00150$
	ld	b, #0x00
	ld	hl, #00313$
	add	hl, bc
	add	hl, bc
	ld	c, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, c
	jp	(hl)
00313$:
	.dw	00150$
	.dw	00162$
	.dw	00166$
	.dw	00170$
	.dw	00174$
	.dw	00162$
	.dw	00166$
	.dw	00170$
	.dw	00174$
	.dw	00162$
	.dw	00166$
	.dw	00170$
	.dw	00174$
;SpritePlayer.c:352: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
00162$:
	ldhl	sp,	#10
	ld	(hl), #0x00
00128$:
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x02
	jp	NC, 00150$
;SpritePlayer.c:353: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00125$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x02
	jr	NC, 00129$
;SpritePlayer.c:354: UpdateDynaTile(tile_x + offset_x, tile_y + offset_y, 0);
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	e, l
	ld	d, h
	call	_UpdateDynaTile
	pop	de
;SpritePlayer.c:353: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	ldhl	sp,	#11
	inc	(hl)
	jr	00125$
00129$:
;SpritePlayer.c:352: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
	ldhl	sp,	#10
	inc	(hl)
	jr	00128$
;SpritePlayer.c:361: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
00166$:
	ldhl	sp,	#10
	ld	(hl), #0x00
00134$:
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x02
	jp	NC, 00150$
;SpritePlayer.c:362: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00131$:
	ldhl	sp,	#11
;SpritePlayer.c:363: UpdateDynaTile(tile_x - offset_x, tile_y + offset_y, 0);
	ld	a,(hl)
	cp	a,#0x02
	jr	NC, 00135$
	ldhl	sp,	#0
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	l, (hl)
	ld	h, #0x00
	ld	a, e
	sub	a, l
	ld	l, a
	ld	a, d
	sbc	a, h
	ld	h, a
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	e, l
	ld	d, h
	call	_UpdateDynaTile
	pop	de
;SpritePlayer.c:362: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	ldhl	sp,	#11
	inc	(hl)
	jr	00131$
00135$:
;SpritePlayer.c:361: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
	ldhl	sp,	#10
	inc	(hl)
	jr	00134$
;SpritePlayer.c:370: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
00170$:
	ldhl	sp,	#10
	ld	(hl), #0x00
00140$:
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x02
	jr	NC, 00150$
;SpritePlayer.c:371: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00137$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x02
	jr	NC, 00141$
;SpritePlayer.c:372: UpdateDynaTile(tile_x + offset_x, tile_y + offset_y - 1, 0);
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	dec	bc
	ldhl	sp,	#10
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	e, l
	ld	d, h
	call	_UpdateDynaTile
	pop	de
;SpritePlayer.c:371: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	ldhl	sp,	#11
	inc	(hl)
	jr	00137$
00141$:
;SpritePlayer.c:370: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
	ldhl	sp,	#10
	inc	(hl)
	jr	00140$
;SpritePlayer.c:379: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
00174$:
	ldhl	sp,	#10
	ld	(hl), #0x00
00146$:
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x02
	jr	NC, 00150$
;SpritePlayer.c:380: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	inc	hl
	ld	(hl), #0x00
00143$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x02
	jr	NC, 00147$
;SpritePlayer.c:381: UpdateDynaTile(tile_x - offset_x, tile_y + offset_y - 1, 0);
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	dec	bc
	ldhl	sp,	#10
	ld	l, (hl)
	ld	h, #0x00
	ld	a, e
	sub	a, l
	ld	l, a
	ld	a, d
	sbc	a, h
	ld	h, a
	push	de
	xor	a, a
	push	af
	inc	sp
	ld	e, l
	ld	d, h
	call	_UpdateDynaTile
	pop	de
;SpritePlayer.c:380: for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
	ldhl	sp,	#11
	inc	(hl)
	jr	00143$
00147$:
;SpritePlayer.c:379: for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
	ldhl	sp,	#10
	inc	(hl)
	jr	00146$
;SpritePlayer.c:385: }
00150$:
;SpritePlayer.c:347: for (UINT16 tile_x = PX_TO_TILE(this->x + COLLECT_OFFSET); tile_x <= tile_x_end; tile_x++) {
	inc	de
	jp	00149$
00153$:
;SpritePlayer.c:346: for (UINT16 tile_y = PX_TO_TILE(this->y + COLLECT_OFFSET); tile_y <= tile_y_end; tile_y++) {
	ldhl	sp,	#8
	inc	(hl)
	jp	NZ, 00152$
	inc	hl
	inc	(hl)
	jp	00152$
00154$:
;SpritePlayer.c:389: }
	add	sp, #12
	ret
;SpritePlayer.c:391: void PlayerAnimate(Sprite* this) {
;	---------------------------------
; Function PlayerAnimate
; ---------------------------------
_PlayerAnimate::
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
;SpritePlayer.c:392: CUSTOM_DATA* data = (CUSTOM_DATA*)this->custom_data;
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0024
	add	hl, de
	inc	sp
	inc	sp
	push	hl
;C:/CrossZGB/ZGB/common/include/Sprite.h:106: sprite->loop_anim = (loop_anim);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0021
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	and	a, #0xfb
	ld	(bc), a
;SpritePlayer.c:407: if (this->anim_frame == ANIM_STOP) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
;SpritePlayer.c:394: if (knockback) {
	ld	a, (#_knockback)
	or	a, a
	jr	Z, 00119$
;SpritePlayer.c:395: SetSpriteAnim(this, anim_bash_knockback, 0);
	xor	a, a
	push	af
	inc	sp
	ld	bc, #_anim_bash_knockback
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_SetSpriteAnim
	jp	00120$
00119$:
;SpritePlayer.c:396: } else if (shoulderbashing) {
	ld	a, (#_shoulderbashing)
	or	a, a
	jr	Z, 00116$
;C:/CrossZGB/ZGB/common/include/Sprite.h:106: sprite->loop_anim = (loop_anim);
	ld	a, (bc)
	or	a, #0x04
	ld	(bc), a
;SpritePlayer.c:398: SetSpriteAnim(this, anim_bash, 20);
	ld	a, #0x14
	push	af
	inc	sp
	ld	bc, #_anim_bash
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_SetSpriteAnim
	jp	00120$
00116$:
;SpritePlayer.c:399: } else if (data->grounded) {
	pop	de
	push	de
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jp	Z, 00113$
;SpritePlayer.c:400: if (data->vel.x) {
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	or	a, l
	jr	Z, 00110$
;C:/CrossZGB/ZGB/common/include/Sprite.h:106: sprite->loop_anim = (loop_anim);
	ld	a, (bc)
	or	a, #0x04
	ld	(bc), a
;SpritePlayer.c:402: SetSpriteAnim(this, anim_walk, 20);
	ld	a, #0x14
	push	af
	inc	sp
	ld	bc, #_anim_walk
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_SetSpriteAnim
	jp	00120$
00110$:
;SpritePlayer.c:407: if (this->anim_frame == ANIM_STOP) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0013
	add	hl, de
	ld	e, l
	ld	d, h
;SpritePlayer.c:404: switch (idle_status) {
	ld	a, (#_idle_status)
	or	a, a
	jr	Z, 00101$
	ld	a, (#_idle_status)
	dec	a
	jr	Z, 00104$
	ld	a, (#_idle_status)
	sub	a, #0x02
	jp	Z, 00107$
	jp	00120$
;SpritePlayer.c:405: case 0:
00101$:
;SpritePlayer.c:406: SetSpriteAnim(this, anim_idle, 1);
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	ld	bc, #_anim_idle
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_SetSpriteAnim
	pop	de
;SpritePlayer.c:407: if (this->anim_frame == ANIM_STOP) {
	ld	a, (de)
	ld	c, a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	l, (hl)
	xor	a, a
	ld	h, a
	dec	hl
	ld	b, #0x00
	ld	a, l
	sub	a, c
	jr	NZ, 00120$
	ld	a, h
	sub	a, b
	jr	NZ, 00120$
;SpritePlayer.c:408: SetSpriteAnim(this, anim_doze, 2);
	ld	a, #0x02
	push	af
	inc	sp
	ld	bc, #_anim_doze
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_SetSpriteAnim
;SpritePlayer.c:409: idle_status = 1;
	ld	hl, #_idle_status
	ld	(hl), #0x01
;SpritePlayer.c:411: break;
	jr	00120$
;SpritePlayer.c:412: case 1:
00104$:
;SpritePlayer.c:413: if (this->anim_frame == ANIM_STOP) {
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	e, (hl)
	xor	a, a
	ld	d, a
	dec	de
	ldhl	sp,	#5
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00120$
	xor	a, a
	sub	a, d
	jr	NZ, 00120$
;C:/CrossZGB/ZGB/common/include/Sprite.h:106: sprite->loop_anim = (loop_anim);
	ld	a, (bc)
	or	a, #0x04
	ld	(bc), a
;SpritePlayer.c:415: SetSpriteAnim(this, anim_sleep, 7);
	ld	a, #0x07
	push	af
	inc	sp
	ld	bc, #_anim_sleep
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_SetSpriteAnim
;SpritePlayer.c:416: idle_status = 2;
	ld	hl, #_idle_status
	ld	(hl), #0x02
;SpritePlayer.c:418: break;
	jr	00120$
;SpritePlayer.c:419: case 2:
00107$:
;C:/CrossZGB/ZGB/common/include/Sprite.h:106: sprite->loop_anim = (loop_anim);
	ld	a, (bc)
	or	a, #0x04
	ld	(bc), a
;SpritePlayer.c:422: }
	jr	00120$
00113$:
;SpritePlayer.c:425: SetSpriteAnim(this, anim_jump, 0);
	xor	a, a
	push	af
	inc	sp
	ld	bc, #_anim_jump
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_SetSpriteAnim
00120$:
;SpritePlayer.c:428: if ((this->anim_data != anim_idle) && (this->anim_data != anim_doze) && (this->anim_data != anim_sleep)) idle_status = 0;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, #<(_anim_idle)
	sub	a, c
	jr	NZ, 00233$
	ld	a, #>(_anim_idle)
	sub	a, b
	jr	Z, 00122$
00233$:
	ld	a, #<(_anim_doze)
	sub	a, c
	jr	NZ, 00234$
	ld	a, #>(_anim_doze)
	sub	a, b
	jr	Z, 00122$
00234$:
	ld	a, #<(_anim_sleep)
	sub	a, c
	jr	NZ, 00235$
	ld	a, #>(_anim_sleep)
	sub	a, b
	jr	Z, 00122$
00235$:
	xor	a, a
	ld	(#_idle_status),a
00122$:
;SpritePlayer.c:430: DirectionMirrorR(this, data->dir);
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#5
;../include/Platformer.h:77: this->mirror = (dir > 0) ? NO_MIRROR : V_MIRROR;
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0016
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00236$
	bit	7, d
	jr	NZ, 00237$
	cp	a, a
	jr	00237$
00236$:
	bit	7, d
	jr	Z, 00237$
	scf
00237$:
	jr	NC, 00133$
	xor	a, a
	jr	00134$
00133$:
	ld	a, #0x02
00134$:
	ld	(bc), a
;SpritePlayer.c:430: DirectionMirrorR(this, data->dir);
;SpritePlayer.c:431: }
	add	sp, #8
	ret
;SpritePlayer.c:433: void START(void) {
;	---------------------------------
; Function Start_SpritePlayer
; ---------------------------------
_Start_SpritePlayer::
	add	sp, #-4
;SpritePlayer.c:435: CUSTOM_DATA* data = (CUSTOM_DATA*)THIS->custom_data;
	ld	a, (_THIS)
	ld	hl, #_THIS + 1
	ld	d, (hl)
	ld	e, a
	ld	hl, #0x0024
	add	hl, de
	inc	sp
	inc	sp
	push	hl
;SpritePlayer.c:436: data->pos.x = PX_TO_SUBPX(THIS->x);
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	hl, #_THIS
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	sla	c
	rl	b
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;SpritePlayer.c:437: data->pos.y = PX_TO_SUBPX(THIS->y);
	pop	bc
	push	bc
	inc	bc
	inc	bc
	ld	a, (_THIS)
	ld	hl, #_THIS + 1
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
;SpritePlayer.c:439: data->dir = DIR_RIGHT;
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x01
;SpritePlayer.c:441: idle_status = 0;
	xor	a, a
	ld	(#_idle_status),a
;SpritePlayer.c:443: SpriteCameraUpdate(THIS);
	ld	a, (_THIS)
	ld	e, a
	ld	hl, #_THIS + 1
	ld	d, (hl)
	push	de
	ld	e, #b_SpriteCameraUpdate
	ld	hl, #_SpriteCameraUpdate
	call	___sdcc_bcall_ehl
	pop	hl
;SpritePlayer.c:444: ScrollScreenRedraw();
	call	_ScrollScreenRedraw
;SpritePlayer.c:445: }
	add	sp, #4
	ret
;SpritePlayer.c:447: void UPDATE(void) {
;	---------------------------------
; Function Update_SpritePlayer
; ---------------------------------
_Update_SpritePlayer::
;SpritePlayer.c:448: PlayerVelocity(THIS);
	ld	a, (_THIS)
	ld	e, a
	ld	hl, #_THIS + 1
	ld	d, (hl)
	call	_PlayerVelocity
;SpritePlayer.c:449: if (shoulderbashing) PlayerDynaCollide(THIS);
	ld	a, (#_shoulderbashing)
	or	a, a
	jr	Z, 00102$
	ld	a, (_THIS)
	ld	e, a
	ld	hl, #_THIS + 1
	ld	d, (hl)
	call	_PlayerDynaCollide
00102$:
;SpritePlayer.c:450: PlatformerUpdate(THIS);
	ld	a, (_THIS)
	ld	e, a
	ld	hl, #_THIS + 1
	ld	d, (hl)
	push	de
	ld	e, #b_PlatformerUpdate
	ld	hl, #_PlatformerUpdate
	call	___sdcc_bcall_ehl
	pop	hl
;SpritePlayer.c:451: PlayerDynaCollect(THIS);
	ld	a, (_THIS)
	ld	e, a
	ld	hl, #_THIS + 1
	ld	d, (hl)
	call	_PlayerDynaCollect
;SpritePlayer.c:452: PlayerAnimate(THIS);
	ld	a, (_THIS)
	ld	e, a
	ld	hl, #_THIS + 1
	ld	d, (hl)
	call	_PlayerAnimate
;SpritePlayer.c:453: SpriteCameraUpdate(THIS);
	ld	a, (_THIS)
	ld	e, a
	ld	hl, #_THIS + 1
	ld	d, (hl)
	push	de
	ld	e, #b_SpriteCameraUpdate
	ld	hl, #_SpriteCameraUpdate
	call	___sdcc_bcall_ehl
	pop	hl
;SpritePlayer.c:454: }
	ret
;SpritePlayer.c:456: void DESTROY(void) {
;	---------------------------------
; Function Destroy_SpritePlayer
; ---------------------------------
_Destroy_SpritePlayer::
;SpritePlayer.c:457: }
	ret
	.area _CODE_255
	.area _INITIALIZER
__xinit____CRASH_HANDLER_INIT:
	.dw ___HandleCrash
	.area _CABS (ABS)
