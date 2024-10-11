extends Node

const ICON_PATH = "res://"
const WEAPON_PATH = "res://"


const UPGRADES = {
	"Sword1": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "Sword",
		"details": "A sword is thrown at a closet enemy",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"Sword2": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "Sword",
		"details": "An addition Sword is thrown",
		"level": "Level: 2",
		"prerequisite": ["Sword1"],
		"type": "weapon"
	},
	"Sword3": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "Sword",
		"details": "Sword now pass through another enemy and do + 3 damage",
		"level": "Level: 3",
		"prerequisite": ["Sword2"],
		"type": "weapon"
	},
	"Sword4": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "Sword",
		"details": "An additional 2 Sword are thrown",
		"level": "Level: 4",
		"prerequisite": ["Sword3"],
		"type": "weapon"
	},
	"shuriken1": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "shuriken",
		"details": "A magical shuriken will rotate around you attacking enemies",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"shuriken2": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "shuriken",
		"details": "Spwans an additional shuriken",
		"level": "Level: 2",
		"prerequisite": ["shuriken1"],
		"type": "weapon"
	},
	"shuriken3": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "shuriken",
		"details": "Spwans an additional shuriken",
		"level": "Level: 3",
		"prerequisite": ["shuriken2"],
		"type": "weapon"
	},
	"shuriken4": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "shuriken",
		"details": "Spwans an additional shuriken",
		"level": "Level: 4",
		"prerequisite": ["shuriken3"],
		"type": "weapon"
	},
	"shuriken5": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "shuriken",
		"details": "The shuriken now does + 5 damage per attack and has 20% cooldown reduction",
		"level": "Level: 4",
		"prerequisite": ["shuriken4"],
		"type": "weapon"
	},
	"tornado1": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "Tornado",
		"details": "A tornado is created and random heads somewhere in the random direction",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"tornado2": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "Tornado",
		"details": "An additional Tornado is created",
		"level": "Level: 2",
		"prerequisite": ["tornado1"],
		"type": "weapon"
	},
	"tornado3": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "Tornado",
		"details": "The Tornado cooldown is reduced by 0.5 seconds",
		"level": "Level: 3",
		"prerequisite": ["tornado2"],
		"type": "weapon"
	},
	"tornado4": {
		"icon": WEAPON_PATH + "icon.svg",
		"displayname": "Tornado",
		"details": "An additional tornado is created and the cooldown decreased by 25%",
		"level": "Level: 4",
		"prerequisite": ["tornado3"],
		"type": "weapon"
	},
	"armor1": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Armor",
		"details": "Reduces Damage By 1 point",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	"speed1": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Speed",
		"details": "Movement Speed Increased by 50% of base speed",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Speed",
		"details": "Movement Speed Increased an additional 50% of base speed",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	"tome1": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"tome2": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 2",
		"prerequisite": ["tome1"],
		"type": "upgrade"
	},
	"tome3": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 3",
		"prerequisite": ["tome2"],
		"type": "upgrade"
	},
	"tome4": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Tome",
		"details": "Increases the size of spells an additional 10% of their base size",
		"level": "Level: 4",
		"prerequisite": ["tome3"],
		"type": "upgrade"
	},
	"AdditionalAtk1": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Ring",
		"details": "Your spells now spawn 1 more additional attack",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"AdditionalAtk2": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Ring",
		"details": "Your spells now spawn an additional attack",
		"level": "Level: 2",
		"prerequisite": ["AdditionalAtk1"],
		"type": "upgrade"
	},
	"food": {
		"icon": ICON_PATH + "icon.svg",
		"displayname": "Food",
		"details": "Heals you for 20 health",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	}
}
