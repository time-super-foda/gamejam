extends Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var lifepoints = get_parent().get_parent().get_parent().Player1_Health
	print(lifepoints)
