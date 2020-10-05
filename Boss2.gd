extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
	get_tree().get_root().get_node("Main").find_node("Boss 3 Fight").startBossTimer()
