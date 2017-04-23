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
	// Worse decay for being controlled.
	decayData = DecayExperience(0.2);
	
	if (global.positives + 1 > 20 ||
			ds_list_size(global.warningDefs[| global.announcementPool]) == 0) &&
			// No going back once you get to the final penalties.
			global.announcementPool < 2 {
		room_goto(room_GameWin);
		exit;
	} else if global.accumulatedTimeCost == 0 &&
			global.penalties == 0 &&
			global.positives == 0 &&
			!is_array(global.lastWarningDef) {
		room_goto(room_GameWinNoPlay);
		exit;
	}
	
	global.positives++;
}

if global.accumulatedTimeCost > global.timeCostBeforePenalty * 2 {
	mainTextToDraw = "Having played SmallWorld Online for an extended period of time, " +
		"you collapse exhausted and get some rest. But it's not enough to make up for " +
		"the time you spent awake... However, you have achieved many things in the game!";
} else if global.accumulatedTimeCost > global.timeCostBeforePenalty {
	mainTextToDraw = "You go to bed late, not quite getting enough sleep for the next " +
		"day.";
		
	for (var i = 0; i < ds_list_size(global.penaltiesAccumulated); i++) {
		var penaltyData = global.penaltiesAccumulated[| i];
		switch (penaltyData[0]) {
		case obj_PenaltyL1_DateNightGirlfriend:
			mainTextToDraw += "\nYou're going to need to try and make things up with your " +
				"girlfriend after missing your date night...";
			break;
		case obj_PenaltyL1_MakeUpDinner:
			mainTextToDraw += "\nYour girlfriend is pissed that you stood her up twice in " +
				"such a short period of time. Best to let her cool down for a bit...";
		case obj_WarningL1_Bedtime:
			mainTextToDraw = "After ignoring the alarm you set to ensure you got to " +
				"bed on time, you couldn't manage to get up in time when your alarm " +
				"goes off for work. Your boss was angry that you got in late again.";
			break;
		}
	}
	ds_list_clear(global.penaltiesAccumulated);
} else {
	if global.announcementPool < 2 {
		mainTextToDraw = "You log out of SmallWorld Online and enjoy a nice " +
			"night, getting plenty of rest for the next day.";
	} else {
		mainTextToDraw = "You log out of SmallWorld Online, but don't really get much " +
			"sleep. You keep thinking about playing the game more, and before long you're " +
			"awake again and playing.";
	}
}

if is_array(global.lastWarningDef) {
	switch (global.lastWarningDef[0]) {
	case obj_WarningL1_DateNightGirlfriend:
		global.showPositiveAfter = global.showPositiveAfterBase
			+ round(random_range(global.showPositiveRangeLower, global.showPositiveUpperRange));
		global.nextPositiveDef = obj_PositiveL1_DateNightGirlfriend;
		break;
	case obj_WarningL1_MakeUpDinner:
		global.showPositiveAfter = global.showPositiveAfterBase
			+ round(random_range(global.showPositiveRangeLower, global.showPositiveUpperRange));
		global.nextPositiveDef = obj_PositiveL1_MakeUpDinner;
		break;
	case obj_WarningL1_FamilyDinner:
		global.showPositiveAfter = global.showPositiveAfterBase
			+ round(random_range(global.showPositiveRangeLower, global.showPositiveUpperRange));
		global.nextPositiveDef = obj_PositiveL1_FamilyDinner;
		break;
	case obj_WarningL2_ConcernedFriend:
		global.showPositiveAfter = global.showPositiveAfterBase
			+ round(random_range(global.showPositiveRangeLower, global.showPositiveUpperRange));
		global.nextPositiveDef = obj_PositiveL2_ConcernedFriend;
		break;
	case obj_WarningL2_GirlfriendNotice:
		global.showPositiveAfter = global.showPositiveAfterBase
			+ round(random_range(global.showPositiveRangeLower, global.showPositiveUpperRange));
		global.nextPositiveDef = obj_PositiveL2_GirlfriendNotice;
	}
}
global.lastWarningDef = 0;
global.warningShown = false;

decayText = "Your experience has decayed " + string(decayData[0]) + " points while " +
	"you were logged out.";
if decayData[1] > 0 {
	decayText += "\nYou have lost a level due to this decay.";
}

pressKeyText = "Press any key to log back in";

draw_set_font(fnt_LogoutSummary);
mainTextWidth = string_width_ext(mainTextToDraw, -1, 700);
mainTextHeight = string_height_ext(mainTextToDraw, -1, 700);
decayTextWidth = string_width_ext(decayText, -1, 700);
decayTextHeight = string_height_ext(decayText, -1, 700);
pressKeyWidth = string_width_ext(pressKeyText, -1, 700);
pressKeyHeight = string_height_ext(pressKeyText, -1, 700);

timeBeforeFadeOut = (string_length(mainTextToDraw) * 0.07 +
	string_length(decayText) * 0.07) * room_speed;

global.logoutActive = true;
global.accumulatedTimeCost = 0;
global.currentTimeCost = 0;
global.playerHealth = global.playerMaxHealth;