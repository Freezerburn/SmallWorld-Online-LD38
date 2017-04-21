/// @description Set up the basic things used for every room

if is_undefined(name) {
	show_debug_message("No room name set for " + object_get_name(object_index) + "!");
	game_end();
}
if is_undefined(shortDescription) {
	show_debug_message("No room  short description set for " + object_get_name(object_index) + "!");
	game_end();
}
if is_undefined(description) {
	show_debug_message("No room description set for " + object_get_name(object_index) + "!");
	game_end();
}

items = ds_list_create();
directions = ds_map_create();
RegisterRoom(self);