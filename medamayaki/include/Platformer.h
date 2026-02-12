#ifndef PLATFORMER_H
#define PLATFORMER_H

#include <gbdk/platform.h>

#include "Collision.h"
#include "Keys.h"

#define MAX_DELTA 127
#define IS_ON_SLOPE(t)    ((t) & COLLISION_SLOPE_ANY)
#define IS_SLOPE_LEFT(t)  ((t) & COLLISION_SLOPE_LEFT)
#define IS_SLOPE_RIGHT(t) (!((t) & COLLISION_SLOPE_LEFT))

#define COUNTER_DECREMENT(x)                                                                                           \
    do                                                                                                                 \
    {                                                                                                                  \
        if ((x) != 0)                                                                                                  \
            (x)--;                                                                                                     \
    } while (0)
#define COUNTER_DECREMENT_CB(x, cond)                                                                                  \
    do                                                                                                                 \
    {                                                                                                                  \
        if ((x) != 0) {                                                                                                \
            (x)--;                                                                                                     \
            if ((x) == 0) cond                                                                                         \
        }                                                                                                              \
    } while (0)
#define COUNTER_DECREMENT_IF(x, cond)                                                                                  \
    do                                                                                                                 \
    {                                                                                                                  \
        if ((x) != 0 && (cond))                                                                                        \
            (x)--;                                                                                                     \
    } while (0)

#define DIR_LEFT -1
#define DIR_RIGHT 1

#define ENABLE_PLATFORM_DROP_THROUGH	// Comment out to disable platform drop through

#ifdef ENABLE_PLATFORM_DROP_THROUGH
	#define DROP_THROUGH_CONDITION (KEY_TICKED(J_DOWN))
	#define DROP_FRAMES_MAX 5
#endif

typedef struct ucoord_t {
	UINT16 x, y;
} ucoord_t;

typedef struct coord_t {
	INT16 x, y;
} coord_t;

typedef struct platformer_compat_t {
	UINT8 on_slope;
	UINT16 slope_y;
	#ifdef ENABLE_PLATFORM_DROP_THROUGH
	UINT8 drop_timer;
	#endif
} platformer_compat_t;

typedef struct {
	ucoord_t pos;		// + 4 bytes
	coord_t vel;		// + 4 bytes
	INT8 dir;		// + 1 byte
	UINT8 grounded;
	platformer_compat_t plat;
} CUSTOM_DATA;			// = 9 bytes

void PlatformerUpdate(Sprite* this) BANKED;

// There are two inline void DirectionMirro functions that can easily modify a sprite's mirror value based on its direction.
// Because the user may have different spritesheets that face different directions, there are two functions.

// This function will mirror the sprite based on its direction value.
// This works best if the spritesheet is facing right.
inline void DirectionMirrorR(Sprite* this, INT8 dir) {
	this->mirror = (dir > 0) ? NO_MIRROR : V_MIRROR;
}

// This function will mirror the sprite based on its direction value.
// This works best if the spritesheet is facing left.
inline void DirectionMirrorL(Sprite* this, INT8 dir) {
	this->mirror = (dir > 0) ? V_MIRROR : NO_MIRROR;
}

#endif