#include "ZGBMain.h"
#include "Scroll.h"
#include "Palette.h"
#include "Interrupts.h"

// Defined in order to be disabled in START
void LCD_isr(void);

UINT8 lcd_step = 8;		// Default value
palette_color_t isrColor;
palette_color_t gradient_colors[DEVICE_SCREEN_PX_HEIGHT];

void effect_isr(void) NONBANKED {
	
	isrColor = gradient_colors[LY_REG];
	
	while (STAT_REG & STATF_BUSY);
	
	// Execute Color effect
	/*
	Example code:
	_CPS_REG = (PALETTE_ENTRY << 1) | 0x80; 
	_CPD_REG = isrColor & 0xFF;
	_CPD_REG = isrColor >> 8;
	The above function will apply the RGB value of `isrColor` to the palette entry at PALETTE_ENTRY.
	Replace _ with B to affect a background palette entry, or replace _ with O to affect a sprite palette entry.
	
	Palette entries on CGB consist of 64 values (0x00 to 0x3F). Background color palettes are first, and sprite color palettes are last. To give an idea of the format:
	0x00 is the first entry of the first palette
	0x01 is the second entry of the first palette
	0x02 is the third entry of the first palette
	0x03 is the fourth entry of the first palette
	0x04 is the first entry of the second background palette
	0x08 is the first entry of the third background palette
	0x17 is the first entry of the eighth background palette
	*/
	BCPS_REG = (0x02 << 1) | 0x80; 
	BCPD_REG = isrColor & 0xFF;
	BCPD_REG = isrColor >> 8;
	BCPS_REG = (0x06 << 1) | 0x80; 
	BCPD_REG = isrColor & 0xFF;
	BCPD_REG = isrColor >> 8;
	BCPS_REG = (0x0B << 1) | 0x80; 
	BCPD_REG = isrColor & 0xFF;
	BCPD_REG = isrColor >> 8;
	BCPS_REG = (0x0E << 1) | 0x80; 
	BCPD_REG = isrColor & 0xFF;
	BCPD_REG = isrColor >> 8;
	BCPS_REG = (0x11 << 1) | 0x80; 
	BCPD_REG = isrColor & 0xFF;
	BCPD_REG = isrColor >> 8;
	BCPS_REG = (0x17 << 1) | 0x80; 
	BCPD_REG = isrColor & 0xFF;
	BCPD_REG = isrColor >> 8;
	
	// Increment LYC_REG
	LYC_REG += lcd_step;
	// Check if LYC_REG has made it past the bottom of the screen
	if (LYC_REG > 143u) LYC_REG = 0;
	
}

void build_gradient(palette_color_t start_color, palette_color_t end_color) {

    UINT8 r0 = PAL_RED(start_color);
    UINT8 g0 = PAL_GREEN(start_color);
    UINT8 b0 = PAL_BLUE(start_color);

    UINT8 r1 = PAL_RED(end_color);
    UINT8 g1 = PAL_GREEN(end_color);
    UINT8 b1 = PAL_BLUE(end_color);

    for (UINT8 step = 0; step < DEVICE_SCREEN_PX_HEIGHT; step++) {
		gradient_colors[step] = RGB(
		r0 + ((r1 - r0) * step) / (DEVICE_SCREEN_PX_HEIGHT - 1),
		g0 + ((g1 - g0) * step) / (DEVICE_SCREEN_PX_HEIGHT - 1),
		b0 + ((b1 - b0) * step) / (DEVICE_SCREEN_PX_HEIGHT - 1)
		);
    }
}

void InitSpecialInterrupts(palette_color_t start_color, palette_color_t end_color, UINT8 lcd_space) NONBANKED {
	lcd_step = lcd_space;
	UINT8 is_display_on = LCDC_REG & LCDCF_ON; // If the display was on, turn it off while running interrupt code and turn it back on when done. Otherwise, keep it off.
	if (is_display_on) DISPLAY_OFF;
	CRITICAL {
		remove_LCD(effect_isr);
		remove_LCD(LCD_isr);
		LYC_REG = 0;
		build_gradient(start_color, end_color);
		add_LCD(effect_isr);
	}
	if (is_display_on) DISPLAY_ON;
}

void RestoreDefaultInterrupts(void) NONBANKED {
	CRITICAL {
		STAT_REG = STATF_LYC;
		remove_LCD(effect_isr);
		remove_LCD(LCD_isr);
		add_LCD(LCD_isr);
	}
}
