extends Area2D

signal hit

export var speed = 600 # speed of the car
var screen_size

# Declare member variables here.
var leftBound = .15 #The left boundary of where the car can move
var rightBound = .84 # The right boundary of where the car can move

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#re-enable these when bosses die
	$Rockets.hide()
	$Plasma.hide()
	$Rockets.set_process(false)
	$Plasma.set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2() # Player's movement vector
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	else:
		if Input.is_key_pressed(KEY_D):
			velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	else:
		if Input.is_key_pressed(KEY_A):
			velocity.x -= 1
	#if Input.is_action_pressed("ui_down"):
	#	velocity.y += 1
	#if Input.is_action_pressed("ui_up"):
	#	velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta
	position.x = clamp(position.x, screen_size.x*leftBound, screen_size.x*rightBound)
	#position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "Moving"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x > 0
	else:
		$AnimatedSprite.animation = "default"


func _on_Player_body_entered(_body):
	print("Player was hit")
	emit_signal("hit")
	$Health.take_damage(2)
	#$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_Player_area_entered(area):
	print("Player was hit")
	emit_signal("hit")
	$Health.take_damage(area.damage)
	if area.has_method("die"):
		area.die()
	pass # Replace with function body.
