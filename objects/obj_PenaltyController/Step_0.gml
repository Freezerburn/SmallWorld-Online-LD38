/// @description Check for penalties

if global.currentTimeCost > global.timeCostBeforePenalty {
	global.penalties++;
	// TODO: Do something from the pool of penalties.
} else if global.currentTimeCost > global.timeCostBeforeWarning && !global.warningShown {
	// TODO: Do something from the pool of warnings.
	//show_debug_message("WARNING");
	global.warningShown = true;
	
	var pool = global.warningDefs[| 0];
	var eventIdx = floor(random_range(0, ds_list_size(pool)));
	var eventData = pool[| eventIdx];
	var objIdx = eventData[0];
	var warning = instance_create_layer(9999999, 99999999, "NormalUI", objIdx);
}