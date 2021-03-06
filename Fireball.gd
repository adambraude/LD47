extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var explosionScene = load("res://Explosion.tscn")
export var velocity = 0
export var direction = PI/2
export var drag = 0
export var damage = 6
export var explosionType = "fireball"
export var explosionScale = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.play("fire")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.rotation = direction + PI*3/2
	move_local_x(velocity*delta*cos(direction))
	move_local_y(velocity*delta*sin(direction))
	if (velocity < 0):
		velocity = 0
	else:
		velocity -= delta*drag
	pass

func die():
	var explosion = explosionScene.instance()
	explosion.scale = Vector2(explosionScale, explosionScale)
	explosion.play(explosionType)
	explosion.position = self.global_position
	get_node("/root/").add_child(explosion)
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass


func _on_Fireball_body_entered(_body):
	#print("Fireball connected")
	hide()
	queue_free()
	$CollisionShape2D.set_deferred("disabled", true)
