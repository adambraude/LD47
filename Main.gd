extends Node

# Declare member variables here.

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$EnemySpawner/BatEnemyTimer.stop()
	get_tree().call_group("bats", "queue_free")
	$EnemySpawner/CrabEnemyTimer.stop()
	get_tree().call_group("crabs", "queue_free")
	get_tree().call_group("fireballs", "queue_free")
	
func new_game():
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$"Boss 1 Fight".startBossTimer()


func _on_Health_depleted():
	game_over()
