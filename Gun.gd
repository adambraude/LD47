extends Node2D


# Declare member variables here. Examples:
export var bulletType = "res://Bullet-0.tscn"
var bulletScene
var shooting = false
export var accuracy = 16


# Called when the node enters the scene tree for the first time.
func _ready():
	bulletScene = load(bulletType)
	$AnimatedSprite.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_pressed("shoot") and $cooldown.time_left == 0):
		  $AnimatedSprite.animation = "fire"
		  var bullet = bulletScene.instance()
		  bullet.position = self.global_position
		  bullet.direction = PI*3/2
		  bullet.direction += rand_range(-PI/accuracy, PI/accuracy)
		  get_node("/root/").add_child(bullet)
		  $cooldown.start()
	if(not Input.is_action_pressed("shoot")):
		$AnimatedSprite.animation = "idle"
	pass

