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

CreateButton(4, inputController.bottom + sprite_get_height(spr_Logout) + 5,
	spr_Logout, "Instances",
	self, 1);
playerUIData = instance_create_layer(
	4, inputController.bottom + sprite_get_height(spr_Logout) * 2 + 5 * 2,
	"NormalUI", obj_CharacterData);