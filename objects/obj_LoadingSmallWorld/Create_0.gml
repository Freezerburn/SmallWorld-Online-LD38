/// @description

draw_set_font(fnt_LoadingSmallWorld);

var textWidth = string_width("Loading SmallWorld Online...");
var textHeight = string_height("Loading SmallWorld Online...");
textX = room_width / 2 - textWidth / 2;
textY = 200 - textHeight / 2;
loadingCount = 0;
doneLoading = 10;
timeBetweenLoading = room_speed / 2 - room_speed / 10;
alarm[0] = timeBetweenLoading;

loadingWidth = round(room_width * 0.9);
loadingHeight = 40;
loadingRectangleBuffer = 5;
loadingRectangleWidth = (loadingWidth - loadingRectangleBuffer * 2) / doneLoading;

outerLoadingX1 = room_width / 2 - loadingWidth / 2;
outerLoadingX2 = outerLoadingX1 + loadingWidth;
outerLoadingY1 = room_height / 2 - loadingHeight / 2;
outerLoadingY2 = outerLoadingY1 + loadingHeight;