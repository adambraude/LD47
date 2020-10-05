extends RigidBody2D

export (PackedScene) var Fireball
var fireball

# Declares viable spawn box for bat

# Finds range of acceptable spawns

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
