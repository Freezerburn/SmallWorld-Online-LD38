/// AssociateRoom(roomInstance);
// roomInstance must have a name property. Best to have it be a child of
// obj_BaseRoom.

var roomInstance = argument0;
ds_map_add(global.roomMapping, roomInstance.name, roomInstance);