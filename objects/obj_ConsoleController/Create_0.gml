/// @description

writeLines = ds_list_create();
drawLines = ds_list_create();
textOffset = 0;
totalTextHeight = 0;

textSurface = -1;
surfaceHeight = 512;
surfaceWidth = 512;

draw_set_font(fnt_ConsoleOutput);
var testString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
maxUserInputHeight = string_height(testString);

verticalBuffer = 2;
horizontalBuffer = 2;

scrollbarWidth = 15;
scrollbarExists = false;
scrollSpeed = 8;
scrollbarY = 0;
scrollbarHeight = 30;

textDrawWidth = surfaceWidth - scrollbarWidth - horizontalBuffer;