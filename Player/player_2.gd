extends CharacterBody2D


@onready var player_sprite: AnimatedSprite2D = $PlayerSprite

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var enable_jump_upgrade = true
var has_air_jump = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle refilling the double jump if the player has the upgrade.
	if enable_jump_upgrade and is_on_floor():
		has_air_jump = true

	# Handle jump.
	if Input.is_action_just_pressed("player2_jump"):
		jump_handling()

	# Get the input direction and handle the movement/deceleration.
	var player_direction := Input.get_axis("player2_walk_left", "player2_walk_right")
	movement_handling(player_direction)

	move_and_slide()


func jump_handling():
	# Regular jumping.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

	elif enable_jump_upgrade:
		# Air jumping if the player has a jump left.
		if has_air_jump:
			velocity.y = JUMP_VELOCITY - 200.0
			has_air_jump = false


func movement_handling(direction: float):
	if direction:
		# Inverts the sprites when going to the left.
		if direction == -1.0:
			player_sprite.flip_h = false

		# 'Un-Inverts' the sprites when going to the right.
		elif direction == 1.0:
			player_sprite.flip_h = true

		velocity.x = direction * SPEED
		player_sprite.play("walk")
	else:
		# Stops the player ande switches to the idle animation.
		velocity.x = move_toward(velocity.x, 0, SPEED)
		player_sprite.play("idle")
