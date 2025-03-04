extends Node2D

@onready var bottom = get_parent().find_child("Player_Bottom")
@onready var inputMan = owner.owner.get_child(0)

@export var stats: playerStats

var canHit = false
var canSell = false

func _ready() -> void:
	if inputMan:
		inputMan.connect("action", Callable(self, "swing"))
		inputMan.connect("interact", Callable(self, "interact"))

func swing():
	if canHit:
		mine()

#give player ore
func mine():
	stats.ore += 1

func interact():
	if stats.ore > 0 && canSell:
		stats.money = stats.ore * 2
		stats.ore = 0

func _physics_process(_delta):
	global_position = bottom.global_position  # Follow Player_Bottom
	
	var mouse_pos = get_global_mouse_position()  # Get mouse position in world coordinates
	var direction = (mouse_pos - global_position).normalized()
	rotation = direction.angle()


func _on_swing_area_body_entered(body: Node2D) -> void:
	if body.name == "Astroid":
		canHit = true
	if body.name == "Ore_Deposit":
		canSell = true


func _on_swing_area_body_exited(body: Node2D) -> void:
	if body.name == "Astroid":
		canHit = false
	if body.name == "Ore_Deposit":
		canSell = false
