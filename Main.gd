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
	$MobTimer.stop()
	get_tree().call_group("bats", "queue_free")
	
func new_game():
	$Player.start($StartPosition.position)
	$StartTimer.start()
