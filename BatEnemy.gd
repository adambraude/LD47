extends RigidBody2D

# Declares viable spawn box for bat
var spawnxLeft = 225
var spawnxRight = 1700
var spawnyUp = 50
var spawnyDown = 350

# Finds range of acceptable spawns
var spawnWidth = spawnxRight - spawnxLeft
var spawnHeight = spawnyDown - spawnyUp

var spawn = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Flap")
	attackWait()

func attackWait():
	var timer = Timer.new()
	
	var wait = randf()*2+1
	timer.set_wait_time(wait)
	
	timer.set_one_shot(true)
	
	timer.connect("timeout", self, "attack")
	
	add_child(timer)
	
	timer.start()

func attack():
	$AnimatedSprite.play("Attack")

func getSpawn():
	# Find a spawning location that is allowed by the bat
	spawn.x = (randf()*spawnWidth + spawnxLeft)
	spawn.y = (randf()*spawnHeight + spawnyUp)
	return spawn

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
