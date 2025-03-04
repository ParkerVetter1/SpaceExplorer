extends Resource
class_name InventorySlot

@export var item: ItemData
@export var amount: int

func clear():
	item = null
	amount = 0

func isEmpty() -> bool:
	if item == null:
		return true
	else:
		return false
