extends Area2D


var explosionScene = load("res://Explosion.tscn")
var fireballScene = load("res://Fireball.tscn")
var fireballGScene = load("res://FireballGravy.tscn")
var fireballNScene = load("res://Fireneedle.tscn")
var fireballPScene = load("res://Purple.tscn")
var crabScene = load("res://CrabEnemy.tscn")

var play = true

export var gfireballsOn = false
export var rain = false

#func bats():
#	var bat = batScene.instance()
#	get_node("/root/").add_child(bat)
#	bat.position = Vector2(rand_range(225, 700), rand_range(100, 400))
#	bat = batScene.instance()
#	get_node("/root/").add_child(bat)
#	bat.position = Vector2(rand_range(1300, 1700), rand_range(100, 400))
	
func spreadShot():
	var localPlayer = get_tree().get_root().get_node("Main").find_node("Player")
	for i in range(-2, 3, 1):
		var fireball = fireballPScene.instance()
		fireball.position = self.global_position + Vector2(0, -100)
		var attackDir = localPlayer.position - fireball.position
		var attackSpeed = 700
		var normAttack = attackDir.normalized()
		fireball.velocity = (normAttack*attackSpeed).length()
		fireball.direction = (normAttack*attackSpeed).angle() + PI/3*i
		get_node("/root/").add_child(fireball)

# Called when the node enters the scene tree for the first time.
func _ready():
	play = true
	
	$AnimatedSprite.play("Idle")
	$AnimationPlayer.play("Pattern")
	
	var player_health = $Health
	var healthbar = $HealthBar
	
	player_health.connect("changed", healthbar, "set_value")
	player_health.connect("max_changed", healthbar, "set_max")
	player_health.initialize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var accuracy = 8
	if(gfireballsOn and $gfireballstimer.time_left == 0):
		  var fb = fireballNScene.instance()
		  fb.position = self.global_position + Vector2(0, -100)
		  fb.direction = PI*1/2
		  fb.velocity = 700
		  fb.direction += rand_range(-PI/accuracy, PI/accuracy)
		  get_node("/root/").add_child(fb)
		  $gfireballstimer.start()
	pass
	if(rain and $raintimer.time_left == 0):
		  var fb = fireballScene.instance()
		  fb.position = Vector2(rand_range(0, get_viewport().size.x), 0)
		  fb.direction = PI*1/2
		  fb.velocity = 300
		  get_node("/root/").add_child(fb)
		  $raintimer.start()
	pass
	if(rain and $shottimer.time_left == 0):
		  var localPlayer = get_tree().get_root().get_node("Main").find_node("Player")
		  var fireball = fireballPScene.instance()
		  fireball.position = self.global_position + Vector2(0, -100)
		  var attackDir = localPlayer.position - fireball.position
		  var attackSpeed = 500
		  var normAttack = attackDir.normalized()
		  fireball.velocity = (normAttack*attackSpeed).length()
		  fireball.direction = (normAttack*attackSpeed).angle()
		  get_node("/root/").add_child(fireball)
		  $shottimer.start()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Boss2_area_entered(area):
	if area == null:
		return
	$Health.take_damage(area.damage)
	if area.has_method("die"):
		area.die()


func _on_Health_depleted():
	play = false
	$BossMusic.stop()
	queue_free()
	for i in range(0, 100):
		var explosion = explosionScene.instance()
		if randi() % 2 == 0:
			explosion.play("explosion_1")
		else:
			explosion.play("explosion_2")
		explosion.position = self.global_position
		explosion.position += Vector2(rand_range(-500, 500), rand_range(-500, 500))
		get_node("/root/").add_child(explosion)
	get_tree().call_group("bats", "queue_free")
	get_tree().call_group("wheels", "queue_free")
	get_tree().call_group("fireballs", "queue_free")
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Health").set_current(999)
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Rockets").show()
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Rockets").set_process(true)
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").difficulty = 2
	get_tree().get_root().get_node("Main").find_node("Boss 3 Fight").startBossTimer()


func _on_BossMusic_finished():
	if play == true:
		$BossMusic.play(0)
