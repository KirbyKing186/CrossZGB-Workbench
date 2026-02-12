#ifndef INTERRUPTS_H
#define INTERRUPTS_H

#include <gbdk/platform.h>
#include "ZGBMain.h"
#include "Scroll.h"
#include "Palette.h"

extern palette_color_t isrColor;
extern palette_color_t gradient_colors[DEVICE_SCREEN_PX_HEIGHT];

void InitSpecialInterrupts(palette_color_t start_color, palette_color_t end_color, UINT8 lcd_space) NONBANKED;
void RestoreDefaultInterrupts(void) NONBANKED;
void effect_isr(void) NONBANKED;
void build_gradient(palette_color_t start_color, palette_color_t end_color);

#endif
