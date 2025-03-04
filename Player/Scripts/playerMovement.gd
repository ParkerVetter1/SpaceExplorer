#class_name Player
extends CharacterBody2D

@export var stats: playerStats
@export var Locations: Location
@export var inv: InventoryData
#inputMan is not needed because the input for movement needs to be based on the physics engine can be revamped later but not right now
#@onready var inputMan = owner.owner.get_child(0)
@export var speed = 200
@export var friction = 0.01
@export var acceleration = 0.1

@onready var parent_node: Node2D = get_parent()
@onready var oreNumbLabel: Label = %Ore
@onready var moneyNumbLabel: Label = %Money
var last_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	stats.character_items.append(playerStats.CharacterItem.PICKAXE)

func _physics_process(_delta):
	var direction = get_input()
	if Input.is_action_pressed("run"):
		speed = 400
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	updatePlayerPositionMarker()
	move_and_slide()
	speed = 200

func updatePlayerPositionMarker():
	if Vector2(global_position) != last_position && Vector2(0.0,0.0) != Vector2(global_position):
		Locations.addLocation(Vector2(global_position), "player")
		last_position = Vector2(global_position)

func _process(_delta: float) -> void:
	updatePlayerUI()

func updatePlayerUI():
	oreNumbLabel.text = str(stats.ore)
	moneyNumbLabel.text = str(stats.money)

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func player():
	pass

func collect(item):
	inv.insert(item)
