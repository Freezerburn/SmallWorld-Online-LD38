//show_debug_overlay(true);

global.roomMapping = ds_map_create();
global.currentRoom = undefined;

global.penalties = 0;
global.positives = 0;
global.currentTimeCost = 0;

global.timeCostBeforePenalty = 100;
global.timeCostBeforeWarning = 70;
global.warningShown = false;

// TODO: Figure out how to express all the warnings and whatnot.
// Needs:
// - Multiple "pools" of things. So as the penalty count gets higher, the
//   severity of them goes up.
// - A way to track what the last warning was, so that we can display the
//   appropriate penalty if they get to it, or the appropriate positive.
// - A way to handle multiple "types" of "announcements". A warning might be
//   an outlook calendar reminder, for example, but not all of them are going to
//   be the same? (theoretically, at least) So we need to be able to define a thing
//   that will handle the announcement. Though I can just include the index of an
//   object to pass to instance creation, so that's actually pretty easy.
// - Remove announcements that have been used up. We don't want to display the
//   same thing twice.
// Three pools of things: mild, bad, severe
// Only one pool of positive things? Or should how bad you're into the game reflect
// what happens for positive things?
global.lastWarningDef = -1;
global.warningDefs = ds_list_create();
ds_list_add(global.warningDefs, ds_list_create()); // mild pool
ds_list_add(global.warningDefs[| 0],
	[obj_WarningL1_DateNightGirlfriend, 0]);
//ds_list_add(global.warningDefs[| 0],
//	[obj_WarningL1_FamilyDinner, 1]);
ds_list_add(global.warningDefs, ds_list_create()); // bad pool
ds_list_add(global.warningDefs, ds_list_create()); // severe pool

global.penaltyDefs = ds_list_create();
ds_list_add(global.penaltyDefs, ds_list_create()); // mild pool
ds_list_add(global.penaltyDefs[| 0],
	[obj_PenaltyL1_DateNightGirlfriend]);
ds_list_add(global.penaltyDefs, ds_list_create()); // bad pool
ds_list_add(global.penaltyDefs, ds_list_create()); // severe pool

global.positiveDefs = ds_list_create();
ds_list_add(global.positiveDefs, ds_list_create()); // mild pool
ds_list_add(global.positiveDefs, ds_list_create()); // bad pool
ds_list_add(global.positiveDefs, ds_list_create()); // severe po

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