/// @description

loadingCount += 1;
if loadingCount > doneLoading {
	room_goto_next();
}
alarm[0] = timeBetweenLoading + random_range(-20, 15);