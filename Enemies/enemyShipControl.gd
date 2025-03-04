extends RigidBody2D

@export var speed = 200.0
@export var friction = 0.01
@export var acceleration = 0.1
@export var sprint_multiplier = 2.0
@export var local_mouse_position: Vector2 = Vector2.ZERO

@onready var enemy = $CharacterBody2D/NavigationAgent2D

func _physics_process(delta):
	var direction = get_input()
	var target_speed = speed
	
	if Input.is_action_pressed("run"):
		target_speed *= sprint_multiplier
	
	if direction.length() > 0:
		linear_velocity = linear_velocity.lerp(direction.normalized() * target_speed, acceleration)
	else:
		linear_velocity = linear_velocity.lerp(Vector2.ZERO, friction)
	
	if local_mouse_position != Vector2.ZERO:
		enemy.target_position = local_mouse_position
		enemy.get_next_path_position()
	

func _ready():
	NavigationServer2D.connect("map_changed", Callable(self, "_on_navigation_map_changed"))

func _on_navigation_map_changed(map_id):
	print("Navigation Map Updated!")

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		local_mouse_position = to_local(event.position)
		print("Local Mouse Position: ", local_mouse_position)

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
