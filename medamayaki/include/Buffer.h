#include <gbdk/platform.h>

#define BUFFER_SIZE 8192

#ifdef BUFFER_A_USE
extern UINT8 buffer_data_a[BUFFER_SIZE];
#endif
#ifdef BUFFER_B_USE
extern UINT8 buffer_data_b[BUFFER_SIZE];
#endif