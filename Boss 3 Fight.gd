extends Node

export (PackedScene) var Boss3

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func startBossTimer():
	$boss3Wait.start()
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").startSpawns()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_boss3Wait_timeout():
	$BossScreen.visible = true
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Health").set_current(999)
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").removeAndStopAll()
	
	$bossScreenTimer.start()


func _on_bossScreenTimer_timeout():
	$BossScreen.queue_free()
	var boss = Boss3.instance()
	boss.position = $bossSpawn.position
	add_child(boss)
