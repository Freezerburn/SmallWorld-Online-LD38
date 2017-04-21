/// GetRoomDescription(full, output);

var full = argument0;
var output = argument1;
if full {
	ds_list_add(output, global.currentRoom.description);
	if ds_map_size(global.currentRoom.directions) > 0 {
		var exitsOutput = "Exits are: ";
		for (var key = ds_map_find_first(global.currentRoom.directions); !is_undefined(key); key = ds_map_find_next(global.currentRoom.directions, key)) {
			exitsOutput += ReadableDirection(key) + ", ";
		}
		exitsOutput = string_copy(exitsOutput, 1, string_length(exitsOutput) - 2);
		ds_list_add(output, exitsOutput);
	}
} else {
	ds_list_add(output, global.currentRoom.shortDescription);
}
