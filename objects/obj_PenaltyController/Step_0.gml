/// @description Check for penalties

var costDelta = global.currentTimeCost - global.prevTimeCost;
global.prevTimeCost = global.currentTimeCost;
if costDelta > 0 {
	global.accumulatedTimeCost += costDelta;
	if global.accumulatedTimeCost > global.timeCostDeathCondition {
		room_goto(room_Death);
	}
}

if global.currentTimeCost >= global.timeCostBeforePenalty {
	global.penalties++;
	var pool = global.penaltyDefs[| 0];
	var eventData = pool[| global.lastWarningDef[1]];
	var objIdx = eventData[0];
	ds_list_add(global.penaltiesAccumulated, eventData);
	var penalty = instance_create_layer(999999, 999999, "NormalUI", objIdx);
	
	global.lastWarningDef = -1;
	global.warningShown = false;
	global.currentTimeCost = 0;
	
} else if global.currentTimeCost >= global.timeCostBeforeWarning && !global.warningShown {
	//show_debug_message("WARNING");
	global.warningShown = true;
	//global.currentTimeCost = 69;
	
	var pool = global.warningDefs[| 0];
	var eventIdx = floor(random_range(0, ds_list_size(pool)));
	var eventData = pool[| eventIdx];
	var objIdx = eventData[0];
	var warning = instance_create_layer(9999999, 99999999, "NormalUI", objIdx);
	
	global.lastWarningDef = eventData;
}