/// @description

playerLVIcon = instance_create_layer(x, y, layer, obj_SimpleUISprite);
playerLVIcon.sprite_index = spr_LV;

playerXPIcon = instance_create_layer(x, playerLVIcon.y + playerLVIcon.sprite_height + 4, layer, obj_SimpleUISprite);
playerXPIcon.sprite_index = spr_XP;

playerHealthIcon = instance_create_layer(x, playerXPIcon.y + playerXPIcon.sprite_height + 4, layer, obj_SimpleUISprite);
playerHealthIcon.sprite_index = spr_Heart;

playerAttackIcon = instance_create_layer(x, playerHealthIcon.y + playerHealthIcon.sprite_height + 4,
	layer, obj_SimpleUISprite);
playerAttackIcon.sprite_index = spr_Sword;

playerDefenseIcon = instance_create_layer(x, playerAttackIcon.y + playerAttackIcon.sprite_height + 4,
	layer, obj_SimpleUISprite);
playerDefenseIcon.sprite_index = spr_Shield;

playerGoldIcon = instance_create_layer(x, playerDefenseIcon.y + playerDefenseIcon.sprite_height + 4,
	layer, obj_SimpleUISprite);
playerGoldIcon.sprite_index = spr_Coin;
playerGoldIcon.image_speed = 0;

draw_set_font(fnt_UserInput);
maxFontHeight = string_height("M");
itemTextX = 256 + string_width("Weapon: ");