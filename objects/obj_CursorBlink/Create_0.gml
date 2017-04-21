/// @description

var textUILayer = layer_get_id("TextUI")
childCharacter = instance_create_layer(x, y, textUILayer, obj_TextCharacter);
childCharacter.drawChar = "_";
childCharacter.visible = true ;

blinkTime = int64(game_get_speed(gamespeed_fps) * 0.5);