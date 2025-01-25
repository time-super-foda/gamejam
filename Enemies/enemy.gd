extends RigidBody2D

@export var Player: CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Player:
		print(Player.position)
		var direction = (Player.position - position).normalized()
		apply_central_force(direction)
	else:
		print('no player')
