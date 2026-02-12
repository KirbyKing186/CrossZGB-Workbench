#include "Banks/SetAutoBank.h"

#include "ZGBMain.h"
#include "Keys.h"
#include "Scroll.h"
#include "SpriteManager.h"
#include "Math.h"

#include "Collision.h"
#include "Camera.h"
#include "Platformer.h"
#include "MapManager.h"

UINT8 jump_add, jump_extra_count;
UINT8 running, jumping, falling, turning, deceling, knockback, knockback_minimum, shoulderbashing, shoulderbashing_cooldown;
UINT8 idle_status;

#define ANIM_STOP (VECTOR_LEN(this->anim_data) - 1)
static const UINT8 anim_idle[] = VECTOR(0, 0, 0, 0, 0, 0, 1);
static const UINT8 anim_doze[] = VECTOR(1, 2, 3, 4);
static const UINT8 anim_sleep[] = VECTOR(4, 4, 4, 4, 5, 6, 6, 6, 6, 6, 6, 5);
static const UINT8 anim_walk[] = VECTOR(7, 8, 9, 10);
static const UINT8 anim_jump[] = VECTOR(11);
static const UINT8 anim_bash[] = VECTOR(12, 13, 14, 15);
static const UINT8 anim_bash_knockback[] = VECTOR(16);
//static const UINT8 anim_debug[] = VECTOR(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);

#define INPUT_JUMP (J_A)
#define INPUT_RUN (J_B)

// Horizontal velocity constants (Absolute integers)
#define ACCELERATION_VEL_X 256			// Horizontal acceleration when walking
#define ACCELERATION_VEL_X_RUN 512		// Horizontal acceleration when running
#define ACCELERATION_VEL_X_TURN 2048	// Horizontal acceleration when turning
#define DECELERATION_VEL_X 512			// Horizontal deceleration when grounded
#define DECELERATION_VEL_X_AIR 256		// Horizontal deceleration when airborne
#define MAX_VEL_X_WALK 7000				// Maximum horizontal velocity when walking
#define MAX_VEL_X_RUN 11000				// Maximum horizontal velocity when running

// Vertical velocity constants (Signed integers for upwards or downwards velocity)
#define ACCELERATION_VEL_Y 1800			// Standard gravity (Downwards)
#define ACCELERATION_VEL_Y_HELD 600		// Gravity while holding A when going upwards during a jump (Downwards)
#define MAX_VEL_Y 14000					// Maximum force of gravity (Downwards)
#define JUMP_VEL_Y -12000				// First upwards burst of velocity when tapping A (Upwards)
#define JUMP_ADD_FRAMES 12				// Amount of frames to apply the additional vertical velocity value below (Set to zero for static jumps)
#define JUMP_VEL_Y_ADD -512				// Amount of additional vertical velocity applied when holding A for a single jump-add frame (Upwards)
#define EXTRA_JUMPS 0					// Amount of extra jumps in addition to the standard grounded jump (Overriden by ENABLE_INFINITE_JUMPS if enabled)

// Player-specific state constants
#define KNOCKBACK_VEL_X 8000			// Amount of horizontal force applied when starting the Knockback state (a negative x velocity multiplied by the player direction variable sends the player backwards)
#define KNOCKBACK_VEL_Y -15000			// Amount of vertical force applied when starting the Knockback state
#define KNOCKBACK_MINIMUM 8				// Minimum amount of frames to be in the Knockback state When this time is up, the Knockback state reverts to normal when the player is grounded.
#define SHOULDERBASH_VEL_X 12800		// Amount of horizontal force applied throughout the Shoulder Bash state
#define SHOULDERBASH_TIME 40			// Amount of frames a full Shoulder Bash takes before reverting back to standard controls
#define SHOULDERBASH_COOLDOWN 16		// Amount of frames to wait before starting a new Shoulder Bash

// Behavior flags
//#define ENABLE_RUNNING
//#define ENABLE_INFINITE_JUMPS

void PlayerVelocity(Sprite* this) {
	
	CUSTOM_DATA* data = (CUSTOM_DATA*)this->custom_data;
	
	// Vertical inputs and velocity changes
	if (!knockback) {
		if (KEY_PRESSED(INPUT_JUMP)) {
			switch (jumping) {
				case 0:		// Jumping = 0: Not jumping.
					if (KEY_TICKED(INPUT_JUMP)) {
						#ifndef ENABLE_INFINITE_JUMPS
						#if EXTRA_JUMPS > 0
						if ((data->grounded) || ((jump_extra_count < EXTRA_JUMPS) && (jump_extra_count++ < EXTRA_JUMPS))) {
						#else
						if (data->grounded) {
						#endif
						#endif
							data->grounded = 0;
							data->vel.y = JUMP_VEL_Y;
							#if JUMP_ADD_FRAMES > 0
							jumping = 1;
							jump_add = JUMP_ADD_FRAMES;
							#else
							jumping = 2;
							#endif
						#ifndef ENABLE_INFINITE_JUMPS
						}
						#endif
					}
				break;
				case 1:		// Jumping = 1: Applying vertical velocity while holding A (Skipped if JUMP_ADD_FRAMES is 0)
					data->vel.y += JUMP_VEL_Y_ADD;
					if (--jump_add == 0) jumping = 2;
				break;
				//case 2:	// Jumping = 2: Coasting on applied vertical velocity and held gravity while holding A
			}
		} else if (jumping > 0) {
			jumping = 0;
			falling = 1;
		}
	} else {
		jumping = 0;
	}
	
	#ifndef ENABLE_INFINITE_JUMPS
	#if EXTRA_JUMPS > 0
	if ((data->grounded) && (jump_extra_count > 0)) jump_extra_count = 0;
	#endif
	#endif
	
	if (!jumping) {
		// Standard Gravity
		data->vel.y = MIN(data->vel.y + ACCELERATION_VEL_Y, MAX_VEL_Y);
	} else {
		// Held Gravity
		data->vel.y = MIN(data->vel.y + ACCELERATION_VEL_Y_HELD, MAX_VEL_Y);
		if (data->vel.y >= 0) {
			jumping = 0;
			falling = 1;
		}
	}
	

	// Vertical inputs and velocity changes
	running = turning = deceling = 0;
	INT16 prev_vel_x = data->vel.x;
	if ((!shoulderbashing_cooldown) || (--shoulderbashing_cooldown == 0)) {
		if ((KEY_TICKED(J_B)) && (data->grounded) && (!shoulderbashing)) {
			shoulderbashing = SHOULDERBASH_TIME;
		}
	}
	
	if (shoulderbashing) {
		if ((data->grounded) && (((KEY_TICKED(J_LEFT)) && (data->dir > 0)) || ((KEY_TICKED(J_RIGHT)) && (data->dir < 0)))) {
			data->vel.x = 0;
			shoulderbashing = 0;
			shoulderbashing_cooldown = SHOULDERBASH_COOLDOWN;
		} else {
			data->vel.x = SHOULDERBASH_VEL_X * data->dir;
			if (shoulderbashing == 1) {
				if (data->grounded) {
					shoulderbashing = 0;
					shoulderbashing_cooldown = SHOULDERBASH_COOLDOWN;
				}
			} else {
				shoulderbashing--;
			}
		}
	} else {
		if ((KEY_PRESSED(J_LEFT | J_RIGHT)) && (!knockback)) {
			
			if (KEY_PRESSED(J_LEFT)) {
				data->dir = -1;
				data->vel.x = -data->vel.x;
			} else {
				data->dir = 1;
			}
			
			#ifdef ENABLE_RUNNING
			if (KEY_PRESSED(INPUT_RUN)) {
				running = 1;
			} else {
				running = 0;
			}
			#endif
			
			if (((prev_vel_x ^ data->dir) < 0) && (data->vel.x != 0)) {	// Turning
				turning = 1;
			} else {
				turning = 0;
			}
			
			if (!turning) {
				#ifdef ENABLE_RUNNING
				if (running) {
					if (data->vel.x > MAX_VEL_X_RUN) {
						data->vel.x = MAX(data->vel.x + DECELERATION_VEL_X, MAX_VEL_X_RUN);
					} else {
						data->vel.x = MIN(data->vel.x + ACCELERATION_VEL_X_RUN, MAX_VEL_X_RUN);
					}
				} else {
				#endif
					if (data->vel.x > MAX_VEL_X_WALK) {
						data->vel.x = MAX(data->vel.x - DECELERATION_VEL_X, MAX_VEL_X_WALK);
					} else {
						data->vel.x = MIN(data->vel.x + ACCELERATION_VEL_X, MAX_VEL_X_WALK);
					}
				#ifdef ENABLE_RUNNING
				}
				#endif
			} else {
				data->vel.x += ACCELERATION_VEL_X_TURN;
			}
			
			if (data->dir < 0) {
				data->vel.x = -data->vel.x;
			}
			
		} else if (data->vel.x != 0) {
			deceling = 1;
			if (data->vel.x > 0) {
				if (data->grounded) {
					data->vel.x = MAX(data->vel.x - DECELERATION_VEL_X, 0);
				} else {
					data->vel.x = MAX(data->vel.x - DECELERATION_VEL_X_AIR, 0);
				}
			} else {
				if (data->grounded) {
					data->vel.x = MIN(data->vel.x + DECELERATION_VEL_X, 0);
				} else {
					data->vel.x = MIN(data->vel.x + DECELERATION_VEL_X_AIR, 0);
				}
			}
		}
	}
	
	if (knockback) {
		if ((!knockback_minimum) || (--knockback_minimum == 0)) {
			if (data->grounded) {
				knockback = FALSE;
				data->vel.x = 0;
				data->vel.y = 0;
			}
		}
	}
	
}

void PlayerDynaCollide(Sprite* this) {
	CUSTOM_DATA* data = (CUSTOM_DATA*)this->custom_data;
	UINT16 tile_x = 0;
	if (data->vel.x > 0) {
		tile_x = SUBPX_TO_TILE(data->pos.x + VEL_TO_SUBPX(data->vel.x) + PX_TO_SUBPX(this->coll_w) - 1);
	} else {
		tile_x = SUBPX_TO_TILE(data->pos.x + VEL_TO_SUBPX(data->vel.x));
	}
	UINT16 tile_y = SUBPX_TO_TILE(data->pos.y);
	UINT16 tile_y_end = SUBPX_TO_TILE(data->pos.y + PX_TO_SUBPX(this->coll_h) - 1) - 1;	// Subtract one tile to get some leeway
	if (tile_col_test_range_y((data->vel.x > 0) ? COLLISION_LEFT : COLLISION_RIGHT, tile_x, tile_y, tile_y_end)) {
		switch (DynaTileAt(tile_x, tile_hit_y)) {
			case 0x1C:	// Top-Left Small Block
				for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
						UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y, 0);
					}
				}
			break;
			case 0x1E:	// Bottom-Left Small Block
				for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
						UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y - 1, 0);
					}
				}
			break;
			case 0x1D:	// Top-Right Small Block
				for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
						UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y, 0);
					}
				}
			break;
			case 0x1F:	// Bottom-Right Small Block
				for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
						UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y - 1, 0);
					}
				}
			break;
			case 0x20:	// Left-A Large Block
				for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
						UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y, 0);
					}
				}
			break;
			case 0x24:	// Left-B Large Block
				for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
						UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y - 1, 0);
					}
				}
			break;
			case 0x28:	// Left-C Large Block
				for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
						UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y - 2, 0);
					}
				}
			break;
			case 0x2C:	// Left-D Large Block
				for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
						UpdateDynaTile(tile_x + offset_x, tile_hit_y + offset_y - 3, 0);
					}
				}
			break;
			case 0x23:	// Right-A Large Block
				for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
						UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y, 0);
					}
				}
			break;
			case 0x27:	// Right-B Large Block
				for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
						UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y - 1, 0);
					}
				}
			break;
			case 0x2B:	// Right-C Large Block
				for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
						UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y - 2, 0);
					}
				}
			break;
			case 0x2F:	// Right-D Large Block
				for (UINT8 offset_x = 0; offset_x < 4; offset_x++) {
					for (UINT8 offset_y = 0; offset_y < 4; offset_y++) {
						UpdateDynaTile(tile_x - offset_x, tile_hit_y + offset_y - 3, 0);
					}
				}
			break;
		}
		/*
		Large Block Structure, with each letter being a 8x8 tile
		AXXA
		BXXB
		CXXC
		DXXD
		*/
		knockback = 1;
		knockback_minimum = KNOCKBACK_MINIMUM;
		shoulderbashing = 0;
		shoulderbashing_cooldown = SHOULDERBASH_COOLDOWN;
		data->vel.x = -KNOCKBACK_VEL_X * data->dir;
		data->vel.y = KNOCKBACK_VEL_Y;
	}
}

void PlayerDynaCollect(Sprite* this) {
	#define COLLECT_OFFSET 4	// Amount of pixels to offset for the player to register as collecting a collectable
	UINT16 tile_x_end = PX_TO_TILE(this->x + this->coll_w - 1 - COLLECT_OFFSET);
	UINT16 tile_y_end = PX_TO_TILE(this->y + this->coll_h - 1 - COLLECT_OFFSET);
	for (UINT16 tile_y = PX_TO_TILE(this->y + COLLECT_OFFSET); tile_y <= tile_y_end; tile_y++) {
		for (UINT16 tile_x = PX_TO_TILE(this->x + COLLECT_OFFSET); tile_x <= tile_x_end; tile_x++) {
			switch (DynaTileAt(tile_x, tile_y)) {
				case 0x01:	// Top-Left Small Collectible (Blue Gem)
				case 0x05:	// Top-Left Small Collectible (Red Gem)
				case 0x09:	// Top-Left Small Collectible (Heart)
					for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
						for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
							UpdateDynaTile(tile_x + offset_x, tile_y + offset_y, 0);
						}
					}
				break;
				case 0x02:	// Top-Right Small Collectible (Blue Gem)
				case 0x06:	// Top-Right Small Collectible (Red Gem)
				case 0x0A:	// Top-Right Small Collectible (Heart)
					for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
						for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
							UpdateDynaTile(tile_x - offset_x, tile_y + offset_y, 0);
						}
					}
				break;
				case 0x03:	// Bottom-Left Small Collectible (Blue Gem)
				case 0x07:	// Bottom-Left Small Collectible (Red Gem)
				case 0x0B:	// Bottom-Left Small Collectible (Heart)
					for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
						for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
							UpdateDynaTile(tile_x + offset_x, tile_y + offset_y - 1, 0);
						}
					}
				break;
				case 0x04:	// Bottom-Right Small Collectible (Blue Gem)
				case 0x08:	// Bottom-Right Small Collectible (Red Gem)
				case 0x0C:	// Bottom-Right Small Collectible (Heart)
					for (UINT8 offset_x = 0; offset_x < 2; offset_x++) {
						for (UINT8 offset_y = 0; offset_y < 2; offset_y++) {
							UpdateDynaTile(tile_x - offset_x, tile_y + offset_y - 1, 0);
						}
					}
				break;
			}
		}
	}
	
}

void PlayerAnimate(Sprite* this) {
	CUSTOM_DATA* data = (CUSTOM_DATA*)this->custom_data;
	SetAnimationLoop(this, FALSE);
	if (knockback) {
		SetSpriteAnim(this, anim_bash_knockback, 0);
	} else if (shoulderbashing) {
		SetAnimationLoop(this, TRUE);
		SetSpriteAnim(this, anim_bash, 20);
	} else if (data->grounded) {
		if (data->vel.x) {
			SetAnimationLoop(this, TRUE);
			SetSpriteAnim(this, anim_walk, 20);
		} else {
			switch (idle_status) {
				case 0:
					SetSpriteAnim(this, anim_idle, 1);
					if (this->anim_frame == ANIM_STOP) {
						SetSpriteAnim(this, anim_doze, 2);
						idle_status = 1;
					}
				break;
				case 1:
					if (this->anim_frame == ANIM_STOP) {
						SetAnimationLoop(this, TRUE);
						SetSpriteAnim(this, anim_sleep, 7);
						idle_status = 2;
					}
				break;
				case 2:
					SetAnimationLoop(this, TRUE);
				break;
			}
		}
	} else {
		SetSpriteAnim(this, anim_jump, 0);
	}
	
	if ((this->anim_data != anim_idle) && (this->anim_data != anim_doze) && (this->anim_data != anim_sleep)) idle_status = 0;
	
	DirectionMirrorR(this, data->dir);
}

void START(void) {
	// Initialize subpixel values
	CUSTOM_DATA* data = (CUSTOM_DATA*)THIS->custom_data;
	data->pos.x = PX_TO_SUBPX(THIS->x);
	data->pos.y = PX_TO_SUBPX(THIS->y);
	// Initialize direction
	data->dir = DIR_RIGHT;
	// Initialize idle animation variable
	idle_status = 0;
	// Initialize camera
	SpriteCameraUpdate(THIS);
	ScrollScreenRedraw();
}

void UPDATE(void) {
	PlayerVelocity(THIS);
	if (shoulderbashing) PlayerDynaCollide(THIS);
	PlatformerUpdate(THIS);
	PlayerDynaCollect(THIS);
	PlayerAnimate(THIS);
	SpriteCameraUpdate(THIS);
}

void DESTROY(void) {
}