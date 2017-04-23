/// GoDirection(direction, output);

var dir = argument0;
var output = argument1;
dir = StandardizeDirection(dir);
if is_undefined(dir) {
	ds_list_add(output, "I do not understand that direction.");
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
if ds_map_exists(global.roomsSeen, maybeOtherRoom.name) {
	GetRoomDescription(false, output);
} else {
	GetRoomDescription(true, output);
	ds_map_add(global.roomsSeen, maybeOtherRoom.name, true);
}
global.currentTimeCost += global.moveTimeCost;

return maybeOtherRoom;