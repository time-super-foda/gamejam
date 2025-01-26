extends CharacterBody2D


@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var bubble = preload("res://Player/bubble.tscn")

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var enable_bubble_upgrade = false
@export var enable_jump_upgrade = false
@export var enable_umbrella_upgrade = false

var has_air_jump = false
var bubble_instance


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if velocity.x == 0.0 and is_on_floor():
		player_sprite.play("idle")

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

	# Handle shotting the bubbles.
	if Input.is_action_just_pressed("player1_shoot"):
		shoot_handling()


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
		# Stops the player and switches to the idle animation.
		velocity.x = move_toward(velocity.x, 0, SPEED)


func shoot_handling():
	# Creates a bubble instance and binds it to the scene
	bubble_instance = bubble.instantiate()
	get_parent().add_child(bubble_instance)
	
	# Changes the position of the bubble to the right spawnpoint
	bubble_instance.global_position = $BubblerSpawnPoint.global_position
	
	bubble_instance.direction = -1.0 if player_sprite.flip_h == false else 1.0
	bubble_instance.player_origin = "player2"
