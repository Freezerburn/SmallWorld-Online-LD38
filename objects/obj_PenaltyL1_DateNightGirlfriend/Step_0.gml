/// @description

if childSms[| ds_list_size(childSms) - 1] == -1 {
	//show_debug_message("DESTROY SMS");
	instance_destroy(self);
	exit;
}

if currentSms != -1 && currentSms.y > 15 {
	for (var i = 0; i < currentVisibleSms; i++) {
		childSms[| i].vspeed = 0;
	}
	currentSms.vspeed = 0;
	currentSms.y = 15;
	alarm[0] = secondsBetweenSms * room_speed;
	if currentVisibleSms == 0 {
		alarm[1] = secondsBetweenSms * room_speed * 1.5;
	}
}

for (var i = 0; i <= ds_list_size(childSms); i++) {
	var sms = childSms[| i];
	
	if sms != -1 {
		if sms.x > room_width {
			//show_debug_message("DESTROY CHILD");
			instance_destroy(sms);
			childSms[| i] = -1;
		}
	}
}