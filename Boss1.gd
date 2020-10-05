extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var explosionScene = load("res://Explosion.tscn")
var fireballScene = load("res://Fireball.tscn")
var fireballGScene = load("res://FireballGravy.tscn")
var batScene = load("res://BatEnemy.tscn")

export var gfireballsOn = false

func bats():
	var bat = batScene.instance()
	get_node("/root/").add_child(bat)
	bat.position = Vector2(rand_range(225, 700), rand_range(100, 400))
	bat = batScene.instance()
	get_node("/root/").add_child(bat)
	bat.position = Vector2(rand_range(1300, 1700), rand_range(100, 400))
	
func spreadShot():
	var localPlayer = get_tree().get_root().get_node("Main").find_node("Player")
	for i in range(-2, 3, 1):
		var fireball = fireballScene.instance()
		fireball.position = self.global_position + Vector2(0, -80)
		var attackDir = localPlayer.position - fireball.position
		var attackSpeed = 500
		var normAttack = attackDir.normalized()
		fireball.velocity = (normAttack*attackSpeed).length()
		fireball.direction = (normAttack*attackSpeed).angle() + PI/8*i
		get_node("/root/").add_child(fireball)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Idle")
	
	var player_health = $Health
	var healthbar = $HealthBar
	
	player_health.connect("changed", healthbar, "set_value")
	player_health.connect("max_changed", healthbar, "set_max")
	player_health.initialize()
	$AnimationPlayer.play("AttackPattern")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var accuracy = 8
	if(gfireballsOn and $gfireballstimer.time_left == 0):
		  var fb = fireballGScene.instance()
		  fb.position = self.global_position + Vector2(0, -80)
		  fb.direction = PI*3/2
		  fb.velocity = 400
		  fb.direction += rand_range(-PI/accuracy, PI/accuracy)
		  fb.get_node("Gravy").pull *= rand_range(2, 10)
		  get_node("/root/").add_child(fb)
		  $gfireballstimer.start()
	pass

func _on_Boss1_area_entered(area):
	if area == null:
		return
	$Health.take_damage(area.damage)
	if area.has_method("die"):
		area.die()


func _on_Health_depleted():
	queue_free()
	for i in range(0, 100):
		var explosion = explosionScene.instance()
		if randi() % 2 == 0:
			explosion.play("explosion_1")
		else:
			explosion.play("explosion_2")
		explosion.position = self.global_position
		explosion.position += Vector2(rand_range(-600, 600), rand_range(-600, 600))
		get_node("/root/").add_child(explosion)
	get_tree().call_group("bats", "queue_free")
	get_tree().call_group("wheels", "queue_free")
	get_tree().call_group("fireballs", "queue_free")
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Health").set_current(999)
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Plasma").show()
	get_tree().get_root().get_node("Main").find_node("Player").find_node("Plasma").set_process(true)
	get_tree().get_root().get_node("Main").find_node("EnemySpawner").difficulty = 1
	get_tree().get_root().get_node("Main").find_node("Boss 2 Fight").startBossTimer()
