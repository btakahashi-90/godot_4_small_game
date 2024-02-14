extends Panel

@onready var itemVisual : Sprite2D = $CenterContainer/Panel/ItemDisplay
@onready var amountText : Label = $CenterContainer/Panel/Label

func update(slot: InventorySlot):
	if !slot.item:
		itemVisual.hide()
		amountText.hide()
	else:
		itemVisual.show()
		itemVisual.texture = slot.item.texture
		if slot.amount > 1:
			amountText.text = str(slot.amount)
			amountText.show()
