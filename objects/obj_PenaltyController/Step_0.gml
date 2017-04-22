/// @description Check for penalties

if global.currentTimeCost > global.timeCostBeforePenalty {
	global.penalties++;
	// TODO: Do something from the pool of penalties.
} else if global.currentTimeCost > global.timeCostBeforeWarning && !global.warningShown {
	// TODO: Do something from the pool of warnings.
	//show_debug_message("WARNING");
	global.warningShown = true;
	
	var warning = instance_create_layer(9999999, 99999999, "NormalUI", obj_WarningOutlook);
	warning.sprite_index = spr_L1_DateNightGirlfriend;
	warning.x = room_width - warning.sprite_width - 15;
	warning.y = room_height + 4;
}