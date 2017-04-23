/// @description Move SMS off screen to the right

//show_debug_message("SWIPE OFF");

var swipeOffSms = childSms[| nextSwipeOffSms++];
swipeOffSms.hspeed = 10;

if nextSwipeOffSms < ds_list_size(childSms) {
	alarm[1] = secondsBetweenSms * room_speed * 1.5;
}