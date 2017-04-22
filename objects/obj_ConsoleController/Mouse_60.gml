/// @description Scroll console up

if scrollbarExists {
	userAtBottomOfConsole = false;
	textOffset += scrollSpeed;
	
	if textOffset > 0 {
		scrollbarY = 0;
		textOffset = 0;
	}
}