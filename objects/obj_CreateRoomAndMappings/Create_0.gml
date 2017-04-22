/// @description Build all the room mappings

var layerId = layer_get_id("Instances");

var townRoom = instance_create_layer(0, 0, layerId, obj_RoomTown);
var blacksmithRoom = instance_create_layer(0, 0, layerId, obj_RoomBlacksmith);
var dungeonRoom = instance_create_layer(0, 0, layerId, obj_RoomDungeon);
var tavernRoom = instance_create_layer(0, 0, layerId, obj_RoomTavern);

AssociateRoom(townRoom, "n", blacksmithRoom);
AssociateRoom(townRoom, "e", dungeonRoom);
AssociateRoom(townRoom, "s", tavernRoom);

global.currentRoom = townRoom;