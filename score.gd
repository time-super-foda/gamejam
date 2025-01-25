extends Label

@onready var score = get_parent().get_parent().Score

func _process(_delta: float) -> void:
	text = str(score[0]) + " X " + str(score[1])
