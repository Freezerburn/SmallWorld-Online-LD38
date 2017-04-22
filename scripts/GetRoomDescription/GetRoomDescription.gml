/// GetRoomDescription(full, output);

var full = argument0;
var output = argument1;
if full {
	ds_list_add(output, global.currentRoom.description);
	GetRoomDirections(output);
} else {
	ds_list_add(output, global.currentRoom.shortDescription);
}
