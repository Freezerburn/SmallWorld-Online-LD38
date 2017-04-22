/// @description Handle command

var baseCommand = ds_list_find_value(command, 0);
switch (baseCommand) {
	case "quit":
	case "exit":
	case "q":
		game_end();
		break;
		
	// General case of going a direction.
	case "go":
	case "move":
		if ds_list_size(command) > 1 {
			GoDirection(ds_list_find_value(command, 1), toWrite);
		} else {
			ds_list_add(toWrite, "You must specify a direction to go.");
		}
		break
		
	// Specific shortcuts for going a direction.
	case "e":
	case "w":
	case "s":
	case "n":
	case "nw":
	case "ne":
	case "sw":
	case "se":
		GoDirection(baseCommand, toWrite);
		break;
		
	// TODO: Workflow for talking.
	case "talk":
		break;
		
	// TODO: Implement fighting in the dungeon.
	// Can ONLY use this in the dungeon to level up and stuff?
	case "fight":
		if global.currentRoom.name == "Dungeon" {
			ds_list_add(toWrite, "You fight some monsters and gain experience.");
		} else {
			ds_list_add(toWrite, "You cannot fight anybody here.");
		}
		break;
		
	// TODO: workflow for logging out.
	case "logout":
		break;
		
	// TODO: Print help.
	case "help":
		break;
		
	default:
		// TODO: Pick from a list of funny responses.
		ds_list_add(toWrite, "I do not understand");
}

with (inputController) {
	event_user(0);
}
ds_list_clear(toWrite);