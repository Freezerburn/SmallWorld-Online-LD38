/// @description Set self as parser for input

inputController = instance_find(obj_UserInputController, 0);
inputController.parser = self;
command = -1;
commandFullText = "";
toWrite = ds_list_create();

if !global.seenTutorial {
	global.seenTutorial = true;
	
	ds_list_add(toWrite, "Ah ha! It seems we have a new adventurer in our midst. Since " +
		"this is your first time logging in to SmallWorld Online, I'll give you a brief " +
		"rundown of how to play! Here are the commands you need to know:");
	ds_list_add(toWrite, "Type 'go <direction>' to move to a new room in that direction.");
	ds_list_add(toWrite, "'buy' and 'cost' can be used at the Blacksmith to buy new " +
		"equipment or check what the next piece of equipment will cost. Check with the " +
		"Blacksmith about what types of equipment you can buy. The Blacksmith is directly " +
		"north of here.");
	ds_list_add(toWrite, "'fight' will let you select a difficulty of monster to fight " +
		"when at the Dungeon. There are easy, medium, hard, and extreme monsters " +
		"hidden in the depths. Be careful though: dying will cause you to lose your hard " +
		"earned experience! The Dungeon is directly east from here.");
	ds_list_add(toWrite, "When your health is low from fighting, you can 'rest' in the " +
		"Tavern in order to fully recover it. They charge a small amount of gold for " +
		"this service. The Tavern is directly south from here.");
	ds_list_add(toWrite, "And finally, 'logout' will log you out of the game for the day. " +
		"Or, you can press the fancy button below to do the same.");
	ds_list_add(toWrite, "As a convenience, you can press up to repeat the last command.");
	ds_list_add(toWrite, "And that concludes the tutorial! Have fun in SmallWorld Online!");
	ds_list_add(toWrite, "And don't forget you can scroll up to see previous messages!");
}

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