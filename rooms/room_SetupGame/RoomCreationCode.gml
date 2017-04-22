global.roomMapping = ds_map_create();
global.currentRoom = undefined;

global.penalties = 0;
global.positives = 0;
global.currentTimeCost = 0;

global.timeCostBeforePenalty = 100;
global.moveTimeCost = 1;
global.talkTimeCost = 2;
global.buyTimeCost = 2;
global.dungeonTimeCost = 10;
global.dailyQuestTimeCost = 5;
global.eventTimeCost = 15;

room_goto_next();