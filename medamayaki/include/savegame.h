#ifndef SAVEGAME_H
#define SAVEGAME_H

#include <gb/gb.h>
#include "SRAM.h"

typedef struct {
	SAVEGAME_HEADER;
	UINT8 buffer_level;
} Savegame;

extern Savegame savegame;

#endif
