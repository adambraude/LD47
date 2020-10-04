extends RigidBody2D

# Declares viable spawn box for bat
var spawnxLeft = 150
var spawnxRight = 1800
var spawnyUp = 50
var spawnyDown = 400

# Finds range of acceptable spawns
var spawnWidth = spawnxRight - spawnxLeft
var spawnHeight = spawnyDown - spawnyUp

var spawn = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getSpawn():
	# Find a spawning location that is allowed by the bat
	spawn.x = (randf()*spawnWidth + spawnxLeft)
	spawn.y = (randf()*spawnHeight + spawnyUp)
	return spawn

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
