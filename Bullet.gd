extends Node2D


# Declare member variables here. Examples:
export var velocity = 0
export var direction = 0
export var drag = 0
export var damage = 1
export var explosionType = "spark"

var explosionScene = load("res://Explosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func die():
	var explosion = explosionScene.instance()
	get_node("/root/").add_child(explosion)
	explosion.play(explosionType)
	explosion.position = self.global_position
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.rotation = direction + PI/2
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
