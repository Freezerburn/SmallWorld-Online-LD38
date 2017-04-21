/// @description Set self as parser for input

inputController = instance_find(obj_UserInputController, 0);
inputController.parser = self;
command = -1;
commandFullText = "";
toWrite = -1;