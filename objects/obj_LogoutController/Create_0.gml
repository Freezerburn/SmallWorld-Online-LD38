/// @description

currentAlpha = 0;
secondsToFade = 3;
alphaStep = 1 / (room_speed * secondsToFade);

textAlpha = 0;
textSecondsToFadeIn = 0.5;
textAlphaStep = 1 / (room_speed * textSecondsToFadeIn);

drawDayOutline = false;
finishLogout = false;

global.logoutActive = true;
global.accumulatedTimeCost = 0;
global.currentTimeCost = 0;
global.playerHealth = global.playerMaxHealth;