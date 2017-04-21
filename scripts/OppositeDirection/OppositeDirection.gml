/// OppositeDirection(direction);
// Returns a standardized direction.
// Ends game if an unrecognized directions is passed in, so do not give it
// player raw input!

var dir = argument0;
dir = string_copy(dir, 0, string_length(dir));
string_lower(dir);
switch (dir) {
case "west":
case "w":
	return "e";
case "east":
case "e":
	return "w";
case "north":
case "n":
	return "s";
case "south":
case "s":
	return "n";
case "northwest":
case "nw":
	return "se";
case "northeast":
case "ne":
	return "sw";
case "southeast":
case "se":
	return "nw";
case "southwest":
case "sw":
	return "ne";
}

show_debug_message("OppositeDirection received unrecognized direction: " +
	dir + "!");
game_end();