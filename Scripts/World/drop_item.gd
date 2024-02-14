extends Area2D

@export var item : InventoryItem

func _ready():
	$Sprite2D.texture = item.texture

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.collect(item)
		await get_tree().create_timer(0.2).timeout
		queue_free()
