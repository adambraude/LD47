extends ParallaxBackground


# Declare member variables here. Examples:
# var a = 2
export var speed = 10
#blablabla

# Called when the node enters the scene tree for the first time.
func _ready():
	$Road/TrackAnimator.play("Road")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset[0] += speed*delta
	pass
