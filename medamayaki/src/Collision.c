#include <gbdk/platform.h>

#include "Collision.h"
#include "Scroll.h"
#include "MapManager.h"

UINT16 tile_hit_x = 0;
UINT16 tile_hit_y = 0;

static UINT8 _save; 
UINT8 tile_col_test_range_y(UINT8 tile_mask, UINT16 tx, UINT16 ty_start, UINT16 ty_end) NONBANKED {
	tile_hit_x = tx;
	tile_hit_y = ty_start;

	if (tile_hit_x >= scroll_tiles_w || tile_hit_y >= scroll_tiles_h) {
		return (COLLISION_ALL & tile_mask) ? COLLISION_ALL : COLLISION_NONE;
	}

	_save = CURRENT_BANK;
	UINT8 inc = (ty_start < ty_end);
	SWITCH_ROM(scroll_bank);
	UINT8* tile_ptr = scroll_map + (((UINT16)ty_start * scroll_tiles_w) + tx);
	if (dynamic_map_active) ENABLE_RAM;
	UINT8 tile = 0;
	while (TRUE) {
		if (dynamic_map_active) {
			if ((tile_ptr - scroll_map) >= BUFFER_SIZE) {
				SWITCH_RAM(RAM_DATA_B);
				tile = scroll_collisions[*(tile_ptr - BUFFER_SIZE)];
			} else {
				SWITCH_RAM(RAM_DATA_A);
				tile = scroll_collisions[*tile_ptr];
			}
		} else {
			tile = scroll_collisions[*tile_ptr];
		}
		if (tile & tile_mask) {
			SWITCH_ROM(_save);
			if (dynamic_map_active) RevertSRAM();
			return tile;
		}
		if (tile_hit_y == ty_end) {
			break;
		}
		if (inc) {
			tile_hit_y++;
			tile_ptr += scroll_tiles_w;
		} else {
			tile_hit_y--;
			tile_ptr -= scroll_tiles_w;
		}
		if (tile_hit_y >= scroll_tiles_h) {
			SWITCH_ROM(_save);
			if (dynamic_map_active) RevertSRAM();
			return (COLLISION_ALL & tile_mask) ? COLLISION_ALL : COLLISION_NONE;
		}
	}
	SWITCH_ROM(_save);
	if (dynamic_map_active) RevertSRAM();
	return COLLISION_NONE;
}

UINT8 tile_col_test_range_x(UINT8 tile_mask, UINT16 ty, UINT16 tx_start, UINT16 tx_end) NONBANKED {
	tile_hit_x = tx_start;
	tile_hit_y = ty;

	if (tile_hit_x >= scroll_tiles_w || tile_hit_y >= scroll_tiles_h) {
		return (COLLISION_ALL & tile_mask) ? COLLISION_ALL : COLLISION_NONE;
	}

	_save = CURRENT_BANK;
	UINT8 inc = (tx_start < tx_end);
	SWITCH_ROM(scroll_bank);
	UINT8* tile_ptr = scroll_map + (((UINT16)ty * scroll_tiles_w) + tx_start);
	UINT8 tile = 0;
	if (dynamic_map_active) ENABLE_RAM;
	while (TRUE) {
		if (dynamic_map_active) {
			if ((tile_ptr - scroll_map) >= BUFFER_SIZE) {
				SWITCH_RAM(RAM_DATA_B);
				tile = scroll_collisions[*(tile_ptr - BUFFER_SIZE)];
			} else {
				SWITCH_RAM(RAM_DATA_A);
				tile = scroll_collisions[*tile_ptr];
			}
		} else {
			tile = scroll_collisions[*tile_ptr];
		}
		if (tile & tile_mask) {
			SWITCH_ROM(_save);
			if (dynamic_map_active) RevertSRAM();
			return tile;
		}
		if (tile_hit_x == tx_end) {
			break;
		}
		if (inc) {
			tile_hit_x++;
			tile_ptr++;
		} else {
			tile_hit_x--;
			tile_ptr--;
		}
		if (tile_hit_x >= scroll_tiles_w) {
			SWITCH_ROM(_save);
			if (dynamic_map_active) RevertSRAM();
			return (COLLISION_ALL & tile_mask) ? COLLISION_ALL : COLLISION_NONE;
		}				
	}
	SWITCH_ROM(_save);
	if (dynamic_map_active) RevertSRAM();
	return COLLISION_NONE;
}
