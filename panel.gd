extends Panel

@export var bounce_height: float = 10.0 # How high they move (in pixels)
@export var bounce_speed: float = 3.0 # How fast they bounce
@export var offset_phase: float = 1.0 # Phase difference between buttons

var original_positions: Dictionary = {}

func _ready():
	# Store original positions
	original_positions[$play.name] = $play.position.y
	original_positions[$credits.name] = $credits.position.y

func _process(_delta):
	var time = Time.get_ticks_msec() / 1000.0 # Get time in seconds

	# Animate play
	$play.position.y = original_positions[$play.name] + sin(time * bounce_speed) * bounce_height

	# Animate credits with phase offset
	$credits.position.y = original_positions[$credits.name] + sin(time * bounce_speed + offset_phase) * bounce_height
