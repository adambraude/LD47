extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var damage = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Laser")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
