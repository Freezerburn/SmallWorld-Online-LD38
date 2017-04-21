/// StringExtractWords(str);

// TODO: Version that takes an output ds list.
var ret = ds_list_create();
var str = argument0;
var concat = "";

//show_debug_message("extracting string: " + str);
for (var i = 1; i < string_length(str) + 1; i++) {
	var char = string_char_at(str, i);
	if char == " " {
		if string_byte_length(concat) > 0 {
			//show_debug_message("1 found part: " + concat);
			ds_list_add(ret, concat);
			concat = "";
		}
		continue;
	} else {
		concat += char;
	}
}

if string_byte_length(concat) > 0 {
	//show_debug_message("2 found part: " + concat);
	ds_list_add(ret, concat);
}

return ret;