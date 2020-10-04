extends Node

export (PackedScene) var BatEnemy

# Declare member variables here. Examples:
#Choose a spawn location in the acceptable range
#var spawnxLeft = 150
#var spawnxRight = 1800
#var spawnyUp = 50
#var spawnyDown = 400
#
#var spawnWidth = spawnxRight - spawnxLeft
#var spawnHeight = spawnyDown - spawnyUp
#
#var spawn = Vector2()
#var xLocation
#var yLocation


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


func _on_StartTimer_timeout():
	$MobTimer.start()


func _on_MobTimer_timeout():
	# Add a new Bat instance
	var bat = BatEnemy.instance()
	add_child(bat)
	
	# Find a spawning location that is allowed by the bat
	var spawn = $EnemySpawner.getSpawn()
	
	# set location to viable location
	bat.position.x = spawn.x
	bat.position.y = spawn.y
