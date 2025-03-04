extends Control

@export var Locations: Location
@export var children: Array = []
@export var player: playerStats
var markerScene = load("res://Util/UI/MarkerSprite2D.tscn")

var camera_zoom

func _ready():
	camera_zoom = get_viewport().get_camera_2d().zoom

func _process(_delta):
	#if player.get_signalMachineActive():
		for key in Locations.locations.keys():
			var marker = get_marker(key)
			if not marker &&  key != "player":
				marker = make_new_marker(key)
			
			var loc = Locations.locations[key]
			var screen_pos = (loc - _get_camera_rect().position) * camera_zoom
			if _target_on_screen(Locations.locations["player"], loc, key):
				marker.rotation = 0
				marker.global_position = screen_pos
				marker.visible = false
			elif !_target_on_screen(Locations.locations["player"], loc, key) &&  key != "player": 
				_set_screen_position(marker, screen_pos)
				_rotate_to_target(marker, loc)
				marker.visible = true
	#else:
		#if get_child(1) == null:
			#if children.size() > 0:
				#for child in children:
					#child.visible = false

func get_marker(key):
	for child in children:
		if child.name == key:
			return child
	return null

func make_new_marker(keys):
	var marker = markerScene.instantiate()
	marker.name = keys
	add_child(marker)
	children.append(marker)
	return marker

func _get_camera_rect():
	var camera = get_viewport().get_camera_2d()
	var camera_pos = camera.global_position
	var viewport_size = get_viewport_rect().size / camera.zoom
	return Rect2(
		camera_pos - viewport_size / 2,
		viewport_size
	)

func _target_on_screen(playerloc, otherlocation, key):
	var distance = otherlocation.distance_to(playerloc)
	if distance <= 200 && key != "player":
		print(key, " within distance to spawn")
		return true
	return false

func _set_screen_position(marker, screen_target_position):
	var screen_size = get_viewport_rect().size
	var borderOffset = 50
	var target_position = screen_target_position
	
	target_position.x = clamp(target_position.x, borderOffset, screen_size.x - borderOffset)
	target_position.y = clamp(target_position.y, borderOffset, screen_size.y - borderOffset)
	
	marker.global_position = target_position

func _rotate_to_target(marker, location):
	var camera = get_viewport().get_camera_2d()
	var current_position = camera.global_position
	var direction = (location - current_position).normalized()
	marker.rotation = direction.angle()
