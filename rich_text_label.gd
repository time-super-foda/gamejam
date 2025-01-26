extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

	# Add text with inline styles
	$RichTextLabel.text = "[size=20]This is a larger text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	# Set default font size
	
