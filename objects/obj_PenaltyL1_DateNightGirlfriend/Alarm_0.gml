/// @description Move new SMS text in from the top

currentVisibleSms++;
if currentVisibleSms < ds_list_size(childSms) {
	for (var i = 0; i < currentVisibleSms; i++) {
		if childSms[| i] == -1 {
			continue;
		}
		childSms[| i].vspeed = 5;
	}
	currentSms = childSms[| currentVisibleSms];
	currentSms.vspeed = 5;
	currentSms.x = room_width - sprite_get_width(spr_PenaltyL1_DateNightGirlfriend) - 15;
	currentSms.y = -sprite_get_height(spr_PenaltyL1_DateNightGirlfriend) - 5;

	alarm[0] = secondsBetweenSms * room_speed;
} else {
	currentSms = -1;
}