/// @description

draw_set_font(fnt_LoadingSmallWorld);
draw_set_color(c_white);
  
draw_text(textX, textY, "Loading SmallWorld Online...");
 
for (var i = 0; i < loadingCount; i++) {
	draw_rectangle(
		outerLoadingX1 + loadingRectangleBuffer + loadingRectangleWidth * i,
		outerLoadingY1 + 5,
		outerLoadingX1 + loadingRectangleBuffer + loadingRectangleWidth * (i + 1),
		outerLoadingY2 - 5,
		false); 
}
draw_rectangle(outerLoadingX1, outerLoadingY1,
	outerLoadingX2, outerLoadingY2, true);