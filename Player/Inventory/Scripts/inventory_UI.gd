extends Panel

@onready var inv: InventoryData = preload("res://Player/Inventory/Resources/inventory_data.tres")
@onready var slots: Array = $MarginContainer/HBoxContainer/GridContainer.get_children()

var is_open = false

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.slot_data.size(), slots.size())):
		slots[i].update(inv.slot_data[i])

func _process(delta): 
	if Input.is_action_just_pressed("openInventory"):
		if is_open:
			close()
		else:
			#update_slots()
			open()

func open():
	self.visible = true
	is_open = true

func close():
	visible = false
	is_open = false
