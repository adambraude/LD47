extends Node


# Declare member variables here. Examples:
var SPAWNXLEFT = 225
var SPAWNXRIGHT = 1700
var SPAWNYUP = 50
var SPAWNYDOWN = 350

# Finds range of acceptable spawns
var spawnWidth = SPAWNXRIGHT - SPAWNXLEFT
var spawnHeight = SPAWNYDOWN - SPAWNYUP

var spawn = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getSpawn():
	# Find a spawning location that is allowed by the bat
	spawn.x = (randf()*spawnWidth + SPAWNXLEFT)
	spawn.y = (randf()*spawnHeight + SPAWNYUP)
	return spawn

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
