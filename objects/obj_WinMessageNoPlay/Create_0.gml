/// @description

deathText = "You Win!";
deathDescription = "After logging in and fiddling around a bit, you don't see the appeal " +
	" of the game and log out, uninstalling the game permanently.";
	
draw_set_font(fnt_LogoutSummary);
deathTextWidth = string_width(deathText);
deathTextX = room_width / 2 - deathTextWidth / 2;
deathTextY = 100;
deathDescriptionWidth = string_width_ext(deathDescription, -1, 700);
deathDescriptionX = room_width / 2 - deathDescriptionWidth / 2;
deathDescriptionY = deathTextY + string_height(deathText) + 50;

/// CreateButton(x, y, spriteIndex, layerId, callbackInstance, userEventNumber);
CreateButton(room_width / 2 - sprite_get_width(spr_Restart) / 2,
	deathDescriptionY + string_height_ext(deathDescription, -1, 700) + 100,
	spr_Restart,
	"Instances", self, 0);