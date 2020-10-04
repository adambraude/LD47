extends RigidBody2D

# Declare member variables here. Examples:
var spawnxLeft = 150
var spawnxRight = 1800
var spawnyUp = 50
var spawnyDown = 400

var spawnWidth = spawnxRight - spawnxLeft
var spawnHeight = spawnyDown - spawnyUp

var spawn = Vector2()
var xLocation
var yLocation


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var bat = instance()
	
	spawn.x = int(randf()*spawnWidth + spawnxLeft)
	spawn.y = int(randf()*spawnHeight + spawnyUp)
	
	#bat.position.x = spawn.x
	#bat.position.y = spawn.y
	#add_child(bat)
