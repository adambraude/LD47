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
	
func new_game():
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_StartTimer_timeout():
	$MobTimer.start()


func _on_MobTimer_timeout():
	#Choose a spawn location in the acceptable range
#	var spawnxLeft = 150
#	var spawnxRight = 1800
#	var spawnyUp = 50
#	var spawnyDown = 400
#
#	var spawnWidth = spawnxRight - spawnxLeft
#	var spawnHeight = spawnyDown - spawnyUp
#
#	var spawn = Vector2()
#	var xLocation
#	var yLocation
	
	var bat = BatEnemy.instance()
	add_child(bat)
	
	bat.spawn.x = (randf()*bat.spawnWidth + bat.spawnxLeft)
	bat.spawn.y = (randf()*bat.spawnHeight + bat.spawnyUp)
	
	bat.position.x = bat.spawn.x
	bat.position.y = bat.spawn.y
