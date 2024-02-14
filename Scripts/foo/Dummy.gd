extends StaticBody2D

const maxHealth = 100
var health = 100

func getDamage(damage):
	health -= damage
	print(str(health) + "/" + str(maxHealth))
