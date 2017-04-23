/// @description

deathText = "You Win!";
deathDescription = "Despite how addicting SmallWorld Online is, you managed to keep " +
	"yourself from getting addicted. After playing it for a while, you somewhat lose " +
	"interest and decide to stop playing. There are more important things to worry about, " +
	"such as your upcoming wedding...";
	
draw_set_font(fnt_LoadingSmallWorld);
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