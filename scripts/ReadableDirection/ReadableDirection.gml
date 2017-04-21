var dir = argument0;
switch (dir) {
case "west":
case "east":
case "north":
case "south":
case "northwest":
case "northeast":
case "southeast":
case "southwest":
	return dir;

case "w":
	return "west";
case "e":
	return "east";
case "n":
	return "north";
case "s":
	return "south";
case "nw":
	return "northwest";
case "ne":
	return "northeast";
case "se":
	return "southeast";
case "sw":
	return "southwest";
}