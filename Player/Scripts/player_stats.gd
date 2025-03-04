class_name playerStats
extends Resource

@export var health = 100
@export var oxygen = 200
@export var ore: int = 0
@export var money: int = 0
@export var signalMachineActive: bool = true

func get_signalMachineActive():
	return signalMachineActive

func set_signalMachineActive(input: bool):
	signalMachineActive = input

enum CharacterItem {GUN, PICKAXE}
@export var character_items: Array[CharacterItem]
