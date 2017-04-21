/// @description Draw all the lines of text written

// Always ensure that the surface exists, as it can get removed from video memory
// from things like the window being minimized on Windows.
if !surface_exists(textSurface) {
	textSurface = surface_create(surfaceWidth, surfaceHeight);
}

// Start drawing to the surface and ensure that it's blank.
surface_set_target(textSurface);
draw_clear_alpha(c_black, 0);

// Draw all lines of text to the "console".
draw_set_font(fnt_ConsoleOutput);
draw_set_color(c_white);
var currentHeight = textOffset;
for (var i = 0; i < ds_list_size(drawLines); i++) {
	var line = ds_list_find_value(drawLines, i);
	if currentHeight + maxUserInputHeight > 0 && currentHeight < surfaceHeight {
		draw_text_ext(0, currentHeight, line,
			-1, textDrawWidth);
	}
	currentHeight += string_height_ext(line, -1, textDrawWidth) + verticalBuffer;
}

// Calculate how tall the scrollbar is, if it should exist.
// currentHeight is used as the total, due to it being the cumulative heights
// of all lines of text which is necessary for drawing. So we thankfully only
// have to calculate all of that once.
// Since the currentHeight starts at the current textOffset, we need to remove
// that part so this value isn't changing every time the user scrolls.
totalTextHeight = currentHeight - textOffset;
if totalTextHeight > surfaceHeight {
	scrollbarExists = true;
	// Since we basically want a representation of how big the visible part of the
	// text is versus how much text there is in total, we use the ratio representing
	// that size to find how big it should be in visible window space.
	scrollbarHeight = (surfaceHeight / totalTextHeight) * surfaceHeight;
}

// Draw the scrollbar if there's enough text to warrant showing one.
if scrollbarExists {
	var nonVisibleHeight = totalTextHeight - surfaceHeight;
	scrollbarY = (-textOffset / nonVisibleHeight) * (surfaceHeight - scrollbarHeight);
	draw_rectangle_color(
		surfaceWidth - scrollbarWidth, scrollbarY,
		surfaceWidth, scrollbarY + scrollbarHeight,
		c_gray, c_gray, c_gray, c_gray,
		false
	);
}

// Set the draw target back to the application surface.
surface_reset_target();


// Debug drawing of information. Uncomment to see useful numbers.
draw_text(surfaceWidth + 20, 10, "scrollbarY: " + string(scrollbarY));
draw_text(surfaceWidth + 20, 25, "textOffset: " + string(textOffset));
draw_text(surfaceWidth + 20, 40, "nonVisibleHeight: " + string(totalTextHeight - surfaceHeight));
draw_text(surfaceWidth + 20, 55, "Non-scrollbar area: " + string(surfaceHeight - scrollbarHeight));


// Draw the "console" with a white border around it to make it look like the
// text is in a "window".
draw_surface(textSurface, 18, 10);
draw_rectangle_color(
	10, 10,
	surfaceWidth + 18, surfaceHeight + 10,
	c_white, c_white, c_white, c_white,
	true
);