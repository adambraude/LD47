extends Node2D


# Declare member variables here. Examples:
export var velocity = 0
export var direction = 0
export var drag = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func die():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_x(velocity*delta*cos(direction))
	move_local_y(velocity*delta*sin(direction))
	if (velocity < 0):
		velocity = 0
	else:
		velocity -= delta*drag
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass
