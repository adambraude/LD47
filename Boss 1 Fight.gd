extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Time_until_Boss_timeout():
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").removeAndStopAll()
	
	# Method to make boss screen appear here
	$BossScreenTimer.start()

func _on_BossScreenTimer_timeout():
	# Remove boss screen here
	# Spawn boss code here
	pass # Replace with function body.
