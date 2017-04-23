/// @description

if !finishLogout {
	currentAlpha += alphaStep;
	if currentAlpha > 1 {
		currentAlpha = 1;
		drawDayOutline = true;
	}
}

draw_set_color(c_black);
draw_set_alpha(currentAlpha);
draw_rectangle(0, 0, room_width, room_height, false);

if drawDayOutline {
	draw_set_color(c_white);
	draw_set_alpha(textAlpha);
	
	if !finishLogout {
		textAlpha += textAlphaStep;
	}
	
	if textAlpha > 1 {
		textAlpha = 1;
		if alarm[1] == -1 && !finishLogout {
			alarm[1] = room_speed * 2;
		}
	}
	
	draw_text(100, 100, "test outline");
}

if finishLogout {
	currentAlpha -= alphaStep * 2;
	textAlpha -= textAlphaStep * 2;
	
	if currentAlpha < 0 {
		global.logoutActive = false;
		instance_destroy(self);
	}
}

draw_set_alpha(1);