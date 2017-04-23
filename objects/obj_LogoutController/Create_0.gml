/// @description

currentAlpha = 0;
secondsToFade = 3;
alphaStep = 1 / (room_speed * secondsToFade);

textAlpha = 0;
textSecondsToFadeIn = 0.5;
textAlphaStep = 1 / (room_speed * textSecondsToFadeIn);

drawDayOutline = false;
finishLogout = false;

if global.accumulatedTimeCost > global.timeCostBeforePenalty {
	decayData = DecayExperience(0.1);
} else {
	// Worse decay for playing well.
	decayData = DecayExperience(0.2);
}

if global.accumulatedTimeCost > global.timeCostBeforePenalty * 2 {
	mainTextToDraw = "Having played SmallWorld Online for an extended period of time, " +
		"you collapse exhausted and get some rest. But it's not enough to make up for " +
		"the time you spend awake... However, you have achieved many things in the game!";
} else if global.accumulatedTimeCost > global.timeCostBeforePenalty {
	mainTextToDraw = "You go to bed late, not quite getting enough sleep for the next " +
		"day.";
		
	for (var i = 0; i < ds_list_size(global.penaltiesAccumulated); i++) {
		var penaltyData = global.penaltiesAccumulated[| i];
		switch (penaltyData[0]) {
		case obj_PenaltyL1_DateNightGirlfriend:
			mainTextToDraw += "\nYou're going to need to try and make things up with your " +
				"girlfriend today.";
			break;
		}
	}
	ds_list_clear(global.penaltiesAccumulated);
} else {
	mainTextToDraw = "You log out of SmallWorld Online and enjoy a nice " +
		"night, getting plenty of rest for the next day.";
}

decayText = "Your experience has decayed " + string(decayData[0]) + " points while " +
	"you were logged out.";
if decayData[1] > 0 {
	decayText += "\nYou have lost a level due to this decay.";
}

draw_set_font(fnt_LoadingSmallWorld);
mainTextWidth = string_width_ext(mainTextToDraw, -1, 700);
mainTextHeight = string_height_ext(mainTextToDraw, -1, 700);
decayTextWidth = string_width_ext(decayText, -1, 700);
decayTextHeight = string_height_ext(decayText, -1, 700);

timeBeforeFadeOut = (string_length(mainTextToDraw) * 0.1 +
	string_length(decayText) * 0.1) * room_speed;

global.logoutActive = true;
global.accumulatedTimeCost = 0;
global.currentTimeCost = 0;
global.playerHealth = global.playerMaxHealth;