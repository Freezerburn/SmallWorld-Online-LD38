/// @description Insert, input char

if keyboard_lastkey == vk_return {
	// TODO: Parse text.
	for (var i = 0; i < ds_list_size(charObjectsArray); i++) {
		var instance = ds_list_find_value(charObjectsArray, i);
		textToHandle += instance.drawChar;
		instance_destroy(instance);
	}
	ds_list_clear(charObjectsArray);
	currentHorzLoc = startingHorzLoc;
	UpdateCursorPos(cursor, currentHorzLoc);
		
	keyboard_lastkey = -1;
	keyboard_lastchar = "";
}

if keyboard_lastkey != -1 && keyboard_lastkey != vk_backspace {
	var newInstance = instance_create_layer(currentHorzLoc, userInputY, textLayer, obj_TextCharacter);
	newInstance.drawChar = keyboard_lastchar;
	ds_list_add(charObjectsArray, newInstance);

	currentHorzLoc += string_width(keyboard_lastchar) + fontHorzBuffer;
	UpdateCursorPos(cursor, currentHorzLoc);
	
	keyboard_lastkey = -1;
	keyboard_lastchar = "";
}

if string_length(textToHandle) > 0 {
	var original = string_copy(textToHandle, 1, string_length(textToHandle));
	string_lower(textToHandle);
	var words = StringExtractWords(textToHandle);
	var command = ds_list_find_value(words, 0);
	
	switch (command) {
	case "quit":
	case "exit":
	case "q":
		game_end();
	default:
		ds_list_add(instance_find(obj_ConsoleController, 0).drawLines, textToHandle);
	}
	
	textToHandle = "";
	ds_list_destroy(words);
}