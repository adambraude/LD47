extends Node

export (PackedScene) var Boss2

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func startBossTimer():
	$delayTime.start()


func _on_boss2Wait_timeout():
	$BossScreen.visible = true
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Health").set_current(999)
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").removeAndStopAll()
	
	$bossScreenTimer.start()


func _on_bossScreenTimer_timeout():
	$BossScreen.queue_free()
	var boss = Boss2.instance()
	boss.position = $bossSpawn.position
	add_child(boss)


func _on_delayTime_timeout():
	$boss2Wait.start()
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").startSpawns()
