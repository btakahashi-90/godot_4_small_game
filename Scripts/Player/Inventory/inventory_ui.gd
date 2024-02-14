extends Control

var isOpen = false

@onready var inventory : Inventory = preload("res://Scripts/Player/Inventory/PlayerInventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	inventory.update.connect(updateSlots)
	updateSlots()
	close()
	
func _process(delta):
	if Input.is_action_just_pressed("inv"):
		if isOpen:
			close()
		else:
			open()
	
func updateSlots():
	for i in range(min(inventory.slots.size(), slots.size())):
		slots[i].update(inventory.slots[i])
	
func close():
	self.hide()
	isOpen = false
	
func open():
	self.show()
	isOpen = true
