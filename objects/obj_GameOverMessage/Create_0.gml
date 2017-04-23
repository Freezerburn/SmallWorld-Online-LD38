/// @description

deathText = "You Lose!";
deathDescription = "Unforunately, you couldn't handle balancing your real life with your " +
	"virtual life, and became completely enthralled to SmallWorld Online. At this point, " +
	"you've basically lost everything except your computer, which you manage to keep " +
	"running by mooching internet and power off of a friend that you easily take advantage " +
	"of. And you just keep playing, and playing, and playing...";
	
draw_set_font(fnt_LogoutSummary);
deathTextWidth = string_width(deathText);
deathTextX = room_width / 2 - deathTextWidth / 2;
deathTextY = 30;
deathDescriptionWidth = string_width_ext(deathDescription, -1, 700);
deathDescriptionX = room_width / 2 - deathDescriptionWidth / 2;
deathDescriptionY = deathTextY + string_height(deathText) + 50;

/// CreateButton(x, y, spriteIndex, layerId, callbackInstance, userEventNumber);
//CreateButton(room_width / 2 - sprite_get_width(spr_Restart) / 2,
//	deathDescriptionY + string_height_ext(deathDescription, -1, 700) + 100,
//	spr_Restart,
//	"Instances", self, 0);