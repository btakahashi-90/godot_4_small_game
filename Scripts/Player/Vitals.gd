extends Node2D

signal updatePUI

var hungerZero = false

func getDamage(damage):
	PlayerState.health = max(PlayerState.health - damage, 0)
	updateui()
	if PlayerState.health <= 0:
		playerDeath()
		
func gainHealth(healthAdded):
	PlayerState.health = min(PlayerState.health + healthAdded, PlayerState.maxHealth)
	updateui()
	
func loseHunger(hungerToLose):
	PlayerState.hunger = max(PlayerState.hunger - hungerToLose, 0)
	updateui()
	if PlayerState.hunger == 0 and !hungerZero:
		hungerZero = true
		$"../Timers/DamageOfHungerTimer".start()
		
func gainHunger(hungerAdded):
	PlayerState.hunger = min(PlayerState.hunger + hungerAdded, PlayerState.maxHunger)
	updateui()
	
func playerDeath():
	print("Player has died")

func _on_hunger_timer_timeout():
	loseHunger(1)

func _on_damage_of_hunger_timer_timeout():
	getDamage(10)
	hungerZero = false

func updateui():
	$"../../CanvasLayer/HUD".updateUI()
