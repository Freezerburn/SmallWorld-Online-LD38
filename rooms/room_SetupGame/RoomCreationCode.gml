//show_debug_overlay(true);

global.seenTutorial = false;

global.roomsSeen = ds_map_create();
ds_map_add(global.roomsSeen, "Town", true);

global.roomMapping = ds_map_create();
global.currentRoom = undefined;

global.firstTutorialDone = false;
global.secondTutorialDone = false;

global.logoutActive = false;
global.penalties = 0;
global.positives = 0;
global.prevTimeCost = 0;
global.currentTimeCost = 0;

global.showPositiveAfterBase = 15;
global.showPositiveRangeLower = -5;
global.showPositiveUpperRange = 15;

global.accumulatedTimeCost = 0;
global.penaltiesAccumulated = ds_list_create();
// TODO: Determine if this should be higher.
global.timeCostDeathCondition = 800;

// TODO: Determine if these shoudl be higher.
global.timeCostBeforePenalty = 100;
global.timeCostBeforeWarning = 60;
global.warningShown = false;
global.positiveAnnouncements = ds_list_create();

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
global.nextPositiveDef = -1;
global.showPositiveAfter = -1;
global.announcementPool = 0;
global.warningDefs = ds_list_create();
ds_list_add(global.warningDefs, ds_list_create()); // mild pool
ds_list_add(global.warningDefs[| 0], [obj_WarningL1_DateNightGirlfriend, 0]);
ds_list_add(global.warningDefs[| 0], [obj_WarningL1_FamilyDinner, 1]);
ds_list_add(global.warningDefs[| 0], [obj_WarningL1_PayBills, 2]);
ds_list_add(global.warningDefs[| 0], [obj_WarningL1_Bedtime, -1]);
	
ds_list_add(global.warningDefs, ds_list_create()); // bad pool
ds_list_add(global.warningDefs[| 1], [-1, -2]);
ds_list_add(global.warningDefs[| 1], [-1, -2]);
ds_list_add(global.warningDefs[| 1], [-1, -2]);
ds_list_add(global.warningDefs[| 1], [-1, -2]);
ds_list_add(global.warningDefs[| 1], [obj_WarningL2_GirlfriendNotice, 0]);
ds_list_add(global.warningDefs[| 1], [obj_WarningL2_ConcernedFriend, 1]);

ds_list_add(global.warningDefs, ds_list_create()); // severe pool

global.tutorialPenalties = ds_list_create();
ds_list_add(global.tutorialPenalties, obj_PenaltyL1_BossLate);

// Penalties that do not have a warning associated with them.
global.standalonePenalties = ds_list_create();
global.penaltyDefs = ds_list_create();

ds_list_add(global.penaltyDefs, ds_map_create()); // mild pool
ds_map_add(global.penaltyDefs[| 0], 0, [obj_PenaltyL1_DateNightGirlfriend]);
ds_map_add(global.penaltyDefs[| 0], 1, [obj_PenaltyL1_FamilyDinner]);
ds_map_add(global.penaltyDefs[| 0], 2, [obj_PenaltyL1_PayBills]);

ds_list_add(global.standalonePenalties, ds_list_create());

ds_list_add(global.penaltyDefs, ds_map_create()); // bad pool
ds_map_add(global.penaltyDefs[| 1], 0, [obj_PenaltyL2_GirlfriendNotice]);
ds_map_add(global.penaltyDefs[| 1], 1, [obj_PenaltyL2_ConcernedFriend]);

ds_list_add(global.standalonePenalties, ds_list_create());
ds_list_add(global.standalonePenalties[| 1], [obj_PenaltyL2_DoctorHealth]);
ds_list_add(global.standalonePenalties[| 1], [obj_PenaltyL2_BossAbsences]);
ds_list_add(global.standalonePenalties[| 1], [obj_PenaltyL2_MintTakeoutFood]);
ds_list_add(global.standalonePenalties[| 1], [obj_PenaltyL2_PayBills]);

ds_list_add(global.penaltyDefs, ds_map_create()); // severe pool

ds_list_add(global.standalonePenalties, ds_list_create());

global.nextPenaltyKeys = [
	ds_map_size(global.penaltyDefs[| 0]),
	ds_map_size(global.penaltyDefs[| 1]),
	ds_map_size(global.penaltyDefs[| 2]),
];

global.addedDeliveryPenalty = false;

global.moveTimeCost = 1;
global.blacksmithCostTimeCost = 1;
global.talkTimeCost = 2;
global.buyTimeCost = 2;
global.dungeonTimeCost = 10;
global.dailyQuestTimeCost = 5;
global.eventTimeCost = 15;
global.restTimeCost = 5;

global.playerLevel = 1;
global.playerTotalExperience = 0;
global.playerExperience = 0;
global.playerNextLevelExperience = 20;
global.playerHealth = 100;
global.playerMaxHealth = 100;
global.playerAttack = 10;
global.playerDamageRandom = 2;
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
	["Cloth Cap", 150, 1],
	["Wool Cap", 250, 2],
	["Old Leather Cap", 400, 2],
	["Soft Leather Cap", 500, 2],
	["Hard Leather Cap", 700, 3],
	["Shiny Hard Hat", 800, 1],
	["Tin Helmet", 1000, 3],
	["Double Tin Helmet", 1200, 3]
];
global.allArmor = [
	["None", 0, 0],
	["Rags", 50, 1],
	["Tank Top", 150, 1],
	["Legit Shirt", 250, 2],
	["Wool Shirt", 400, 2],
	["Chafing Leather Shirt", 600, 2],
	["Semi-Soft Leather Shirt", 800, 2],
	["Semi-Hard Leather Shirt", 1000, 2],
	["Chainmail Necktie", 1200, 3],
];
// Weapons have an additional value: damage randomness
// This basically is used in a random_range to modify the
// amount of damage done by a little bit just to make things
// a little more interesting. Like the attack values, these
// add to the previous random value.
global.allWeapons = [
	["Fists", 0, 1, 1],
	["Rusty Sword", 50, 9, 1],
	["Dull Sword", 150, 5, 2],
	["Tarnished Sword", 250, 10, 5],
	["Somewhat Sharp Sword", 350, 15, 8],
	["Tiny Dagger", 500, 10, 4],
	["Normal Dagger", 800, 10, 4],
	["Short Sword", 1000, 12, 8],
];
global.allShields = [
	["None", 0, 0],
	["Pot Lid", 150, 1],
	["Barrel Lid", 250, 2],
	["Chunk of Thick Wood", 500, 3],
	["Tin Shield", 700, 3],
	["Studded Shield", 1000, 4],
	["Double Shield!", 1400, 4],
	["Buckler", 1800, 5],
	["Kite Shield", 2500, 6],
	["Tower Shield", 4500, 7],
];
global.allPants = [
	["None", 0, 0],
	["Rags", 50, 1],
	["Bootie Shorts", 150, 1],
	["Hot Pants", 250, 1],
	["Jeans", 400, 2],
	["Leather Chaps", 600, 2],
	["Tight Leather Pants", 800, 2],
	["Thick, Comfy Pants", 1100, 3],
	["Shin Pads", 1300, 3],
	["Greaves", 2000, 4],
];
global.allBoots = [
	["None", 0, 0],
	["Worn Out Sandals", 150, 1],
	["Worn Out Shoes", 250, 1],
	["Shoes", 400, 1,],
	["Boots", 700, 2],
	["Knee-High Boots", 1000, 2],
	["Thigh-High Boots", 1200, 2],
	["Studded Leather Shoes", 1500, 3],
	["Heavy Metal Shoes", 2000, 4],
	["Air Jordans", 2500, 4],
	["Fancy Shoes", 3500, 5],
];

global.experienceAmounts = [
	40, //2
	80, //3
	100, //4
	140, //5
	200, //6
	250, //7
	300, //8
	400, //9
	550, //10
	700, //11
	1000, //12
	1500, //13
	2500, //14
	3500, //15
	5000, //16
	8000, //17
	10000, //18
	12000, //19
	15000, //20
	20000, //21
	25000, //22
	32000, //23
	40000, //24
	49000, //25
	59000, //26
	70000, //27
	80000, //28
	90000, //29
	100000, //30
];
// Bonuses have the format+
// +HP, +attack, +defense
global.levelBonuses = [
	[10, 2,  1], //1
	[15, 3,  2], //2
	[25, 5,  3], //3
	[35, 6,  4], //4
	[50, 9,  5], //5
	[70, 13, 7], //6
	[50, 10, 5], //7
	[70, 12, 5], //8
	[80, 15, 5], //9
	[90, 20, 7], //10
	[90, 20, 7], //11
	[91, 21, 8], //12
	[93, 22, 8], //13
	[94, 23, 8], //14
	[100, 25, 9], //15
	[105, 20, 8], //16
	[110, 15, 8], //17
	[110, 16, 8], //18
	[112, 17, 8], //19
	[115, 17, 9], //20
	[115, 18, 9], //21
	[110, 15, 7], //22
	[110, 15, 8], //23
	[120, 15, 7], //24
	[121, 16, 7], //25
	[122, 17, 8], //26
	[125, 18, 8], //27
	[130, 19, 8], //28
	[130, 19, 9], //29
	[132, 20, 9], //30
];

// Monster data has layer:
// name, hp, attack, damage randomness, defense, xp, xp random
global.MONSTER_NAME = 0;
global.MONSTER_HP = 1;
global.MONSTER_ATTACK = 2;
global.MONSTER_RANDOM = 3;
global.MONSTER_DEFENSE = 4;
global.MONSTER_XP = 5;
global.MONSTER_XP_RANDOM = 6;
global.MONSTER_GOLD = 7;
global.MONSTER_GOLD_RANDOM = 8;
global.allMonsters = [
	// easy monsters
	[
		["Slime",           10, 3, 1, 1, 2, 2, 8, 2],
		["Goblin",          15, 4, 2, 2, 5, 3, 12, 5],
		["Imp",             8,  5, 1, 5, 5, 5, 12, 5],
		["Noodle Demon",    12, 4, 2, 3, 4, 5, 14, 6],
		["Nasal Demon",     12, 4, 1, 2, 6, 2, 15, 4],
		["Styrofoam Golem", 11, 4, 3, 2, 6, 4, 13, 6],
	],
	
	// medium monsters
	[
		["Orc",         100, 20, 8,  10, 30, 15, 50, 20],
		["Fire Demon",  110, 30, 10, 5,  50, 20, 70, 30],
		["Blue Slime",  120, 25, 10, 12, 50, 30, 80, 30],
		["Cloth Golem", 130, 18, 12, 8,  40, 25, 70, 40],
	],
	
	// hard monsters
	[
		["Fire Dragon",  500, 100, 50,  40, 200, 100, 300, 100],
		["Metal Slime", 1000,  80, 40, 100, 500, 300, 800, 800],
		["Rock Golem",  1000,  90, 50,  90, 400, 400, 600, 200],
	],
	
	// extreme monsters
	[
		["Incepticus, the Ever-Diving",
			5000, 5000, 300, 10000, 5000, 20000, 10000],
		["Toe-Beard, the Fierce",
			5000, 4000, 330,  9000, 5000, 18000,  9000],
		["Slime-Murder, the All-Hungry",
			7000, 6000, 350, 12000, 6000, 22000, 11000],
	]
];

global.eventName = "none";
global.allEvents = [
];

room_goto_next();