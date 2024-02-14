extends Control

func ready():
	updateUI()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		PlayerState.health = min(PlayerState.health + 10, PlayerState.maxHealth)
		updateUI()
	elif Input.is_action_just_pressed("ui_left"):
		PlayerState.health = max(PlayerState.health - 10, 0)
		updateUI()

func updateUI():
	$HealthBar.max_value = PlayerState.maxHealth
	$HealthBar.value = PlayerState.health
	$HungerBar.max_value = PlayerState.maxHunger
	$HungerBar.value = PlayerState.hunger
