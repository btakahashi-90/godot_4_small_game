extends CharacterBody2D

@onready var Animator = $Sprite2D

@export var inventory : Inventory

var speed : int = 250
var direction : String = "down"

var isAttacking : bool = false
var inAttackCoolDown : bool = false

func _process(delta):
	PlayerMovement()
	PlayerAnimation()
	PlayerWeapon()
	
func PlayerWeapon():
	if Input.is_action_just_pressed("Attack") and !isAttacking:
		isAttacking = true
		$Weapon.show()
		Animator.play("attack_" + direction)
		$Weapon/WeaponHitbox/CollisionShape2D.disabled = false
		$Timers/AttackTimer.start()
		
func PlayerMovement():
	velocity = Input.get_vector("left", "right", "up", "down")
	velocity = velocity.normalized() * speed
	
	move_and_slide()

func PlayerAnimation():
	if velocity.x > 0:
		direction = "right"
	elif velocity.x < 0:
		direction = "left"
	elif velocity.y > 0:
		direction = "down"
	elif velocity.y < 0:
		direction = "up"
		
	if velocity == Vector2.ZERO and !isAttacking:
		Animator.play("idle_" + direction)
	elif velocity != Vector2.ZERO and !isAttacking:
		Animator.play("walk_" + direction)


func _on_attack_timer_timeout():
	inAttackCoolDown = true
	$Weapon.hide()
	$Weapon/WeaponHitbox/CollisionShape2D.disabled = true
	isAttacking = false
	$Timers/AttackCoolDownTimer.start()
	

func _on_attack_cool_down_timer_timeout():
	inAttackCoolDown = false

func collect(item):
	inventory.insert(item)
