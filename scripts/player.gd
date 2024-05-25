extends CharacterBody2D


const SPEED = 150
const JUMP_VELOCITY = -200.0
const ACCELERATION = 20

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("Move_right"):
		print(velocity.x)
		velocity.x = min(velocity.x + ACCELERATION, SPEED)
	elif Input.is_action_pressed("Move_left"):
		print(velocity.x)
		velocity.x = max(velocity.x - ACCELERATION, -SPEED)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.1)
	move_and_slide()
	
