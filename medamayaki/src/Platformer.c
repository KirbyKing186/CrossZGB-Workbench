#include "ZGBMain.h"
#include "Keys.h"
#include "Scroll.h"
#include "Math.h"

#include "Collision.h"
#include "Platformer.h"

void PlatformerUpdate(Sprite* this) BANKED {
	
	CUSTOM_DATA* data = (CUSTOM_DATA*)this->custom_data;
	
	UINT16 coll_offset_w = PX_TO_SUBPX(this->coll_w) - 1;
	UINT16 coll_offset_h = PX_TO_SUBPX(this->coll_h) - 1;
	UINT16 sp_half_width = DIV_2(coll_offset_w);
	UINT8 prev_on_slope = data->plat.on_slope;
	data->plat.on_slope = FALSE;
	
#ifdef ENABLE_PLATFORM_DROP_THROUGH
	if (data->grounded) {
		data->plat.drop_timer = 0;
	} else {
		COUNTER_DECREMENT(data->plat.drop_timer);
	}
    if (DROP_THROUGH_CONDITION) data->plat.drop_timer = DROP_FRAMES_MAX;
#endif
	
	// Horizontal Movement
	INT8 plat_delta_x = CLAMP(VEL_TO_SUBPX(data->vel.x), -MAX_DELTA, MAX_DELTA);
	if (plat_delta_x) {
		
		UINT16 tile_y_start = SUBPX_TO_TILE(data->pos.y + coll_offset_h);
		UINT16 tile_y_end = SUBPX_TO_TILE(data->pos.y);
		UINT16 new_x = ((data->pos.x + plat_delta_x) > 0) ? data->pos.x + plat_delta_x : 0;

		// Step-Check for collisions one tile left or right based on movement direction
		UINT8 moving_right, hit_flag;
		INT16 bounds_edge = 0;

		if (plat_delta_x > 0)
		{
			// Right movement
			moving_right = TRUE;
			hit_flag = COLLISION_LEFT;
			bounds_edge = EXCLUSIVE_OFFSET(coll_offset_w);
		}
		else
		{
			// Left movement
			moving_right = FALSE;
			hit_flag = COLLISION_RIGHT;
		}

		UINT16 tile_x = SUBPX_TO_TILE(new_x + bounds_edge);
		
		UINT8 tile = tile_col_test_range_y(hit_flag, tile_x, tile_y_start, tile_y_end);

		if (tile) {
			// Handle case when moving up a slope and top contains a solid collision
			//   e.g.
			//
			//    /EX
			//   /XXX
			//
			//  Tile `E` would block movement up slope without these checks
			if ((tile_hit_y == data->plat.slope_y) &&
				(IS_ON_SLOPE(prev_on_slope) &&
				(IS_SLOPE_LEFT(prev_on_slope) != moving_right)))
			{
				goto finally_update_x;
			}               
			if (moving_right) {
				new_x = TILE_TO_SUBPX(tile_x) - bounds_edge;
			} else {
				new_x = TILE_TO_SUBPX(tile_x + 1) - bounds_edge;
			}

			data->vel.x = 0;
		}

	finally_update_x:
		data->pos.x = new_x;
	
	}
	
	// Vertical Movement
	INT8 plat_delta_y = CLAMP(VEL_TO_SUBPX(data->vel.y), -MAX_DELTA, MAX_DELTA);
	if (plat_delta_y) {
	
		UINT16 new_y = ((data->pos.y + plat_delta_y) > 0) ? data->pos.y + plat_delta_y : 0;
		UINT8 prev_grounded = data->grounded;

		// 1 frame leniency of grounded state if we were on a slope last frame
		data->grounded = prev_on_slope;

		UINT16 tile_x_start = SUBPX_TO_TILE(data->pos.x);
		UINT16 tile_x_end = SUBPX_TO_TILE(data->pos.x + coll_offset_w);

		if (plat_delta_y >= 0) {
			// Moving Downward
			UINT8 tile;
			UINT16 y_bottom = new_y + coll_offset_h;
			UINT16 new_tile_y = SUBPX_TO_TILE(y_bottom);

			UINT16 tile_y_start = SUBPX_TO_TILE(data->pos.y + coll_offset_h) - 1;
			UINT16 tile_y_end = new_tile_y;
			UINT8 tile_y_offset = FALSE;

			// If previously data->grounded and gravity is not enough to pull us down to
			// the next tile, manually check it for the next slope This prevents the
			// "animation glitch" when going down slopes
			if (prev_grounded && (tile_y_end == (tile_y_start + 1))) {
				tile_y_end += 1;
				tile_y_offset = TRUE;
			}

			UINT16 x_mid_coord = data->pos.x + sp_half_width + PX_TO_SUBPX(1);
			UINT16 tile_x = SUBPX_TO_TILE(x_mid_coord);

			tile = tile_col_test_range_y(COLLISION_SLOPE_ANY, tile_x, tile_y_start, tile_y_end);
			if (tile) {
				const UINT8 slope_type = (tile & COLLISION_SLOPE);
				UINT8 x_offset = SUBPX_TILE_REMAINDER(x_mid_coord);
				INT16 offset = 0;

				switch (slope_type) {
					case COLLISION_SLOPE_45_RIGHT:
						offset = (PX_TO_SUBPX(8) - x_offset) - coll_offset_h;
						break;
					case COLLISION_SLOPE_225_RIGHT_BOT:
						offset = (PX_TO_SUBPX(8) - DIV_2(x_offset)) - coll_offset_h;
						break;
					case COLLISION_SLOPE_225_RIGHT_TOP:
						offset = (PX_TO_SUBPX(4) - DIV_2(x_offset)) - coll_offset_h;
						break;
					case COLLISION_SLOPE_45_LEFT:
						offset = x_offset - coll_offset_h;
						break;
					case COLLISION_SLOPE_225_LEFT_BOT:
						offset = DIV_2(x_offset) - coll_offset_h + PX_TO_SUBPX(4);
						break;
					case COLLISION_SLOPE_225_LEFT_TOP:
						offset = DIV_2(x_offset) - coll_offset_h;
						break;
				}				

				UINT16 slope_y_coord = TILE_TO_SUBPX(tile_hit_y) + offset - 1;

				// If going downwards into a slope, don't snap to it unless
				// we've actually collided
				if (prev_grounded || slope_y_coord <= new_y) {
					// If we are moving up a slope, check for top collision
					UINT16 slope_top_tile_y = SUBPX_TO_TILE(slope_y_coord);

					data->plat.slope_y = tile_hit_y;
					data->plat.on_slope = tile;
					data->grounded = TRUE;

					UINT8 top_tile = tile_col_test_range_x(COLLISION_BOTTOM, slope_top_tile_y, tile_x_start, tile_x_end);
					if (top_tile) {
						data->vel.y = 0;
						data->vel.x = 0;
						data->pos.x -= plat_delta_x;
					} else {
						data->pos.y = slope_y_coord;
						data->vel.y = 0;
	#ifdef ENABLE_PLATFORM_DROP_THROUGH
						data->plat.drop_timer = 0;
	#endif
					}
					goto finally_finish;	// Renamed from "goto finally_check_actor_col;"
				}
			}
						
			// Tile snap threshold
			// If offset into tile is greater than amount moved down this frame
			// then must have started below top of the tile and should fall through
			if (!prev_on_slope && (SUBPX_TILE_REMAINDER(y_bottom) > SUBPX_TILE_REMAINDER(plat_delta_y))) {
				goto finally_update_y;
			}
			
			tile = tile_col_test_range_x(COLLISION_TOP, new_tile_y, tile_x_start, tile_x_end);
			if (tile) {
	#ifdef ENABLE_PLATFORM_DROP_THROUGH
				// Only drop through COLLISION_PLATFORM, not COLLISION_TOP
				if (data->plat.drop_timer && (tile & PLATFORM_BIT))
				{
					goto finally_update_y;
				}
	#endif
				new_y = TILE_TO_SUBPX(tile_hit_y) - coll_offset_h - 1;
				//plat_is_actor_attached = FALSE; // Detach when MP moves through a solid tile.
				data->vel.y = 0;
	#ifdef ENABLE_PLATFORM_DROP_THROUGH
				data->plat.drop_timer = 0;
	#endif
				data->grounded = TRUE;
			}
		finally_update_y:
			data->pos.y = new_y;

		} else {

			// Moving Upward
			UINT16 tile_y = SUBPX_TO_TILE(new_y);
			UINT8 tile = tile_col_test_range_x(COLLISION_BOTTOM, tile_y, tile_x_start, tile_x_end);

			if (tile) {
				// Hit the ceiling
				new_y = TILE_TO_SUBPX(tile_hit_y + 1) + 1;
				data->vel.y = 0;
			}
			data->pos.y = new_y;
		}
	}
	
finally_finish:
	
	this->x = SUBPX_TO_PX(data->pos.x);
	this->y = SUBPX_TO_PX(data->pos.y);
	
}
