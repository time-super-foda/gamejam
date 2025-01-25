extends CharacterBody2D
@onready var player_sprite: AnimatedSprite2D = $PlayerSprite



const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var AIR_JUMP = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if (velocity.x > 1 || velocity.x < -1):
		player_sprite.animation = "walk"
	else:
		player_sprite.animation = "idle"

	# Handle jump.
	if Input.is_action_just_pressed("player2_jump") and is_on_floor():
		jump_handling()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("player2_walk_left", "player2_walk_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x< 0:
			player_sprite.flip_h = false
		if velocity.x>0:
			player_sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func jump_handling():
	# Regular jumping.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

	else:
		# Air jumping if the player has a jump left.
		if AIR_JUMP:
			velocity.y = JUMP_VELOCITY - 200.0
			AIR_JUMP = false
