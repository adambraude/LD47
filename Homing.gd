extends Node


export var homing = 2.0

export var target = "*EnemyHitBox"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#for future readers: NEVER DO THIS THIS WAY
	var targetNode = get_node("/root").find_node(target, true, false)
	if targetNode == null: 
		return
	var attackDir = targetNode.get_parent().position - get_parent().position
	var angle = attackDir.angle()
	var turnDir = angle - get_parent().direction
	while turnDir < -PI:
		turnDir += 2*PI
	while turnDir > PI:
		turnDir -= 2*PI
	if (turnDir != 0):
		turnDir = turnDir/abs(turnDir)
	get_parent().direction += delta*homing*turnDir
	pass
