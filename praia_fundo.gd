extends Sprite2D

@export var bounce_height: float = 5.0 # How high they move (in pixels)
@export var bounce_speed: float = 1.0 # How fast they bounce
@export var offset_phase: float = 1.0 # Phase difference between buttons

var original_position: float

func _ready():
	# Store original positions
	original_position = self.position.y

func _process(_delta):
	var time = Time.get_ticks_msec() / 1000.0 # Get time in seconds

	# Animate play
	self.position.y = original_position + sin(time * bounce_speed) * bounce_height
