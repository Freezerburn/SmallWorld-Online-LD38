show_debug_overlay(true);

global.roomMapping = ds_map_create();
global.currentRoom = undefined;

global.penalties = 0;
global.positives = 0;
global.currentTimeCost = 0;

global.timeCostBeforePenalty = 100;
global.moveTimeCost = 1;
global.blacksmithCostTimeCost = 1;
global.talkTimeCost = 2;
global.buyTimeCost = 2;
global.dungeonTimeCost = 10;
global.dailyQuestTimeCost = 5;
global.eventTimeCost = 15;

global.playerHealth = 100;
global.playerMaxHealth = 100;
global.playerAttack = 10;
global.playerDefense = 2;
global.playerGold = 150;

global.playerHelmet = ["None", 0];
global.playerArmor = ["Rags", 1];
global.playerWeapon = ["Rusty Sword", 1];
global.playerShield = ["None", 0];
global.playerPants = ["Rags", 1];
global.playerBoots = ["None", 0];

// Equipment has the following structure:
// First index goes to a piece of equipment
// Inner array has structure: name, gold cost, equipment stat
// so ["Sword", 150, 10] would be a sword costing 150 with +10 attack.
global.allHelmets = [
	["None", 0, 0],
	["Cloth Cap", 150, 1]
];
global.allArmor = [
	["None", 0, 0],
	["Rags", 50, 1],
	["Tank Top", 150, 1],
	["Legit Shirt", 250, 2]
];
global.allWeapons = [
	["Fists", 0, 1],
	["Rusty Sword", 50, 9],
	["Dull Sword", 150, 5],
	["Tarnished Sword", 250, 10],
	["Somewhat Sharp Sword", 350, 15]
];
global.allShields = [
	["None", 0, 0],
	["Pot Lid", 150, 1],
	["Barrel Lid", 250, 2]
];
global.allPants = [
	["None", 0, 0],
	["Rags", 50, 1],
	["Bootie Shorts", 150, 1]
];
global.allBoots = [
	["None", 0, 0],
	["Worn Out Sandals", 150, 1]
];

room_goto_next();