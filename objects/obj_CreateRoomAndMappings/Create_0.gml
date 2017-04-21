/// @description Build all the room mappings

var layerId = layer_get_id("Instances");

var startTestRoom = instance_create_layer(0, 0, layerId, obj_StartTestRoom);
var otherTestRoom = instance_create_layer(0, 0, layerId, obj_OtherTestRoom);

AssociateRoom(startTestRoom, "e", otherTestRoom);

global.currentRoom = startTestRoom;