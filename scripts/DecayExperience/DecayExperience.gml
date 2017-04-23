///DecayExperience(amount);
var xpLost = ceil(global.playerTotalExperience * argument0);
var levelsLost = 0;
var hpLost = 0;
var attackLost = 0;
var defenseLost = 0;

global.playerTotalExperience -= xpLost;
global.playerExperience -= xpLost;

if global.playerExperience < 0 {
	if global.playerLevel == 1 {
		global.playerExperience = 0;
	} else {
		levelsLost = 1;
		global.playerLevel--;
						
		var bonuses = global.levelBonuses[global.playerLevel - 1];
		hpLost = bonuses[0];
		attackLost = bonuses[1];
		defenseLost = bonuses[2];
		global.playerMaxHealth -= hpLost;
		global.playerHealth = global.playerMaxHealth;
		global.playerAttack -= attackLost;
		global.playerDefense -= defenseLost;
							
		global.playerNextLevelExperience = global.experienceAmounts[global.playerLevel - 1];
		global.playerExperience = global.playerNextLevelExperience + global.playerExperience;
		// Can only lose 1 level at a time. Losing more than one at a time is more than
		// I want to code right now.
		if global.playerExperience < 0 {
			global.playerExperience = 0;
		}
	}
}

return [xpLost, levelsLost, hpLost, attackLost, defenseLost];