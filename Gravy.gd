extends Node


export var pull = 0.3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#for future readers: NEVER DO THIS THIS WAY
	var turnDir = PI/2 - get_parent().direction
	while turnDir < -PI:
		turnDir += 2*PI
	while turnDir > PI:
		turnDir -= 2*PI
	turnDir = turnDir/abs(turnDir)
	get_parent().direction += delta*pull*turnDir
	pass
