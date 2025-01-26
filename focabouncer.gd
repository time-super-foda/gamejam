extends Sprite2D

@export var bounce_speed: float = 3.0
@export var stretch_scale: float = 3.7
@export var squash_scale: float = 2.5
@export var stretch_y: float = 687.5
@export var squash_y: float = 726.0

var _base_scale: Vector2
var _time: float = 0.0

func _ready():
    _base_scale = scale

func _process(delta):
    _time += delta
    
    # Calculate bounce factor using sine wave (range -1 to 1)
    var bounce_factor = sin(_time * bounce_speed)
    
    # Convert to 0-1 range for lerp
    var t = (bounce_factor + 1.0) / 2.0
    
    # Animate position and scale
    position.y = lerp(stretch_y, squash_y, t)
    scale.y = lerp(stretch_scale, squash_scale, t)
    
    # Add horizontal compensation for better squash effect
    scale.x = lerp(_base_scale.x * 0.8, _base_scale.x * 1.2, t)