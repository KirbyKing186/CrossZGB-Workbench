#include "Banks/SetAutoBank.h"

#include "ZGBMain.h"
#include "Scroll.h"
#include "Keys.h"
#include "SpriteManager.h"

#include "Platformer.h"
#include "Interrupts.h"
#include "MapManager.h"

IMPORT_MAP(medamayaki);

static const UINT8 collision_all[]                    = VECTOR(13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48);
static const UINT8 collision_top[]                    = LIST_EMPTY;
static const UINT8 collision_platform[]               = VECTOR(49, 50);
static const UINT8 collision_bottom[]                 = LIST_EMPTY;
static const UINT8 collision_left[]                   = LIST_EMPTY;
static const UINT8 collision_right[]                  = LIST_EMPTY;
static const UINT8 collision_slope_45_right[]         = VECTOR(51, 52);
static const UINT8 collision_slope_225_right_bottom[] = VECTOR(55, 57);
static const UINT8 collision_slope_225_right_top[]    = VECTOR(56);
static const UINT8 collision_slope_45_left[]          = VECTOR(53, 54);
static const UINT8 collision_slope_225_left_bottom[]  = VECTOR(58, 59);
static const UINT8 collision_slope_225_left_top[]     = VECTOR(60);

void START(void) {
	
	// Initialize the background map and scrolling
		// There are two methods for initializing a dynamic map
		/*
			// InitDynaStage uses map data from a const array (levels[] in `MapManager.c`), allowing easy initialization from a single integer. Additionally, the integer used here will be stored in savegame.buffer_level, in case you want to access the current stage later.
			InitDynaStage(0);
		
			// InitDynaScroll allows the user to define the bank and address of a map, similar to InitScroll of default CrossZGB.
			InitDynaScroll(BANK(medamayaki), &medamayaki, 0, NULL);
		*/
		/*
			// If needed, the basic scroll function with no dynamic map support is still available.
			InitScroll(BANK(medamayaki), &medamayaki, 0, NULL);
		*/
		// Use the scroll initialization method you feel best fits your project.
		InitDynaStage(0);
	
	// Initialize collision vectors
		ScrollInitCollisionGroupVector(COLLISION_ALL,      collision_all);
		ScrollInitCollisionGroupVector(COLLISION_TOP,      collision_top);
		ScrollInitCollisionGroupVector(COLLISION_PLATFORM, collision_platform);
		ScrollInitCollisionGroupVector(COLLISION_BOTTOM,   collision_bottom);
		ScrollInitCollisionGroupVector(COLLISION_LEFT,     collision_left);
		ScrollInitCollisionGroupVector(COLLISION_RIGHT,    collision_right);
		ScrollInitCollisionGroupVector(COLLISION_SLOPE_45_RIGHT,      collision_slope_45_right);
		ScrollInitCollisionGroupVector(COLLISION_SLOPE_225_RIGHT_BOT, collision_slope_225_right_bottom);
		ScrollInitCollisionGroupVector(COLLISION_SLOPE_225_RIGHT_TOP, collision_slope_225_right_top);
		ScrollInitCollisionGroupVector(COLLISION_SLOPE_45_LEFT,       collision_slope_45_left);
		ScrollInitCollisionGroupVector(COLLISION_SLOPE_225_LEFT_BOT,  collision_slope_225_left_bottom);
		ScrollInitCollisionGroupVector(COLLISION_SLOPE_225_LEFT_TOP,  collision_slope_225_left_top);
	
	// Initialize background gradient effect
		// First parameter: Top color
		// Second parameter: Bottom color
		// Second parameter: Space between interrupts (Smaller values are visually smoother but more resource-intensive, larger values are visually choppier but less resource-intensive.)
		InitSpecialInterrupts(RGB8(0x10, 0x90, 0xF8), RGB_WHITE, 8);
		// Fading looks off without specific code for the interrupts to fade along with the background
		fade_mode = FADE_OFF;
	
	// Initialize player
		// This is done last, as background scrolling must already be initialized for `SpritePlayer.c`'s camera to initialize.
		// See `SpritePlayer.c` for player-specific code
		SpriteManagerAdd(SpritePlayer, TILE_TO_PX(6), TILE_TO_PX(17));
	
}

void UPDATE(void) {
}

void DESTROY(void) {
	// When you use default scrolling again, please use this function. This resets the dynamic map variable, allowing code that is specific to dynamic maps to run correctly.
	RestoreDefaultScroll();
	// If needed, revert special interrupts
	RestoreDefaultInterrupts();
}