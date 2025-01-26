extends Camera2D

@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0
@export var zoom_lerp_speed: float = 10.0
@export var position_lerp_speed: float = 10.0
@export var screen_margin: float = 500.0
@export var player1_path: NodePath
@export var player2_path: NodePath

var _player1: Node2D
var _player2: Node2D

func _ready():
    _player1 = get_node(player1_path)
    _player2 = get_node(player2_path)

func _process(delta):
    if !_player1 || !_player2: return

    var viewport = get_viewport_rect().size
    var aspect_ratio = viewport.x / viewport.y

    var world_margin = screen_margin / zoom.x

    var distance = _player1.global_position.distance_to(_player2.global_position)
    var framed_distance = distance + 2 * world_margin

    var target_zoom_x = viewport.x / framed_distance
    var target_zoom_y = viewport.y / (framed_distance * aspect_ratio) + 50
    var target_zoom = min(target_zoom_x, target_zoom_y)

    target_zoom = clamp(target_zoom, min_zoom, max_zoom)
    zoom = zoom.lerp(Vector2.ONE * target_zoom, zoom_lerp_speed * delta)

    var midpoint = (_player1.global_position + _player2.global_position) / 2.0
    global_position = global_position.lerp(midpoint, position_lerp_speed * delta)
