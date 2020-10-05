extends Area2D

export (PackedScene) var Fireball
var fireball

# Declares viable spawn box for bat

# Finds range of acceptable spawns

var explosionScene = load("res://Explosion.tscn")
var spawn = Vector2()

var attacked = false

func spawn(spawnin):
	$AnimatedSprite.play("Flap")
	#bat starts at far left of screen at spawn y value
	var start = spawnin
	start.x = 0
	position = start
	
	
	var track_index = $AnimatedSprite/Spawn.add_track(Animation.TYPE_VALUE)
	$AnimatedSprite/Spawn.track_set_path(track_index, "BatEnemy:position:x")
	$AnimatedSprite/Spawn.track_insert_key(track_index, 0.0, 0)
	$AnimatedSprite/Spawn.track_insert_key(track_index, 0.5, start.x)
	
	# Enemy moves right to given spawn x location in .5 seconds
#	var track_index = $AnimatedSprite/AnimationPlayer.add_track(Animation.TYPE_VALUE)
#	$AnimatedSprite/AnimationPlayer.track_set_path(track_index, 0.0, 0)
#	$AnimatedSprite/AnimationPlayer.track_insert_key(track_index, .5, spawn.x)
	
	# Moves into attack cycle
	attackWait()

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_health = $Health
	var healthbar = $ProgressBar
	$AnimationPlayer.play("Drop")
	$AnimatedSprite.position[1] -= 400
	$ProgressBar.rect_position[1] -= 400
	player_health.connect("changed", healthbar, "set_value")
	player_health.connect("max_changed", healthbar, "set_max")
	player_health.initialize()
	
	
	attackWait()
	#pass

func attackWait():
	$AnimatedSprite.play("Flap")
	
	#var attacked = false
	var timer = Timer.new()
	
	# Wait on attack is 2-5 seconds
	var wait = randf()*3+2
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
#	pass

func _on_AnimatedSprite_animation_finished():
	if attacked == true:
		attacked = false
		fireball.position = self.global_position
		get_node("/root/").add_child(fireball)
		attackWait()
		

func set_max(new_max):
	pass # Replace with function body.


func _on_Health_depleted():
	var explosion = explosionScene.instance()
	if randi() % 2 == 0:
		explosion.play("explosion_1")
	else:
		explosion.play("explosion_2")
	explosion.position = self.global_position
	get_node("/root/").add_child(explosion)
	queue_free()

func _on_BatEnemy_area_shape_entered(area_id, area, area_shape, self_shape):
	print("Bat was hit")
	#emit_signal("hit")
	if area == null:
		return
	$Health.take_damage(area.damage)
	if area.has_method("die"):
		area.die()
