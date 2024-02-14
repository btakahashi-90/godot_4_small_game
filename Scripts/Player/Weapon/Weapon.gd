extends Node2D

@export var weaponSprite : Texture2D

const upPos = Vector2(-9, -60)
const downPos = Vector2(-7, 10)
const rightPos = Vector2(36, -12)
const leftPos = Vector2(-32, -12)

const upRot = 180
const downRot = 0
const rightRot = -90
const leftRot = 90

func _ready():
	self.hide()
	$Sprite2D.texture = weaponSprite
	
func _process(delta):
	weaponPos()
	
func weaponPos():
	match get_parent().direction:
		"up":
			self.position = upPos
			self.rotation_degrees = upRot
			$Sprite2D.flip_h = false
		"down":
			self.position = downPos
			self.rotation_degrees = downRot
			$Sprite2D.flip_h = false
		"left":
			self.position = leftPos
			self.rotation_degrees = leftRot
			$Sprite2D.flip_h = true
		"right":
			self.position = rightPos
			self.rotation_degrees = rightRot
			$Sprite2D.flip_h = false


func _on_weapon_hitbox_body_entered(body):
	if body.is_in_group("Hittable"):
		body.getDamage(10)
