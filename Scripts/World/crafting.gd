extends Control

@export var craftable : Array[InventoryItem]
@export var materials : Array[InventoryItem]

@export var player : CharacterBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_workshop_body_entered(body):
	if body.is_in_group("Player"):
		self.show()

func _on_workshop_body_exited(body):
	if body.is_in_group("Player"):
		self.hide()

func _on_craft_axe_pressed():
	# Minor bug to fix - if amount needed would reduce mats to 0, does not remove from inventory?
	var allMaterialsFound = true
	var materialAmountNeeded = 3
	var materialsNeeded = materials[0]
	for slot in player.inventory.slots:
		print(slot.item)
		if slot.item == materialsNeeded and slot.amount >= materialAmountNeeded:
			slot.amount -= materialAmountNeeded
			player.collect(craftable[0])
			return
	#var materialsNeeded = [materials[0], materials[0]]
	#for mat in materialsNeeded:
		#for slot in player.inventory.slots:
			#if slot.item == mat and slot.amount >= materialAmountNeeded:
				#slot.amount -= materialAmountNeeded
			#else:
				#allMaterialsFound = false
	#if allMaterialsFound:
		#player.collect(craftable[0])
