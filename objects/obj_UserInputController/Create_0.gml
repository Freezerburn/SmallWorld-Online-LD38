/// @description

//show_debug_overlay(true);

charObjectsArray = ds_list_create();
textLayer = layer_get_id("TextUI");
textToHandle = "";

draw_set_font(fnt_UserInput);
var testString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
maxUserInputHeight = string_height(testString);
fontVertBuffer = 6;

x = 6;
fontHorzBuffer = 2;
arrowWidth = string_width(">");
startingHorzLoc = x + fontHorzBuffer * 2 + arrowWidth * 3;
currentHorzLoc = startingHorzLoc;

console = instance_create_layer(x + fontHorzBuffer, 0,
	textLayer, obj_ConsoleController);
userInputY = console.surfaceHeight + maxUserInputHeight + fontVertBuffer;
console.y = userInputY - maxUserInputHeight - console.surfaceHeight;

cursor = instance_create_layer(currentHorzLoc, userInputY, textLayer, obj_CursorBlink);
UpdateCursorPos(cursor, currentHorzLoc);
with (cursor) {
	alarm[0] = blinkTime;
}

var userInputPre = instance_create_layer(x + fontHorzBuffer, userInputY, textLayer, obj_TextCharacter);
userInputPre.drawChar = ">";
userInputPre = instance_create_layer(x + fontHorzBuffer + string_width(">"), userInputY,
	textLayer, obj_TextCharacter);
userInputPre.drawChar = ">";

minTimeBetweenKey = round(game_get_speed(gamespeed_fps) * 0.03);
canKey = true;