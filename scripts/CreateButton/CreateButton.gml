/// CreateButton(x, y, spriteIndex, layerId, callbackInstance, userEventNumber);

var spriteX = argument0;
var spriteY = argument1;
var spriteIndex = argument2;
var layerId = argument3;
var callbackInstance = argument4;
var userEventNumber = argument5;

var buttonInstance = instance_create_layer(spriteX, spriteY, layerId, obj_Button);
buttonInstance.sprite_index = spriteIndex;
buttonInstance.callbackInstance = callbackInstance;
buttonInstance.userEventNumber = userEventNumber;
buttonInstance.image_index = 0;
buttonInstance.image_speed = 0;