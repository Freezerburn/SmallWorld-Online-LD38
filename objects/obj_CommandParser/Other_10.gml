/// @description Handle command

var baseCommand = ds_list_find_value(command, 0);
switch (baseCommand) {
	case "quit":
	case "exit":
	case "q":
		game_end();
	default:
		toWrite = commandFullText;
		with (inputController) {
			event_user(0);
		}
}