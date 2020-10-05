extends Node

export (PackedScene) var Boss1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func startBossTimer():
	$"Time until Boss".start()

func _on_Time_until_Boss_timeout():
	$BossScreen.visible = true
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Health").set_current(999)
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").removeAndStopAll()
	$BossScreenTimer.start()

func _on_BossScreenTimer_timeout():
	$BossScreen.visible = false
	$BossScreen.queue_free()
	var boss = Boss1.instance()
	boss.position = $bossSpawn.position
	add_child(boss)
