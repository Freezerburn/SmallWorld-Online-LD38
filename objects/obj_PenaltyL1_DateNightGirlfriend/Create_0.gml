/// @description

event_inherited();
visible = false;

currentVisibleSms = 0;
nextSwipeOffSms = 0;
childSms = ds_list_create();
for (var i = 0; i < image_number; i++) {
	var objIdx = instance_create_layer(-999999, -999999, layer, obj_SimpleUISprite)
	objIdx.sprite_index = sprite_index;
	objIdx.image_index = i;
	objIdx.image_speed = 0;
	ds_list_add(childSms, objIdx);
}

currentSms = childSms[| 0];
currentSms.vspeed = 5;
currentSms.x = room_width - sprite_width - 15;
currentSms.y = -sprite_height - 5;

secondsBetweenSms = 2;