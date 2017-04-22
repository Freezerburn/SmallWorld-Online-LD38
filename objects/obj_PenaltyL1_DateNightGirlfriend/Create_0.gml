/// @description

event_inherited();

var numSms = sprite_get_number(spr_PenaltyL1_DateNightGirlfriend);
currentVisibleSms = 0;
nextSwipeOffSms = 0;
childSms = ds_list_create();
for (var i = 0; i < numSms; i++) {
	var objIdx = instance_create_layer(-999999, -999999, layer, obj_SimpleUISprite)
	objIdx.sprite_index = spr_PenaltyL1_DateNightGirlfriend;
	objIdx.image_index = i;
	objIdx.image_speed = 0;
	ds_list_add(childSms, objIdx);
}

currentSms = childSms[| 0];
currentSms.vspeed = 5;
currentSms.x = room_width - sprite_get_width(spr_PenaltyL1_DateNightGirlfriend) - 15;
currentSms.y = -sprite_get_height(spr_PenaltyL1_DateNightGirlfriend) - 5;

secondsBetweenSms = 2;