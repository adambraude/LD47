extends RigidBody2D

#export (PackedScene) var Fireball
var fireball

# Declares viable spawn box for bat
var spawnxLeft = 225
var spawnxRight = 1700
var spawnyUp = 50
var spawnyDown = 350

# Finds range of acceptable spawns
var spawnWidth = spawnxRight - spawnxLeft
var spawnHeight = spawnyDown - spawnyUp

var spawn = Vector2()

var attacked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	attackWait()

func attackWait():
	$AnimatedSprite.play("Flap")
	
	var attacked = false
	var timer = Timer.new()
	
	# Wait on attack is 2-5 seconds
	var wait = randf()*3+2
	timer.set_wait_time(wait)
	
	timer.set_one_shot(true)
	
	timer.connect("timeout", self, "attack")
	
	add_child(timer)
	
	timer.start()

func attack():
	attacked = true
	$AnimatedSprite.play("Attack")

func getSpawn():
	# Find a spawning location that is allowed by the bat
	spawn.x = (randf()*spawnWidth + spawnxLeft)
	spawn.y = (randf()*spawnHeight + spawnyUp)
	return spawn

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	if attacked == true:
	#	fireball.position = spawn
	#	add_child(fireball)
		attackWait()
