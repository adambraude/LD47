extends AnimatedSprite



# Called when the node enters the scene tree for the first time.
func _ready():
	rotate(rand_range(0, 2*PI))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Explosion_animation_finished():
	queue_free()
	pass # Replace with function body.
