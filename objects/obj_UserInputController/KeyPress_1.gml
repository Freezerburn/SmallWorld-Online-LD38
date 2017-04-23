/// @description Insert, input char

if global.logoutActive {
	exit;
}

if keyboard_lastkey == vk_return {
	for (var i = 0; i < ds_list_size(charObjectsArray); i++) {
		var instance = ds_list_find_value(charObjectsArray, i);
		textToHandle += instance.drawChar;
		instance_destroy(instance);
	}
	ds_list_clear(charObjectsArray);
	currentHorzLoc = startingHorzLoc;
	UpdateCursorPos(cursor, currentHorzLoc);
		
	audio_play_sound(snd_KeyClick2, 10, false);
	keyboard_lastkey = -1;
	keyboard_lastchar = "";
}

if keyboard_lastkey == vk_up {
	for (var i = 0; i < ds_list_size(charObjectsArray); i++) {
		var instance = ds_list_find_value(charObjectsArray, i);
		instance_destroy(instance);
	}
	currentHorzLoc = startingHorzLoc;
	
	for (var i = 1; i < string_length(lastText) + 1; i++) {
		var textChar = string_char_at(lastText, i);
		var nextHorzLoc = currentHorzLoc + string_width(textChar) + fontHorzBuffer;
		if nextHorzLoc > console.surfaceWidth {
			exit;
		}

		var newInstance = instance_create_layer(currentHorzLoc, userInputY, textLayer, obj_TextCharacter);
		newInstance.drawChar = textChar;
		ds_list_add(charObjectsArray, newInstance);

		currentHorzLoc = nextHorzLoc;
		UpdateCursorPos(cursor, currentHorzLoc);
	}
	
	keyboard_lastkey = -1;
	keyboard_lastkey = "";
}

if keyboard_lastkey != -1 && keyboard_lastkey != vk_backspace {
	var nextHorzLoc = currentHorzLoc + string_width(keyboard_lastchar) + fontHorzBuffer;
	if nextHorzLoc > console.surfaceWidth {
		exit;
	}

	var newInstance = instance_create_layer(currentHorzLoc, userInputY, textLayer, obj_TextCharacter);
	newInstance.drawChar = keyboard_lastchar;
	ds_list_add(charObjectsArray, newInstance);

	currentHorzLoc = nextHorzLoc;
	UpdateCursorPos(cursor, currentHorzLoc);
	
	audio_play_sound(snd_KeyClick2, 10, false);
	keyboard_lastkey = -1;
	keyboard_lastchar = "";
}

if string_length(textToHandle) > 0 {
	var original = string_copy(textToHandle, 1, string_length(textToHandle));
	string_lower(textToHandle);
	var words = StringExtractWords(textToHandle);
	
	parser.command = words;
	parser.commandFullText = original;
	with (parser) {
		event_user(0);
	}
	
	lastText = textToHandle;
	textToHandle = "";
	ds_list_destroy(words);
}