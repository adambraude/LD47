extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var attacked = false


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
	var wait = randf()*3+2
	timer.set_wait_time(wait)
	
	timer.set_one_shot(true)
	
	timer.connect("timeout", self, "attack")
	
	add_child(timer)
	
	timer.start()
	#fireball = Fireball.instance()

func attack():
	attacked = true
	$AnimatedSprite.play("Attack")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	if attacked == true:
		attacked = false
		#fireball.position = $AnimatedSprite.position
		#add_child(fireball)
		attackWait()
		
		
func _on_Player_body_entered(_body):
	print("crab was hit")
	#emit_signal("hit")
	$Health.take_damage(1)
	#$CollisionShape2D.set_deferred("disabled", true)
