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
	draw_set_font(fnt_LogoutSummary);
	draw_set_color(c_white);
	draw_set_alpha(textAlpha);
	
	if !finishLogout {
		textAlpha += textAlphaStep;
	}
	
	if textAlpha > 1 {
		textAlpha = 1;
		if alarm[1] == -1 && !finishLogout {
			alarm[1] = timeBeforeFadeOut;
		}
	}
	
	draw_text_ext(room_width / 2 - mainTextWidth / 2, 100, mainTextToDraw,
		-1, 700);
	draw_text_ext(room_width / 2 - decayTextWidth / 2,
		100 + mainTextHeight + 50,
		decayText, -1, 700);
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