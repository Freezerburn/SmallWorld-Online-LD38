/// @description Handle command

var baseCommand = ds_list_find_value(command, 0);
switch (baseCommand) {
	case "quit":
	case "exit":
	case "q":
		game_end();
		break;
		
	// General case of going a direction.
	case "go":
	case "move":
		if ds_list_size(command) > 1 {
			GoDirection(ds_list_find_value(command, 1), toWrite);
		} else {
			ds_list_add(toWrite, "You must specify a direction to go.");
		}
		break
		
	// Specific shortcuts for going a direction.
	case "e":
	case "w":
	case "s":
	case "n":
	case "nw":
	case "ne":
	case "sw":
	case "se":
		GoDirection(baseCommand, toWrite);
		break;
		
	// TODO: Workflow for talking.
	case "talk":
		break;
		
	case "cost":
		if global.currentRoom.name == "Blacksmith" {
			if ds_list_size(command) == 1 {
				ds_list_add(toWrite, "Blacksmith: \"I can give you the cost of the following things:");
				ds_list_add(toWrite, "    helmet, armor, weapon, shield, pants boots\"");
			} else {
				switch (command[| 1]) {
				case "helmet":
					if EquipmentHasNext(global.allHelmets, global.playerHelmet) {
						var nextHelmetDef = EquipmentGetNextDef(global.allHelmets, global.playerHelmet);
						ds_list_add(toWrite, EquipmentCost(nextHelmetDef, "helmet"));
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more helmets for you my friend.\"");
					}
					
					break;
				case "armor":
					if EquipmentHasNext(global.allArmor, global.playerArmor) {
						ds_list_add(toWrite, EquipmentCost(EquipmentGetNextDef(global.allArmor, global.playerArmor), "armor"));
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more armor for your my friend.\"");
					}
					break;
				case "weapon":
					if EquipmentHasNext(global.allWeapons, global.playerWeapon) {
						ds_list_add(toWrite, EquipmentCost(EquipmentGetNextDef(global.allWeapons, global.playerWeapon), "weapon"));
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more weapons for your my friend.\"");
					}
					break;
				case "shield":
					if EquipmentHasNext(global.allShields, global.playerShield) {
						ds_list_add(toWrite, EquipmentCost(EquipmentGetNextDef(global.allShields, global.playerShield), "shield"));
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more shields for your my friend.\"");
					}
					break;
				case "pants":
					if EquipmentHasNext(global.allPants, global.playerPants) {
						ds_list_add(toWrite, EquipmentCost(EquipmentGetNextDef(global.allPants, global.playerPants), "pants"));
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more pants for your my friend.\"");
					}
					break;
				case "boots":
					if EquipmentHasNext(global.allBoots, global.playerBoots) {
						ds_list_add(toWrite, EquipmentCost(EquipmentGetNextDef(global.allBoots, global.playerBoots), "boots"));
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more boots for your my friend.\"");
					}
					break;
				default:
					ds_list_add(toWrite, "Blacksmith: \"I do not sell " + command[| 1] + "s. I only sell:");
					ds_list_add(toWrite, "    helmet, armor, weapon, shield, pants boots\"");
					break;
				}
			}
			
			global.currentTimeCost += global.blacksmithCostTimeCost;
		} else {
			ds_list_add(toWrite, "You cannot get the cost of anything here.");
		}
		break;
		
	// TODO: Buying from blacksmith.
	// Only works in blacksmith room
	case "buy":
		if global.currentRoom.name == "Blacksmith" {
			if ds_list_size(command) == 1 {
				ds_list_add(toWrite, "Blacksmith: \"I can sell you the following things:");
				ds_list_add(toWrite, "    helmet, armor, weapon, shield, pants boots\"");
			} else {
				switch (command[| 1]) {
				case "helmet":
					if EquipmentHasNext(global.allHelmets, global.playerHelmet) {
						var nextHelmetDef = EquipmentGetNextDef(global.allHelmets, global.playerHelmet);
						if nextHelmetDef[1] < global.playerGold {
							ds_list_add(toWrite, "You purchase the " + nextHelmetDef[0]);
							global.playerGold -= nextHelmetDef[1];
							global.playerDefense += nextHelmetDef[2];
							global.playerHelmet[0] = nextHelmetDef[0];
							global.playerHelmet[1]++;
							
							if EquipmentHasNext(global.allHelmets, global.playerHelmet) {
								nextHelmetDef = EquipmentGetNextDef(global.allHelmets, global.playerHelmet);
								ds_list_add(toWrite, EquipmentCost(nextHelmetDef, "helmet"));
							} else {
								ds_list_add(toWrite, "Blacksmith: \"You have bought all the helmets I have, my friend.\"");
							}
						} else {
							ds_list_add(toWrite, "Blacksmith: \"You cannot afford that! It costs " +
								string(nextHelmetDef[1]) + " gold.\"");
						}
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more helmets for you my friend.\"");
					}
					break;
					
				case "armor":
					if EquipmentHasNext(global.allArmor, global.playerArmor) {
						var nextEquipDef = EquipmentGetNextDef(global.allArmor, global.playerArmor);
						if nextEquipDef[1] < global.playerGold {
							ds_list_add(toWrite, "You purchase the " + nextEquipDef[0]);
							global.playerGold -= nextEquipDef[1];
							global.playerDefense += nextEquipDef[2];
							global.playerArmor[0] = nextEquipDef[0];
							global.playerArmor[1]++;
							
							if EquipmentHasNext(global.allArmor, global.playerArmor) {
								nextEquipDef = EquipmentGetNextDef(global.allArmor, global.playerArmor);
								ds_list_add(toWrite, EquipmentCost(nextEquipDef, "armor"));
							} else {
								ds_list_add(toWrite, "Blacksmith: \"You have bought all the armor I have, my friend.\"");
							}
						} else {
							ds_list_add(toWrite, "Blacksmith: \"You cannot afford that! It costs " +
								string(nextEquipDef[1]) + " gold.\"");
						}
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more armor for you my friend.\"");
					}
					break;
					
				case "weapon":
					if EquipmentHasNext(global.allWeapons, global.playerWeapon) {
						var nextEquipDef = EquipmentGetNextDef(global.allWeapons, global.playerWeapon);
						if nextEquipDef[1] < global.playerGold {
							ds_list_add(toWrite, "You purchase the " + nextEquipDef[0]);
							global.playerGold -= nextEquipDef[1];
							global.playerAttack += nextEquipDef[2];
							global.playerWeapon[0] = nextEquipDef[0];
							global.playerWeapon[1]++;
							
							if EquipmentHasNext(global.allWeapons, global.playerWeapon) {
								nextEquipDef = EquipmentGetNextDef(global.allWeapons, global.playerWeapon);
								ds_list_add(toWrite, EquipmentCost(nextEquipDef, "weapon"));
							} else {
								ds_list_add(toWrite, "Blacksmith: \"You have bought all the weapons I have, my friend.\"");
							}
						} else {
							ds_list_add(toWrite, "Blacksmith: \"You cannot afford that! It costs " +
								string(nextEquipDef[1]) + " gold.\"");
						}
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more weapons for you my friend.\"");
					}
					break;
					
				case "shield":
					if EquipmentHasNext(global.allShields, global.playerShield) {
						var nextEquipDef = EquipmentGetNextDef(global.allShields, global.playerShield);
						if nextEquipDef[1] < global.playerGold {
							ds_list_add(toWrite, "You purchase the " + nextEquipDef[0]);
							global.playerGold -= nextEquipDef[1];
							global.playerDefense += nextEquipDef[2];
							global.playerShield[0] = nextEquipDef[0];
							global.playerShield[1]++;
							
							if EquipmentHasNext(global.allShields, global.playerShield) {
								nextEquipDef = EquipmentGetNextDef(global.allShields, global.playerShield);
								ds_list_add(toWrite, EquipmentCost(nextEquipDef, "shield"));
							} else {
								ds_list_add(toWrite, "Blacksmith: \"You have bought all the shields I have, my friend.\"");
							}
						} else {
							ds_list_add(toWrite, "Blacksmith: \"You cannot afford that! It costs " +
								string(nextEquipDef[1]) + " gold.\"");
						}
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more shields for you my friend.\"");
					}
					break;
					
				case "pants":
					if EquipmentHasNext(global.allPants, global.playerPants) {
						var nextEquipDef = EquipmentGetNextDef(global.allPants, global.playerPants);
						if nextEquipDef[1] < global.playerGold {
							ds_list_add(toWrite, "You purchase the " + nextEquipDef[0]);
							global.playerGold -= nextEquipDef[1];
							global.playerDefense += nextEquipDef[2];
							global.playerPants[0] = nextEquipDef[0];
							global.playerPants[1]++;
							
							if EquipmentHasNext(global.allPants, global.playerPants) {
								nextEquipDef = EquipmentGetNextDef(global.allPants, global.playerPants);
								ds_list_add(toWrite, EquipmentCost(nextEquipDef, "pants"));
							} else {
								ds_list_add(toWrite, "Blacksmith: \"You have bought all the pants I have, my friend.\"");
							}
						} else {
							ds_list_add(toWrite, "Blacksmith: \"You cannot afford that! It costs " +
								string(nextEquipDef[1]) + " gold.\"");
						}
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more pants for you my friend.\"");
					}
					break;
					
				case "boots":
					if EquipmentHasNext(global.allBoots, global.playerBoots) {
						var nextEquipDef = EquipmentGetNextDef(global.allBoots, global.playerBoots);
						if nextEquipDef[1] < global.playerGold {
							ds_list_add(toWrite, "You purchase the " + nextEquipDef[0]);
							global.playerGold -= nextEquipDef[1];
							global.playerDefense += nextEquipDef[2];
							global.playerBoots[0] = nextEquipDef[0];
							global.playerBoots[1]++;
							
							if EquipmentHasNext(global.allBoots, global.playerBoots) {
								nextEquipDef = EquipmentGetNextDef(global.allBoots, global.playerBoots);
								ds_list_add(toWrite, EquipmentCost(nextEquipDef, "boots"));
							} else {
								ds_list_add(toWrite, "Blacksmith: \"You have bought all the boots I have, my friend.\"");
							}
						} else {
							ds_list_add(toWrite, "Blacksmith: \"You cannot afford that! It costs " +
								string(nextEquipDef[1]) + " gold.\"");
						}
					} else {
						ds_list_add(toWrite, "Blacksmith: \"I have no more boots for you my friend.\"");
					}
					break;
					
				default:
					ds_list_add(toWrite, "Blacksmith: \"I do not sell " + command[| 1] + "s. I only sell:");
					ds_list_add(toWrite, "    helmet, armor, weapon, shield, pants boots\"");
					break;
				}
			}
			
			global.currentTimeCost += global.buyTimeCost;
		} else {
			ds_list_add(toWrite, "You cannot buy anything here.");
		}
		break;
	
	// TODO: Sell stuff?
	case "sell":
		break;
		
	// TODO: Implement fighting in the dungeon.
	// Can ONLY use this in the dungeon to level up and stuff?
	case "fight":
		if global.currentRoom.name == "Dungeon" {
			ds_list_add(toWrite, "You fight some monsters and gain experience.");
		} else {
			ds_list_add(toWrite, "You cannot fight anybody here.");
		}
		break;
		
	// TODO: workflow for logging out.
	case "logout":
		break;
		
	// TODO: Print help.
	case "help":
		break;
		
	default:
		// TODO: Pick from a list of funny responses.
		ds_list_add(toWrite, "I do not understand");
}

with (inputController) {
	event_user(0);
}
ds_list_clear(toWrite);