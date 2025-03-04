extends Area2D

@onready var store_ui = %StoreUI
@onready var inputMan = owner.owner.owner.get_child(0)


var playerInside = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	store_ui.set_visible(false)
	if inputMan:
		inputMan.connect("interact", Callable(self, "openCloseStoreUI"))

func openCloseStoreUI():
	if playerInside:
		#ternary operator that will switch based on what the value is then switching it to the other
		store_ui.visible = not store_ui.visible

func _on_area_entered(area: Area2D) -> void:
	if area.name == "SwingArea":
		playerInside = true

func _on_area_exited(area: Area2D) -> void:
	if area.name == "SwingArea":
		playerInside = false
