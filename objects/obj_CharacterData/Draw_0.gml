/// @description

draw_set_font(fnt_UserInput);
draw_set_color(c_white);

draw_text(x + playerHealthIcon.sprite_width + 4, y,
	string(global.playerHealth) + "/" + string(global.playerMaxHealth));
draw_text(x + playerAttackIcon.sprite_width + 4, playerAttackIcon.y,
	string(global.playerAttack));
draw_text(x + playerDefenseIcon.sprite_width + 4, playerDefenseIcon.y,
	string(global.playerDefense));
draw_text(x + playerGoldIcon.sprite_width + 4, playerGoldIcon.y,
	string(global.playerGold));
	
draw_text(256, y, "Helmet: ");
draw_text(itemTextX, y, global.playerHelmet[0]);

draw_text(256, y + maxFontHeight + 4, "Armor: ");
draw_text(itemTextX, y + maxFontHeight + 4, global.playerArmor[0]);

draw_text(256, y + (maxFontHeight + 4) * 2, "Weapon: ");
draw_text(itemTextX, y + (maxFontHeight + 4) * 2, global.playerWeapon[0]);

draw_text(256, y + (maxFontHeight + 4) * 3, "Shield: ");
draw_text(itemTextX, y + (maxFontHeight + 4) * 3, global.playerShield[0]);

draw_text(256, y + (maxFontHeight + 4) * 4, "Pants: ");
draw_text(itemTextX, y + (maxFontHeight + 4) * 4, global.playerPants[0]);

draw_text(256, y + (maxFontHeight + 4) * 5, "Boots: ");
draw_text(itemTextX, y + (maxFontHeight + 4) * 5, global.playerBoots[0]);

// Debug drawing
draw_text(x, playerGoldIcon.y + playerGoldIcon.sprite_height + 10,
	"Time Cost: " + string(global.currentTimeCost));