#include "ZGBMain.h"
#include "Keys.h"
#include "Scroll.h"
#include "Math.h"

#include "Camera.h"
#include "Platformer.h"

#define TYPE_NONE  0		// No Look-Ahead
#define TYPE_DIR 1			// Automatic Look-Ahead based on the sprite's direction
#define TYPE_INPUT 2		// Manual Look-Ahead based on Left or Right inputs
#define LOOKAHEAD_TYPE (TYPE_DIR)

#define LOOKAHEAD_PX 16

#define CAM_OFFSET_X 0
#define CAM_OFFSET_Y -24

INT8 lookahead_offset;

void SpriteCameraUpdate(Sprite* this) BANKED {
	INT16 cam_pos_x = this->x - (SCREEN_WIDTH >> 1) + (this->coll_w >> 1) + CAM_OFFSET_X;
	UINT16 cam_lim_x = scroll_w - SCREEN_WIDTH;
	
	INT16 cam_pos_y = this->y - (SCREEN_HEIGHT >> 1) + (this->coll_h >> 1) + CAM_OFFSET_Y;
	UINT16 cam_lim_y = scroll_h - SCREEN_HEIGHT;
	
	#if LOOKAHEAD_TYPE != TYPE_NONE
		INT8 lookahead_update = 0;
			#if LOOKAHEAD_TYPE == TYPE_DIR
			CUSTOM_DATA* data = (CUSTOM_DATA*)this->custom_data;
			if (data->dir < 0) {
				lookahead_update = -1;
			} else {
				lookahead_update = 1;
			}
			#elif LOOKAHEAD_TYPE == TYPE_INPUT
			if (KEY_PRESSED(J_LEFT)) {
				lookahead_update = -1;
			} else if (KEY_PRESSED(J_RIGHT)) {
				lookahead_update = 1;
			}
			#endif
		lookahead_offset = CLAMP(lookahead_offset + lookahead_update, -LOOKAHEAD_PX, LOOKAHEAD_PX);
		cam_pos_x += lookahead_offset;
	#endif
	
	if (cam_pos_x < 0) {
		cam_pos_x = 0;
	} else if (cam_pos_x > cam_lim_x) {
		cam_pos_x = cam_lim_x;
	}
	if (cam_pos_y < 0) {
		cam_pos_y = 0;
	} else if (cam_pos_y > cam_lim_y) {
		cam_pos_y = cam_lim_y;
	}
	MoveScroll(cam_pos_x, cam_pos_y);
}
