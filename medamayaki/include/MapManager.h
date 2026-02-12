#ifndef MAPMANAGER_H
#define MAPMANAGER_H

#include <gbdk/platform.h>
#include "Scroll.h"
#include "Buffer.h"

#define BANKED_MAP(MAP) {BANK(MAP), &MAP}
#define LEVELS_END {0, NULL}

#define SRAM_BANK 8192

#define DYNAMAP_ITERATE_SPRITE(this) UINT8 tile_x_end = PX_TO_TILE(this->x + this->coll_w - 1); UINT8 tile_y_end = PX_TO_TILE(this->y + this->coll_h - 1); for (UINT8 tile_y = PX_TO_TILE(this->y); tile_y <= tile_y_end; tile_y++) for (UINT8 tile_x = PX_TO_TILE(this->x); tile_x <= tile_x_end; tile_x++)

#define DYNAMAP_ITERATE_SUBPX(coord) UINT8 tile_x_end = SUBPX_TO_TILE(coord.x + PX_TO_SUBPX(this->coll_w) - 1); UINT8 tile_y_end = PX_TO_TILE(coord.y + PX_TO_SUBPX(this->coll_h) - 1); for (UINT8 tile_y = SUBPX_TO_TILE(coord.y); tile_y <= tile_y_end; tile_y++) for (UINT8 tile_x = SUBPX_TO_TILE(coord.x); tile_x <= tile_x_end; tile_x++)

// current level structures
extern struct MapInfo current_level_desc;
extern UINT8 current_level_bank;
extern UINT8 current_level;
extern UINT16 current_level_size;
extern UINT8 dynamic_map_active;

void * memcpy_banked(void *dest, const void *src, size_t len, uint8_t bank) NONBANKED;

void UPDATE_TILE(INT16 x, INT16 y) NONBANKED;

void InitDynaStage(UINT8 level) NONBANKED;
void InitDynaScroll(UINT8 map_bank, const struct MapInfo* map, const UINT8* coll_list, const UINT8* coll_list_down) NONBANKED;
inline void RevertSRAM(void);
inline void RestoreDefaultScroll(void);
enum {
	AND,
	EQUALS
};

#define RAM_DEFAULT 0
//#define RAM_DATA_A BUFFER_ADDRESS_A
//#define RAM_DATA_B BUFFER_ADDRESS_B

void CollideDynaTile(UINT16 tileX, UINT16 tileY, UINT8 tileNew, UINT8 collisionOperation, UINT8 collisionCompare) NONBANKED;
void ReplaceDynaTile(UINT16 tileX, UINT16 tileY, UINT8 tileNew, UINT8 tileCompare) NONBANKED;
void UpdateDynaTile(UINT16 tileX, UINT16 tileY, UINT8 tileNew) NONBANKED;
UINT8 DynaTileAt(UINT16 tileX, UINT16 tileY) NONBANKED;

#endif