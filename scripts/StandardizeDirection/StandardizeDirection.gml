/// StandardizeDirection(direction);
// Ends game if an unrecognized directions is passed in, so do not give it
// player raw input!

var dir = argument0;
dir = string_copy(dir, 0, string_length(dir));
string_lower(dir);
switch (dir) {
case "west":
	return "w";
case "east":
	return "e";
case "north":
	return "n";
case "south":
	return "s";
case "northwest":
	return "nw";
case "northeast":
	return "ne";
case "southeast":
	return "se";
case "southwest":
	return "sw";

case "w":
case "e":
case "n":
case "s":
case "nw":
case "ne":
case "se":
case "sw":
	return dir;
}

return undefined;