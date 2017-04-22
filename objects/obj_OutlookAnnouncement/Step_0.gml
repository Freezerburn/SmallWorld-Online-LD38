/// @description

if room_height - sprite_height - bottomBuffer > y && vspeed < 0 {
	//show_debug_message("STOP MOVING OUTLOOK");
	//show_debug_message("y: " + string(y) + ", calc: " + string(room_height - sprite_height - bottomBuffer));
	vspeed = 0;
	y = room_height - sprite_height - bottomBuffer;
	alarm[0] = room_speed * displayTimeSeconds;
}

if y > room_height && vspeed > 0 {
	//show_debug_message("OUTLOOK DESTROY");
	instance_destroy(self);
}