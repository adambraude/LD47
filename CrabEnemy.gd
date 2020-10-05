extends Area2D

export (PackedScene) var Fireball


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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
	
	#var attacked = false
	var timer = Timer.new()
	
	# Wait on attack is 2-5 seconds
	var wait = randf()*2+1
	timer.set_wait_time(wait)
	
	timer.set_one_shot(true)
	
	timer.connect("timeout", self, "attack")
	
	add_child(timer)
	
	timer.start()
	
	fireball = Fireball.instance()

func attack():
	attacked = true
	$AnimatedSprite.play("Attack")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_AnimatedSprite_animation_finished():
	if attacked == true:
		attacked = false
		fireball.position = self.global_position
		
		var localPlayer = get_tree().get_root().get_node("Main").find_node("Player")
		
		attackDir = localPlayer.position - fireball.position
		
		var normAttack = attackDir.normalized()
		
		fireball.velocity = (normAttack*attackSpeed).length()
		fireball.direction = (normAttack*attackSpeed).angle()

		get_node("/root/").add_child(fireball)
		attackWait()
		
		
func _on_Health_depleted():
	var explosion = explosionScene.instance()
	explosion.scale(1.4,1.4)
	get_node("/root/").add_child(explosion)
	if randi() % 2 == 0:
		explosion.play("explosion1")
	else:
		explosion.play("explosion2")
	explosion.position = self.global_position
	queue_free()


func _on_CrabEnemy_area_shape_entered(area_id, area, area_shape, local_shape):
	print("crab was hit")
	$Health.take_damage(1)
	if area.has_method("die"):
		area.die()
	pass # Replace with function body.
