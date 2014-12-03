/*
 *  kmain.c
 */

static const short SCREEN_ROWS = 25, SCREEN_COLS = 80;
static char *ScreenMem = (char*)0xb8000;  // video mem begins here.

/* Clears the screen
 */
static void clearscreen()
{
  unsigned int i = 0;
  while(i < SCREEN_ROWS * SCREEN_COLS * 2) {
    ScreenMem[i] = ' '; // blank char
    ScreenMem[i+1] = 0x07; // attribute byte: light grey on black
    i += 2;
  }
}

/* Prints str to the screen starting at position 0,0
 */
static int print(const char *str, unsigned int length)
{
  unsigned int i = 0, j = 0;
  while(str[j] != '\0' && j < length) {
    ScreenMem[i] = str[j];
    ScreenMem[i+1] = 0x07; // attribute byte: light grey on black
    j++;
    i += 2;
  }
  return j;
}

/* The main kernel launch routine
 */
void kmain(void)
{
  clearscreen();
  print("Hello World!", 12);
  return;
}
