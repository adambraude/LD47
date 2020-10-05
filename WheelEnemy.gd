extends Area2D

export (PackedScene) var fireball
export var accuracy = 8

# Declares viable spawn box for bat

# Finds range of acceptable spawns

var explosionScene = load("res://Explosion.tscn")
var spawn = Vector2()

var attacked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var player_health = $Health
	var healthbar = $ProgressBar
	$AnimationPlayer.play("Drop")
	$AnimatedSprite.position[1] -= 400
	$AnimatedSprite.play("Crackle")
	$ProgressBar.rect_position[1] -= 400
	$cooldown.start(1)
	player_health.connect("changed", healthbar, "set_value")
	player_health.connect("max_changed", healthbar, "set_max")
	player_health.initialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($cooldown.time_left == 0):
		  var fb = fireball.instance()
		  fb.position = self.global_position + Vector2(0, -80)
		  fb.direction = PI*3/2
		  fb.direction += rand_range(-PI/accuracy, PI/accuracy)
		  fb.get_node("Gravy").pull *= rand_range(0.5, 3)
		  get_node("/root/").add_child(fb)
		  $cooldown.start()
	$AnimatedSprite.rotate(delta)
	$AnimatedSprite/Sprite.rotate(delta)
		


func _on_Health_depleted():
	var explosion = explosionScene.instance()
	if randi() % 2 == 0:
		explosion.play("explosion_1")
	else:
		explosion.play("explosion_2")
	explosion.position = self.global_position
	get_node("/root/").add_child(explosion)
	queue_free()

func _on_WheelEnemy_area_shape_entered(area_id, area, area_shape, self_shape):
	print("Wheel was hit")
	if area == null:
		return
	$Health.take_damage(area.damage)
	if area.has_method("die"):
		area.die()
