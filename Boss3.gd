extends Area2D


export var rain = false
export var stream = false

var explosionScene = load("res://Explosion.tscn")
var fireballScene = load("res://Fireball.tscn")
var fireballGScene = load("res://FireballGravy.tscn")
var fireballNScene = load("res://Fireneedle.tscn")
var fireballPScene = load("res://Purple.tscn")
var laserScene = load("res://Laser.tscn")
var batScene = load("res://WheelEnemy.tscn")
var crabScene = load("res://CrabEnemy.tscn")

func crabs():
	var bat = crabScene.instance()
	get_node("/root/").add_child(bat)
	bat.position = Vector2(rand_range(225, 700), rand_range(100, 400))
	bat = crabScene.instance()
	get_node("/root/").add_child(bat)
	bat.position = Vector2(rand_range(1300, 1700), rand_range(100, 400))

func bats():
	var bat = batScene.instance()
	get_node("/root/").add_child(bat)
	bat.position = Vector2(rand_range(225, 700), rand_range(100, 400))
	bat = batScene.instance()
	get_node("/root/").add_child(bat)
	bat.position = Vector2(rand_range(1300, 1700), rand_range(100, 400))

func laserWings():
	for i in [PI - 0.3, PI - 0.4, PI - 0.5, PI - 0.6, PI + 0.3, PI + 0.4, PI + 0.5, PI + 0.6]:
		var laser = laserScene.instance()
		add_child(laser)
		laser.position = Vector2(0, -80)
		laser.rotate(i)
		
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

func laserPlayer():
	var localPlayer = get_tree().get_root().get_node("Main").find_node("Player")
	var laser = laserScene.instance()
	add_child(laser)
	laser.position = Vector2(0, -100)
	var attackDir = localPlayer.position - laser.global_position
	var normAttack = attackDir.normalized()
	laser.rotate(normAttack.angle()-PI/2)

func laserSpray():
	for i in range(-3, 4, 1):
		var localPlayer = get_tree().get_root().get_node("Main").find_node("Player")
		var laser = laserScene.instance()
		get_node("/root/").add_child(laser)
		laser.position = global_position + Vector2(0, -100)
		var attackDir = localPlayer.position - laser.global_position
		var normAttack = attackDir.normalized()
		laser.rotate(normAttack.angle()-PI/2 + i*PI/4)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("Idle")
	$AnimationPlayer.play("Pattern")
	
	var player_health = $Health
	var healthbar = $HealthBar
	
	player_health.connect("changed", healthbar, "set_value")
	player_health.connect("max_changed", healthbar, "set_max")
	player_health.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(rain and $raintimer.time_left == 0):
		  var fb = fireballScene.instance()
		  fb.position = Vector2(rand_range(0, get_viewport().size.x), 0)
		  fb.direction = PI*1/2
		  fb.velocity = 300
		  get_node("/root/").add_child(fb)
		  $raintimer.start()
	if(rain and $laserraintimer.time_left == 0):
		  var laser = laserScene.instance()
		  laser.position = Vector2(rand_range(0, get_viewport().size.x), 0)
		  get_node("/root/").add_child(laser)
		  $laserraintimer.start()
	if stream and $streamtime.time_left == 0:
		var localPlayer = get_tree().get_root().get_node("Main").find_node("Player")
		for i in range(-2, 3, 1):
			var fireball = fireballNScene.instance()
			fireball.position = self.global_position + Vector2(0, -100)
			var attackDir = localPlayer.position - fireball.position
			var attackSpeed = 500
			var normAttack = attackDir.normalized()
			fireball.velocity = (normAttack*attackSpeed).length()
			fireball.direction = (normAttack*attackSpeed).angle() + PI/3*i
			get_node("/root/").add_child(fireball)
			$streamtime.start()
	


func _on_Boss3_area_entered(area):
	if area == null:
		return
	$Health.take_damage(area.damage)
	if area.has_method("die"):
		area.die()


func _on_Health_depleted():
	queue_free()
	for i in range(0, 100):
		var explosion = explosionScene.instance()
		explosion.play("fireball")
		explosion.position = self.global_position
		explosion.position += Vector2(rand_range(-200, 200), rand_range(-200, 200))
		get_node("/root/").add_child(explosion)
	get_tree().change_scene("res://End of Game Screen.tscn")


func _on_AudioStreamPlayer_finished():
	$BossMusic.play(0)
