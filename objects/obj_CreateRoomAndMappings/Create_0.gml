/// @description Build all the room mappings

var layerId = layer_get_id("Instances");

var townRoom = instance_create_layer(0, 0, layerId, obj_RoomTown);
var blacksmithRoom = instance_create_layer(0, 0, layerId, obj_RoomBlacksmith);

AssociateRoom(townRoom, "n", blacksmithRoom);

global.currentRoom = townRoom;