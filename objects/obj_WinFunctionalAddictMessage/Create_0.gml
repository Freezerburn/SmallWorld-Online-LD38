/// @description

deathText = "You... Win?";
deathDescription = "Honestly, it's kind of mixed. You've screwed up here and there, and " +
	"continue to play SmallWorld Online a good amount. You still have your relationship " +
	"with your girlfriend and your job, but every so often your eyes glaze over when " +
	"talking with someone as you think about SmallWorld some more...";
	
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