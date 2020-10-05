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


func _on_Boss3_area_entered(area):
	if area == null:
		return
	$Health.take_damage(area.damage)
	if area.has_method("die"):
		area.die()


func _on_Health_depleted():
	queue_free()
	for i in range(0, 100):
		var explosion = explosionScene.instance()
		explosion.position += Vector2(rand_range(-200, 200), rand_range(-200, 200))
		explosion.play("fireball")
		explosion.position = self.global_position
		get_node("/root/").add_child(explosion)
	get_tree().change_scene("res://End of Game Screen.tscn")


func _on_AudioStreamPlayer_finished():
	$BossMusic.play(0)
