/// AssociateRoom(roomFromInstance, directionTo, toRoomInstance);

var roomFromInstance = argument0;
var directionTo = argument1;
directionTo = StandardizeDirection(directionTo);
var directionFrom = OppositeDirection(directionTo);
var toRoomInstance = argument2;

ds_map_add(roomFromInstance.directions, directionTo, toRoomInstance);
ds_map_add(toRoomInstance.directions, directionFrom, roomFromInstance);