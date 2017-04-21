/// @description Set self as parser for input

inputController = instance_find(obj_UserInputController, 0);
inputController.parser = self;
command = -1;
commandFullText = "";
toWrite = ds_list_create();

GetRoomDescription(true, toWrite);
with (inputController) {
	event_user(0);
}
ds_list_clear(toWrite);