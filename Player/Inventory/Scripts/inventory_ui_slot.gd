extends Panel

@onready var item_visual: Sprite2D = $ItemTexture
@onready var amount_text: Label = $Label

func update(slot: InventorySlot):
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true
		amount_text.text = str(slot.amount)


#begin of a drag from this slot generate data needed
func _get_drag_data(at_position: Vector2) -> Variant:
	
	#checks name of slot then check where in the array of Inventory data that it is
	## this is inefficient
	var myName: String = self.name
	var number_str = myName.lstrip("slot")
	if number_str.is_valid_int():
		number_str = int(number_str) - 1
	else:
		number_str = 0
		
	#if inv.slot_data[number_str].isempty():
		#return
	
	#check self posistion if it is is at_position if not disregard
	if is_point_inside(at_position):
		# return the InventorySlot data that is in here
		#return data
		pass
	return

#check if data can be dropped on this slot
#useful for equipment i.e swords can only go in weapon slot
#just returning true here

func _can_drop_data(position, data):
	# Check position if it is relevant to you
	if !is_point_inside(position):
		# Otherwise, just check data
		pass
	else:
		#set Data to be with this slot
		pass
	pass


func _drop_data(at_position: Vector2, data: Variant) -> void:
	pass


func is_point_inside(point: Vector2) -> bool:
	var rect = Rect2(global_position, size)
	return rect.has_point(point)
