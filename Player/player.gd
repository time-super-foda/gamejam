extends CharacterBody2D


@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var player_bubble: Sprite2D = player_sprite.get_child(0)
@onready var bubble = preload("res://Player/bubble.tscn")
@onready var bubble2 = preload("res://Player/bubble.tscn")

@export var enable_bubble_upgrade = false
@export var enable_jump_upgrade = false
@export var enable_umbrella_upgrade = false

const PLAYER_NAME = "player1"
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var has_air_jump = false
var is_attacking = false
var is_bubbled = false

var player_timer = 0
var bubble_mult = 1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if enable_umbrella_upgrade:
			velocity += (get_gravity() * delta) * 0.60
		else:
			velocity += get_gravity() * delta

	if velocity.x == 0.0 and velocity.y == 0.0 and !is_attacking:
		player_sprite.play("idle")

	if is_bubbled:
		bubbled_player()
	else:
		moving_player()


func moving_player():
	# Handle refilling the double jump if the player has the upgrade.
	if enable_jump_upgrade and is_on_floor():
		has_air_jump = true

	# Handle jump.
	if Input.is_action_just_pressed("player1_jump"):
		jump_handling()

	# Get the input direction and handle the movement/deceleration.
	var player_direction := Input.get_axis("player1_walk_left", "player1_walk_right")
	if Input.is_action_just_pressed("player1_walk_left") or Input.is_action_just_pressed("player1_walk_right"):
		player_sprite.play("walk")
	movement_handling(player_direction)

	# Handle shotting the bubbles.
	if Input.is_action_just_pressed("player1_shoot"):
		player_sprite.play("attack")
		shoot_handling(enable_bubble_upgrade)
	
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
	else:
		# Stops the player and switches to the idle animation.
		velocity.x = move_toward(velocity.x, 0, SPEED)


func shoot_handling(upgrade: bool):
	is_attacking = true
	
	# Creates a bubble instance and binds it to the scene
	var bubble_instance1 = bubble.instantiate()
	get_parent().add_child(bubble_instance1)
	
	var bubble_spawn = $BubblerSpawnPoint.global_position
	var bubble_direction = -1.0 if player_sprite.flip_h == false else 1.0

	# Changes the position of the bubble to the right spawnpoint
	bubble_instance1.global_position = bubble_spawn

	bubble_instance1.direction = bubble_direction
	bubble_instance1.player_origin = "player1"

	# Creates the second bubble instance if the player has the upgrade
	if upgrade:
		var bubble_instance2 = bubble2.instantiate()
		get_parent().add_child(bubble_instance2)

		bubble_instance2.global_position = bubble_spawn - Vector2(10 * -bubble_direction, 15)

		bubble_instance2.direction = bubble_direction
		bubble_instance2.player_origin = "player1"
	is_attacking = false


func bubbled_player():
	player_bubble.visible = true
	velocity.x = 0
	velocity.y = -50
	
	print("Counter: ", player_timer)

	if Input.is_action_just_pressed("player1_jump") or \
	Input.is_action_just_pressed("player1_walk_left") or \
	Input.is_action_just_pressed("player1_walk_left") or \
	Input.is_action_just_pressed("player1_shoot"):
		player_timer -= 1

	if player_timer == 0:
		bubble_mult += 1
		is_bubbled = false
		player_bubble.visible = false

	move_and_slide()


func _on_player_hurtbox_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		var shooter = area.get_parent().get_player_origin()

		if shooter != PLAYER_NAME:
			player_timer = 5 * bubble_mult
			is_bubbled = true
			print(PLAYER_NAME+ ": HIT from " + shooter)
