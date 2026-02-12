#include "ZGBMain.h"
#include "Scroll.h"
#include "MapManager.h"
#include "SpriteManager.h"
#include "Collision.h"
#include "savegame.h"
#include "Buffer.h"

// map imports
IMPORT_MAP(medamayaki);

// level list structure
typedef struct MapInfoBanked_t {
	UINT8 bank;
	struct MapInfo* map;
} MapInfoBanked_t;

// level list
const MapInfoBanked_t levels[] = {
	BANKED_MAP(medamayaki),
};

// current level structures
struct MapInfo current_level_desc;
UINT8 current_level_bank;
UINT8 current_level;
UINT16 current_level_size, current_size_a, current_size_b;
UINT8* replace_ptr;
UINT8  replace_ram;
UINT8 dynamic_map_active;

static uint8_t _save;
void * memcpy_banked(void *dest, const void *src, size_t len, uint8_t bank) NONBANKED {
    _save = _current_bank;
    SWITCH_ROM(bank);
    void * res = memcpy(dest, src, len);
    SWITCH_ROM(_save);
    return res;
}

inline void RevertSRAM(void) {
	SWITCH_RAM(RAM_DEFAULT);
	DISABLE_RAM;
}

inline void RestoreDefaultScroll(void) {
	dynamic_map_active = 0;
}

// Vital UPDATE_TILE function used throughout Scroll.c
// To be defined on the main app
UINT8 GetTileReplacement(UINT8* tile_ptr, UINT8* tile);
// global variables, updated before each call to UPDATE_TILE()
extern unsigned char* scroll_ptr;
extern unsigned char* scroll_cptr;
// ram-specific scroll pointers, for the dynamic map implementation
unsigned char* ram_scroll_ptr;
unsigned char* ram_scroll_cptr;
void UPDATE_TILE(INT16 x, INT16 y) NONBANKED {
	static UINT8 replacement;
	
	// Modified Code Start
	if (dynamic_map_active) {
		// Copy current scroll pointers into new pointers, to not tamper with the original pointers
		ram_scroll_ptr  = scroll_ptr;
		ram_scroll_cptr = scroll_cptr;
		// Enable SRAM access
		ENABLE_RAM;
		// If the scroll pointers exceed Buffer A, reposition the pointers by the buffer size and switch to the Buffer B SRAM bank
		// Otherwise, do not modify the pointers and switch to the Buffer A SRAM bank
		if ((ram_scroll_ptr - scroll_map) >= BUFFER_SIZE) {
			ram_scroll_ptr  -= BUFFER_SIZE;
			ram_scroll_cptr -= BUFFER_SIZE;
			SWITCH_RAM(RAM_DATA_B);
		} else {
			SWITCH_RAM(RAM_DATA_A);
		}
	}
	// Modified code end
	
	if(((UINT16)x >= scroll_tiles_w) || ((UINT16)y >= scroll_tiles_h)) { //This also checks x < 0 || y < 0
		replacement = 0;
	} else {
		static UINT8 type;
		
		// Modified code start
		if (dynamic_map_active) {
			replacement = *ram_scroll_ptr;
			type = GetTileReplacement(ram_scroll_ptr, &replacement);
		} else {
			replacement = *scroll_ptr;
			type = GetTileReplacement(scroll_ptr, &replacement);
		}
		// Modified code end
		
		if(type != 255u) {
			static UINT8 i;
			static UINT16 id;
			id = SPRITE_UNIQUE_ID(x, y);
			for (i = VECTOR_LEN(sprite_manager_updatables); (i); i--) {
				Sprite* s = sprite_manager_sprites[sprite_manager_updatables[i]];
				if ((s->type == type) && (s->unique_id == id)) {
					break;
				}
			}
			if (i == 0) {
				UINT8 __save = CURRENT_BANK;
				SWITCH_ROM(spriteDataBanks[type]);
				UINT16 sprite_y = TILE_TO_PX(y + 1) - spriteDatas[type]->height;
				SWITCH_ROM(__save);
				SpriteManagerAdd(type, TILE_TO_PX(x), sprite_y);
			}
		}
	}
	
	// Modified code start
	if (dynamic_map_active) {
		ScrollSetAttrTileXY(SCREEN_BKG_OFFSET_X + x + scroll_offset_x, y + scroll_offset_y, replacement, ((ram_scroll_cptr) ? *ram_scroll_cptr : scroll_tile_info[replacement]));
		RevertSRAM();
	} else {
		ScrollSetAttrTileXY(SCREEN_BKG_OFFSET_X + x + scroll_offset_x, y + scroll_offset_y, replacement, ((scroll_cptr) ? *scroll_cptr : scroll_tile_info[replacement]));
	}
	// Modified code end
	
}

void copy_level_buffers(void) NONBANKED {
	
	// Step 2: Calculate sizes
		// current_level_size defines the entire level map size
		current_level_size = (current_level_desc.width * current_level_desc.height);
		// current_size_a defines how Buffer A will be allocated
		current_size_a = MIN(current_level_size, BUFFER_SIZE);
		// current_size_b defines how the Buffer B will be allocated, if the map is larger than Buffer A
		current_size_b = (current_level_size > BUFFER_SIZE) ? current_level_size - BUFFER_SIZE : 0;
	
	// Step 3: Initialize data buffers
		// If buffer_data_b is needed, calculate it first for efficiency
		if (current_size_b) {
			SWITCH_RAM(RAM_DATA_B);
			memcpy_banked(buffer_data_b, current_level_desc.data + BUFFER_SIZE, current_size_b, current_level_bank);
		}
		// Copy data to buffer_data_a
		SWITCH_RAM(RAM_DATA_A);
		memcpy_banked(buffer_data_a, current_level_desc.data, current_size_a, current_level_bank);
		current_level_desc.data = buffer_data_a;
	
	// Step 4: Clean up
		RevertSRAM();
	
}

void copy_level_desc_scroll(UINT8 map_bank, const struct MapInfo* map) NONBANKED {
	
	// Step 1 (Scroll method): Setup accessible map information from scroll parameters
		// Read and modify accessible data in WRAM and SRAM bank 0
		ENABLE_RAM;
		SWITCH_RAM(RAM_DEFAULT);
		// Set current level data bank
		current_level_bank = map_bank;
		// Copy mapinfo structure into the RAM so we can alter the data pointer
		memcpy_banked(&current_level_desc, &map, sizeof(current_level_desc), current_level_bank);
		// Continue from shared function
		copy_level_buffers();
	
}

void copy_level_desc_stage(void) NONBANKED {
	
	// Step 1 (Stage method): Setup accessible map information from a stage
		// Read and modify accessible data in WRAM and SRAM bank 0
		ENABLE_RAM;
		SWITCH_RAM(RAM_DEFAULT);
		// Set current level data bank
		current_level_bank = levels[savegame.buffer_level].bank;
		// Copy mapinfo structure into the RAM so we can alter the data pointer
		memcpy_banked(&current_level_desc, levels[savegame.buffer_level].map, sizeof(current_level_desc), current_level_bank);
		// Continue from shared function
		copy_level_buffers();
	
}

void InitDynaStage(UINT8 level) NONBANKED {
	dynamic_map_active = TRUE;
	ENABLE_RAM;
	SWITCH_RAM(RAM_DEFAULT);
	savegame.buffer_level = level;
	copy_level_desc_stage();
	InitScroll(current_level_bank, &current_level_desc, 0, NULL);
}

void InitDynaScroll(UINT8 map_bank, const struct MapInfo* map, const UINT8* coll_list, const UINT8* coll_list_down) NONBANKED {
	dynamic_map_active = TRUE;
	copy_level_desc_scroll(map_bank, map);
	InitScroll(current_level_bank, &current_level_desc, coll_list, coll_list_down);
}

// Tile replace helper functions
static void CalculateOffset(UINT16 tileX, UINT16 tileY) {
	ENABLE_RAM;
	UINT16 current_tile = (tileY * current_level_desc.width) + tileX;
	if (current_tile >= BUFFER_SIZE) {
		replace_ptr = buffer_data_b + current_tile - BUFFER_SIZE;
		replace_ram = RAM_DATA_B;
	} else {
		replace_ptr = buffer_data_a + current_tile;
		replace_ram = RAM_DATA_A;
	}
	SWITCH_RAM(replace_ram);
}

// Tile replace functions
void CollideDynaTile(UINT16 tileX, UINT16 tileY, UINT8 tileNew, UINT8 collisionOperation, UINT8 collisionCompare) NONBANKED {
	CalculateOffset(tileX, tileY);
	UINT8 ok = 0;
	if ((collisionOperation == EQUALS) && (scroll_collisions[*replace_ptr] == collisionCompare)) {
		ok = 1;
	} else if ((collisionOperation == AND) && (scroll_collisions[*replace_ptr] & collisionCompare)) {
		ok = 1;
	}
	if (ok) {
		*replace_ptr = tileNew;
		UpdateMapTile(TARGET_BKG, tileX, tileY, tileNew, 0, NULL);
	}
	RevertSRAM();
}

void ReplaceDynaTile(UINT16 tileX, UINT16 tileY, UINT8 tileNew, UINT8 tileCompare) NONBANKED {
	CalculateOffset(tileX, tileY);
	if (*replace_ptr == tileCompare) {
		*replace_ptr = tileNew;
		UpdateMapTile(TARGET_BKG, tileX, tileY, tileNew, 0, NULL);
	}
	RevertSRAM();
}

void UpdateDynaTile(UINT16 tileX, UINT16 tileY, UINT8 tileNew) NONBANKED {
	CalculateOffset(tileX, tileY);
	*replace_ptr = tileNew;
	UpdateMapTile(TARGET_BKG, tileX, tileY, tileNew, 0, NULL);
	RevertSRAM();
}

UINT8 DynaTileAt(UINT16 tileX, UINT16 tileY) NONBANKED {
	CalculateOffset(tileX, tileY);
	UINT8 return_value = *replace_ptr;
	RevertSRAM();
	return return_value;
}
