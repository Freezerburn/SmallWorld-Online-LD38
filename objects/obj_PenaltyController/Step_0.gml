/// @description Check for penalties

var costDelta = global.currentTimeCost - global.prevTimeCost;
global.prevTimeCost = global.currentTimeCost;
if costDelta > 0 {
	global.accumulatedTimeCost += costDelta;
	if global.accumulatedTimeCost > global.timeCostDeathCondition {
		room_goto(room_Death);
	}
}

if global.currentTimeCost >= global.showPositiveAfter && global.nextPositiveDef != -1 {
	instance_create_layer(999999, 999999, "NormalUI", global.nextPositiveDef);
	global.nextPositiveDef = -1;
	global.showPositiveAfter = -1;
}

if global.currentTimeCost >= global.timeCostBeforePenalty {
	var pool = -1;
	if global.lastWarningDef[1] == -1 {
		ds_list_add(global.penaltiesAccumulated, global.lastWarningDef);
		global.lastWarningDef = -1;
		global.warningShown = false;
		global.currentTimeCost = 0;
		
		global.penalties++;
		if global.penalties > 4 {
			global.announcementPool++;
		} else if global.penalties > 9 {
			global.announcementPool++;
		} else if global.penalties > 14 {
			global.announcementPool++;
		} else if global.penalties > 19 {
			global.announcementPool++;	
		} else if global.penalties > 19 &&
				 ds_map_size(global.penaltyDefs[| global.announcementPool]) == 0 {
			// TODO: Implement game over room.
			room_goto(room_GameOver);
			exit;
		}
		
		exit;
	} else if global.lastWarningDef[0] == -1 {
		pool = global.standalonePenalties[| global.announcementPool];
		var chooseEvent = floor(random_range(0, ds_list_size(pool)));
		var eventData = pool[| chooseEvent];
		ds_list_delete(pool, chooseEvent);
		var objIdx = eventData[0];
		ds_list_add(global.penaltiesAccumulated, eventData);
		instance_create_layer(999999, 999999, "NormalUI", objIdx);
	} else {
		var pool = global.penaltyDefs[| global.announcementPool];
		var eventData = pool[? global.lastWarningDef[1]];
		
		ds_map_delete(pool, global.lastWarningDef[1]);
		if eventData[0] == obj_PenaltyL1_DateNightGirlfriend {
			var addKey = global.nextPenaltyKeys[global.announcementPool]++;
			ds_map_add(pool, addKey, [obj_PenaltyL1_MakeUpDinner]);
			ds_list_add(global.warningDefs[| global.announcementPool],
				[obj_WarningL1_MakeUpDinner, addKey]);
		}
		if global.announcementPool == 0 && ds_map_size(pool) < 2 &&
				!global.addedDeliveryPenalty {
			global.addedDeliveryPenalty = true;
			var addKey = global.nextPenaltyKeys[global.announcementPool]++;
			ds_list_add(global.standalonePenalties[|global.announcementPool],
				[obj_PenaltyL1_UsualDelivery]);
			ds_list_add(global.warningDefs[| global.announcementPool], [-1, -2]);
		}
		
		var objIdx = eventData[0];
		ds_list_add(global.penaltiesAccumulated, eventData);
		instance_create_layer(999999, 999999, "NormalUI", objIdx);
	}
	
	global.lastWarningDef = -1;
	global.warningShown = false;
	global.currentTimeCost = 0;
	
	global.penalties++;
	if global.penalties > 4 {
		global.announcementPool++;
	} else if global.penalties > 9 {
		global.announcementPool++;
	} else if global.penalties > 14 {
		global.announcementPool++;
	} else if global.penalties > 19 {
		global.announcementPool++;
	} else if global.penalties > 19 &&
			 ds_list_size(global.penaltyDefs[| global.announcementPool]) == 0 {
		// TODO: Implement game over room.
		room_goto(room_GameOver);
		exit;
	}
	
} else if global.currentTimeCost >= global.timeCostBeforeWarning && !global.warningShown {
	//show_debug_message("WARNING");
	global.warningShown = true;
	//global.currentTimeCost = 69;
	
	var pool = global.warningDefs[| global.announcementPool];
	var eventIdx = floor(random_range(0, ds_list_size(pool)));
	var eventData = pool[| eventIdx];
	ds_list_delete(pool, eventIdx);
	
	if eventData[0] != -1 {
		var objIdx = eventData[0];
		var warning = instance_create_layer(9999999, 99999999, "NormalUI", objIdx);
	}
	
	global.lastWarningDef = eventData;
}