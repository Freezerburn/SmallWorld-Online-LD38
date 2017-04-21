/// GoDirection(direction, output);

var dir = argument0;
var output = argument1;
dir = StandardizeDirection(dir);
if is_undefined(dir) {
	return undefined;
}

var roomInstance = global.currentRoom;
var maybeOtherRoom = ds_map_find_value(roomInstance.directions, dir);
if is_undefined(maybeOtherRoom) {
	ds_list_add(output, "There is no exit to the " + ReadableDirection(dir));
	return undefined;
}

global.currentRoom = maybeOtherRoom;
ds_list_add(output, "You go " + ReadableDirection(dir));
GetRoomDescription(true, output);

return maybeOtherRoom;