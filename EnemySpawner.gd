extends Node

export (PackedScene) var BatEnemy
export (PackedScene) var CrabEnemy
export (PackedScene) var WheelEnemy

export var difficulty = 0

# Declare member variables here. Examples:
var SPAWNXLEFT = 225
var SPAWNXRIGHT = 1700
var SPAWNYUP = 100
var SPAWNYDOWN = 400

# Finds range of acceptable spawns
var spawnWidth = SPAWNXRIGHT - SPAWNXLEFT
var spawnHeight = SPAWNYDOWN - SPAWNYUP

var spawn = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func getSpawn():
	# Find a spawning location that is allowed by the bat
	spawn.x = (randf()*spawnWidth + SPAWNXLEFT)
	spawn.y = (randf()*spawnHeight + SPAWNYUP)
	return spawn

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func startSpawns():
	if (difficulty == 0):
		$BatEnemyTimer.wait_time = 1.5
		$CrabEnemyTimer.wait_time = 8
		$BatEnemyTimer.start()
		$CrabEnemyTimer.start(15)
	if (difficulty == 1):
		$BatEnemyTimer.wait_time = 1
		$CrabEnemyTimer.wait_time = 5
		$WheelEnemyTimer.wait_time = 10
		$BatEnemyTimer.start()
		$CrabEnemyTimer.start()
		$WheelEnemyTimer.start(30)
	if (difficulty == 2):
		$BatEnemyTimer.wait_time = 0.75
		$CrabEnemyTimer.wait_time = 3
		$WheelEnemyTimer.wait_time = 6
		$BatEnemyTimer.start()
		$CrabEnemyTimer.start()
		$WheelEnemyTimer.start()

func removeAndStopAll():
	$BatEnemyTimer.stop()
	$CrabEnemyTimer.stop()
	$WheelEnemyTimer.stop()
	get_tree().call_group("crabs", "queue_free")
	get_tree().call_group("bats", "queue_free")
	get_tree().call_group("wheels", "queue_free")
	get_tree().call_group("fireballs", "queue_free")

func _on_StartTimer_timeout():
	startSpawns()


func _on_BatEnemyTimer_timeout():
	# Add a new Bat instance
	var bat = BatEnemy.instance()
	add_child(bat)
	
	# Find a spawning location that is allowed by the bat, and sets position to it
	var spawnin = getSpawn()
	bat.position = spawnin
	
	# should handle the bat moving position. Currently broken
	#bat.spawn(getSpawn())


func _on_CrabEnemyTimer_timeout():
	var crab = CrabEnemy.instance()
	add_child(crab)
	
	var spawnin = getSpawn()
	crab.position = spawn
	
func _on_WheelEnemyTimer_timeout():
	var wheel = WheelEnemy.instance()
	add_child(wheel)
	
	var spawnin = getSpawn()
	wheel.position = spawn
