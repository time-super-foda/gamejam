extends Sprite2D


@export var direction = 0
@export var player_origin = ""


func _physics_process(delta: float) -> void:
	position.x += 5 * direction


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func get_player_origin() -> String:
	return player_origin
