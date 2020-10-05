extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var projectile = load("res://Fireneedle.tscn")
var fireball
var attacked = false
var attackSpeed= 500

var attackDir = Vector2()

var explosionScene = load("res://Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_health = $Health
	var healthbar = $HealthBar
	
	player_health.connect("changed", healthbar, "set_value")
	player_health.connect("max_changed", healthbar, "set_max")
	player_health.initialize()
	attackWait()

func attackWait():
	$AnimatedSprite.play("Idle")
	$AnimatedSprite.move_local_y(33)
	
	#var attacked = false
	var timer = Timer.new()
	
	# Wait on attack is 2-5 seconds
	var wait = randf()*2+1
	timer.set_wait_time(wait)
	
	timer.set_one_shot(true)
	
	timer.connect("timeout", self, "attack")
	
	add_child(timer)
	
	timer.start()

func attack():
	attacked = true
	$AnimatedSprite.move_local_y(-33)
	$AnimatedSprite.play("Attack")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_AnimatedSprite_animation_finished():
	if attacked == true:
		attacked = false
		
		var localPlayer = get_tree().get_root().get_node("Main").find_node("Player")
		
		for i in range(-1, 2, 1):
			fireball = projectile.instance()
			fireball.position = $"Fireball Spawn Location".global_position
			attackDir = localPlayer.position - fireball.position
			var normAttack = attackDir.normalized()
			fireball.velocity = (normAttack*attackSpeed).length()
			fireball.direction = (normAttack*attackSpeed).angle() + PI/64*i
			get_node("/root/").add_child(fireball)
		
		attackWait()
		
		
func _on_Health_depleted():
	var explosion = explosionScene.instance()
	explosion.scale = Vector2(1.1, 1.1)
	get_node("/root/").add_child(explosion)
	if randi() % 2 == 0:
		explosion.play("explosion_1")
	else:
		explosion.play("explosion_2")
	explosion.position = self.global_position
	queue_free()


func _on_CrabEnemy_area_shape_entered(area_id, area, area_shape, local_shape):
	print("crab was hit")
	$Health.take_damage(area.damage)
	if area.has_method("die"):
		area.die()
