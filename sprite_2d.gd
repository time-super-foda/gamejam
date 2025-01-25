extends Sprite2D

# func _ready() -> void:
	# self.scale.x = 0.1

func _process(_delta: float) -> void:
	var score = get_parent().get_parent().get_parent().Score
	self.scale.x = (score[0] * 4) / 10
	print(self.scale.x)
	# var formatted_lifepoints = lifepoints *
	# 0.1 - 0.85
