extends Resource
class_name InventoryData

@export var slot_data: Array[InventorySlot]
signal update

func insert(item: ItemData):
	var itemsSlots = slot_data.filter(func(slot): return slot.item == item)
	if !itemsSlots.is_empty():
		itemsSlots[0].amount += 1
	else:
		var emptySlots = slot_data.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1
	update.emit()

func move(slot1: InventorySlot, slot2: InventorySlot):
	var tempSlot:InventorySlot = slot1
	slot1.clear
	if slot2.item == tempSlot.item:
		slot2.amount += tempSlot.amount
	else:
		if slot2.isEmpty():
			slot2 = tempSlot
		else:
			#space is filled with something else
			return
	
