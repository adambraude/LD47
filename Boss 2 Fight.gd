extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func startBossTimer():
	$boss2Wait.start()
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").startSpawns()


func _on_boss2Wait_timeout():
	#$BossScreen.visible = true
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Health").set_current(999)
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").removeAndStopAll()
	
	#$BossScreenTimer.start()
