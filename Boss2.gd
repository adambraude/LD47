extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var explosionScene = load("res://Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Idle")
	
	var player_health = $Health
	var healthbar = $HealthBar
	
	player_health.connect("changed", healthbar, "set_value")
	player_health.connect("max_changed", healthbar, "set_max")
	player_health.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Boss2_area_entered(area):
	print("boss was hit")
	$Health.take_damage(1)
	if area.has_method("die"):
		area.die()


func _on_Health_depleted():
	queue_free()
	for i in range(0, 100):
		var explosion = explosionScene.instance()
		explosion.position += Vector2(rand_range(-250, 250), rand_range(-250, 250))
		if randi() % 2 == 0:
			explosion.play("explosion_1")
		else:
			explosion.play("explosion_2")
		explosion.position = self.global_position
		get_node("/root/").add_child(explosion)
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Rockets").show()
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Rockets").set_process(true)
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").difficulty = 2
	get_tree().get_root().get_node("Main").find_node("Boss 3 Fight").startBossTimer()
