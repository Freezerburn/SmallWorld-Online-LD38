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
		GoDirection(ds_list_find_value(command, 1), toWrite);
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
		
	default:
		ds_list_add(toWrite, "I do not understand");
}

with (inputController) {
	event_user(0);
}
ds_list_clear(toWrite);