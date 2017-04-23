/// @description Delete chars with delay

if global.logoutActive {
	exit;
}

if keyboard_lastkey == vk_backspace && canKey {
	if ds_list_size(charObjectsArray) == 0 {
		exit;
	}
		
	var lastCharInstance = ds_list_find_value(charObjectsArray, ds_list_size(charObjectsArray) - 1);
	ds_list_delete(charObjectsArray, ds_list_size(charObjectsArray) - 1);
	var charWidth = string_width(lastCharInstance.drawChar);
	instance_destroy(lastCharInstance);
	currentHorzLoc -= charWidth + fontHorzBuffer;
	UpdateCursorPos(cursor, currentHorzLoc);
		
	keyboard_lastkey = -1;
	keyboard_lastchar = "";
	canKey = false;
	alarm[0] = minTimeBetweenKey;
	
	audio_play_sound(snd_KeyClick, 10, false);
}