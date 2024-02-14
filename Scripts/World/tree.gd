extends StaticBody2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@export var maxHealth : int = 30
@export var dropItemData : InventoryItem
var dropItemScene = preload("res://Scenes/drop_item.tscn")

var health = maxHealth
var phase = 3 # fully grown tree
var readyToHarvest = true

func _ready():
	$HealthBar.hide()
	updateUI()
	
func updateUI():
	$HealthBar.max_value = maxHealth
	$HealthBar.value = health
	
func getDamage(damage):
	if readyToHarvest:
		$HealthBar.show()
		$Timers/RemoveBarTimer.start()
		health = max(0, health - damage)
		updateUI()
		if health <= 0:
			destroy()
			
func destroy():
	readyToHarvest = false
	dropItem()
	self.collision_layer = 0
	$HealthBar.hide()
	phase = 0
	anim.play(str(phase))
	$Timers/RegenTimer.start()
	
func dropItem():
	var dropItemInstance = dropItemScene.instantiate()
	dropItemInstance.item = dropItemData
	add_child(dropItemInstance)

func _on_regen_timer_timeout():
	self.collision_layer = 1
	if phase == 2:
		phase += 1
		anim.play(str(phase))
		health = maxHealth
		readyToHarvest = true
	else:
		phase += 1
		anim.play(str(phase))
		$Timers/RegenTimer.start()

func _on_remove_bar_timer_timeout():
	$HealthBar.hide()
