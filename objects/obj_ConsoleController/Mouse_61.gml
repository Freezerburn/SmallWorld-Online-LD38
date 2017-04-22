/// @description Scroll console down

if scrollbarExists {
	// To emulate scrolling down, we offset the text negatively, pulling all text
	// upward. This makes calculating the scrollbar position a little awkward,
	// but is a clean way of scrolling the text.
	textOffset -= scrollSpeed;

	if totalTextHeight + textOffset < surfaceHeight {
		userAtBottomOfConsole = true;
		textOffset = -(totalTextHeight - surfaceHeight);
		scrollbarY = surfaceHeight - scrollbarHeight;
	}
}