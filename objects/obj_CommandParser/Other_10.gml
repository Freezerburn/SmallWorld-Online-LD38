/// @description Handle command

if global.logoutActive {
	exit;
}

var baseCommand = ds_list_find_value(command, 0);
switch (baseCommand) {
	//case "quit":
	//case "q":
	//	game_end();
	//	break;
		
	// General case of going a direction.
	case "go":
	case "move":
		if ds_list_size(command) > 1 {
			GoDirection(ds_list_find_value(command, 1), toWrite);
		} else {
			ds_list_add(toWrite, "You must specify a direction to go.");
			GetRoomDirections(toWrite);
		}
		break
		
	case "exits":
		GetRoomDirections(toWrite);
		break;
		
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
		switch (global.currentRoom.name) {
		case "Town":
			switch (global.eventName) {
			default:
				ds_list_add(toWrite, "Town Crier: \"There's nothing going on right now.\"");
				break;
			}
			break;
		case "Tavern":
			switch (global.eventName) {
			default:
				ds_list_add(toWrite, "Tavern Keeper: \"Ach, there be nothing going on right now laddie.\"");
				break;
			}
			break;
		case "Blacksmith":
			ds_list_add(toWrite, "Blacksmith: \"I'm to busy to be talking with ye right now.\"");
			break;
		default:
			ds_list_add(toWrite, "There's no one to talk to here.");
			break;
		}
		break;
		
	case "rest":
		if global.currentRoom.name == "Tavern" {
			if global.playerHealth == global.playerMaxHealth {
				ds_list_add(toWrite, "You have no need to rest right now.");
			} else {
				if global.playerGold < 10 {
					ds_list_add(toWrite, "Tavern Keeper: \"You don't have enough money! It costs 10 gold to stay the night.\"");
				} else {
					ds_list_add(toWrite, "You pay 10 gold to the tavern keeper to rest to full health.");
					global.playerGold -= 10;
					global.playerHealth = global.playerMaxHealth;
				}
			}	
		} else {
			ds_list_add(toWrite, "You cannot rest here.");
		}
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
						if nextHelmetDef[1] <= global.playerGold {
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
						if nextEquipDef[1] <= global.playerGold {
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
						if nextEquipDef[1] <= global.playerGold {
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
						if nextEquipDef[1] <= global.playerGold {
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
						if nextEquipDef[1] <= global.playerGold {
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
						if nextEquipDef[1] <= global.playerGold {
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
	//case "sell":
	//	break;
		
	// TODO: Implement fighting in the dungeon.
	// Can ONLY use this in the dungeon to level up and stuff?
	case "fight":
		if global.currentRoom.name == "Dungeon" {
			if ds_list_size(command) > 1 {
				var monsterKindIdx = -1;
				switch (command[| 1]) {
				case "easy":
					monsterKindIdx = 0;
					break;
				case "medium":
					monsterKindIdx = 1;
					break;
				case "hard":
					monsterKindIdx = 2;
					break;
				case "extreme":
					monsterKindIdx = 3;
					break;
				}
				if monsterKindIdx == -1 {
					ds_list_add(toWrite, "That is not a valid kind of monster. Valid kinds are:");
					ds_list_add(toWrite, "    easy, medium, hard, extreme");
				} else {
					var allMonsterData = global.allMonsters[monsterKindIdx];
					var numMonsters = array_length_1d(allMonsterData);
					var monsterIdx = floor(random_range(0, numMonsters));
					var monsterData = allMonsterData[monsterIdx];
					ds_list_add(toWrite, "You wander into the dungeon and encouner a(n) " + monsterData[0]);
					
					var damageToBase = global.playerAttack - monsterData[global.MONSTER_DEFENSE];
					var damageFromBase = monsterData[global.MONSTER_ATTACK] - global.playerDefense;
					var currentMonsterHP = monsterData[global.MONSTER_HP];
					var monsterName = monsterData[global.MONSTER_NAME];
					while global.playerHealth > 0 && currentMonsterHP > 0 {
						var playerDamageDone = damageToBase + ceil(
							random_range(-global.playerDamageRandom * 0.25, global.playerDamageRandom)
						);
						
						if playerDamageDone <= 0 {
							ds_list_add(toWrite, "You try your best, but you don't manage to do any damage to the monster.");
						} else {
							currentMonsterHP -= playerDamageDone;
							ds_list_add(toWrite, "You deal " + string(playerDamageDone) + " damage to the "
								+ monsterName + ".");
							if currentMonsterHP <= 0 {
								break;
							}
						}
						
						var monsterDamageDone = damageFromBase + round(
							random_range(-monsterData[global.MONSTER_RANDOM] * 0.1, monsterData[global.MONSTER_RANDOM])
						);
						if monsterDamageDone <= 0 {
							ds_list_add(toWrite, "The " + monsterName + " does its best, but it doesn't manage to " +
								"do any damage to you.");
						} else {
							global.playerHealth -= monsterDamageDone;
							ds_list_add(toWrite, "The " + monsterName + " deals " + string(monsterDamageDone) + 
								" damage to you.");
						}
					}
					
					if currentMonsterHP <= 0 {
						var xpGained = monsterData[global.MONSTER_XP] +
							round(random_range(0, monsterData[global.MONSTER_XP_RANDOM]));
						var goldGained = monsterData[global.MONSTER_GOLD] +
							round(random_range(0, monsterData[global.MONSTER_GOLD_RANDOM]));
						ds_list_add(toWrite, "You killed the " + monsterData[global.MONSTER_NAME] +
							" and gained " + string(xpGained) + " experience and " +
							string(goldGained) + " gold.");
						global.playerGold += goldGained;
						global.playerExperience += xpGained;
						global.playerTotalExperience += xpGained;
						
						if global.playerExperience >= global.playerNextLevelExperience {
							ds_list_add(toWrite, "You gained a level!");
							
							var bonuses = global.levelBonuses[global.playerLevel - 1];
							ds_list_add(toWrite, "You gained " + string(bonuses[0]) + " HP.");
							ds_list_add(toWrite, "You gained " + string(bonuses[1]) + " attack.");
							ds_list_add(toWrite, "You gained " + string(bonuses[2]) + " defense.");
							global.playerMaxHealth += bonuses[0];
							global.playerHealth = global.playerMaxHealth;
							global.playerAttack += bonuses[1];
							global.playerDefense += bonuses[2];
							
							global.playerExperience = 0;
							global.playerNextLevelExperience = global.experienceAmounts[global.playerLevel - 1];
							global.playerLevel++;
						}
					} else {
						var decayData = DecayExperience(0.1);
						var xpLost = decayData[0];
						var levelsLost = decayData[1];
						ds_list_add(toWrite, "You died! You lose " + string(xpLost) + " experience and resurrect outside of the dungeon.");
						global.playerHealth = global.playerMaxHealth;
						if levelsLost > 0 {
							ds_list_add(toWrite, "You lost a level!");
							var hpLost = decayData[2];
							var attackLost = decayData[3];
							var defenseLost = decayData[4];
							ds_list_add(toWrite, "You lost " + string(hpLost) + " HP.");
							ds_list_add(toWrite, "You lost " + string(attackLost) + " attack.");
							ds_list_add(toWrite, "You lost " + string(defenseLost) + " defense.");
						}
					}
					
					global.currentTimeCost += global.dungeonTimeCost;
				}
			} else {
				ds_list_add(toWrite, "You can fight the following kinds of monsters:");
				ds_list_add(toWrite, "    easy, medium, hard, extreme.");
			}
			
		} else {
			ds_list_add(toWrite, "You cannot fight anybody here.");
		}
		break;
		
	// TODO: workflow for logging out.
	case "logout":
		event_user(1); 
		break;
		
	// TODO: Print help.
	case "help":
		ds_list_add(toWrite, "List of commands available:");
		ds_list_add(toWrite, "'go <direction>' to move between rooms");
		ds_list_add(toWrite, "'buy/cost' at the Blacksmith to buy things or get cost of next thing");
		ds_list_add(toWrite, "'fight' at the Dungeon to fight monters");
		ds_list_add(toWrite, "'rest' at the Tavern to restore to full health");
		ds_list_add(toWrite, "'logout' to log out for the day");
		break;
		
	default:
		// TODO: Pick from a list of funny responses.
		ds_list_add(toWrite, "I do not understand");
}

with (inputController) {
	event_user(0);
}
ds_list_clear(toWrite);