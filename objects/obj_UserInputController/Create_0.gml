/// @description

//show_debug_overlay(true);

charObjectsArray = ds_list_create();
textLayer = layer_get_id("TextUI");
textToHandle = "";

draw_set_font(fnt_UserInput);
var testString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
maxUserInputHeight = string_height(testString);
fontVertBuffer = 8;
userInputY = room_height - maxUserInputHeight - fontVertBuffer;

fontHorzBuffer = 2;
startingHorzLoc = 30;
currentHorzLoc = startingHorzLoc;

cursor = instance_create_layer(currentHorzLoc, userInputY, textLayer, obj_CursorBlink);
UpdateCursorPos(cursor, currentHorzLoc);
with (cursor) {
	alarm[0] = blinkTime;
}

var userInputPre = instance_create_layer(fontHorzBuffer, userInputY, textLayer, obj_TextCharacter);
userInputPre.drawChar = ">";
userInputPre = instance_create_layer(fontHorzBuffer * 2 + string_width(">"), userInputY,
	textLayer, obj_TextCharacter);
userInputPre.drawChar = ">";

minTimeBetweenKey = round(game_get_speed(gamespeed_fps) * 0.03);
canKey = true;