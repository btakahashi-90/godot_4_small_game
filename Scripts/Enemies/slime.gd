extends CharacterBody2D

var speed = 150
var player
var direction = "d"

var health = 100
var Hit = false
var Dead = false

func _ready():
	$HealthBar.max_value = health
	updateUI()
	
func _process(delta):
	if !Dead:
		EnemyAnimation()
		if player != null and !Hit:
			velocity = player.position - self.position
			velocity = velocity.normalized() * speed
				
			move_and_slide()
		
func getDamage(damage):
	Hit = true
	$AnimationPlayer.play("Hit")
	velocity = Vector2.ZERO
	$PauseTimer.start()
	health = max(health - damage, 0)
	updateUI()
	if health <= 0:
		Dead = true
		enemyDeath()
		
func enemyDeath():
	Hit = true
	$AnimationPlayer.play("Death")
	await get_tree().create_timer(1).timeout
	queue_free()

func _on_detection_area_body_entered(body):
	player = body
	

func _on_detection_area_body_exited(body):
	player = null
	velocity = Vector2.ZERO

func _on_hit_area_body_entered(body):
	body.get_node("Vitals").getDamage(30)

func EnemyAnimation():
	if velocity.x > 0:
		direction = "r"
	elif velocity.x < 0:
		direction = "l"
	elif velocity.y > 0:
		direction = "d"
	elif velocity.y < 0:
		direction = "u"
		
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("idle_" + direction)
	else:
		$AnimatedSprite2D.play("walk_" + direction)

func _on_pause_timer_timeout():
	Hit = false

func updateUI():
	$HealthBar.value = health
