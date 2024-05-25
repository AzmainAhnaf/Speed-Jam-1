extends CharacterBody2D


const SPEED = 150
const JUMP_VELOCITY = -200.0
const ACCELERATION = 20
const PUSH = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Detect collisions with Movable Object
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is MovableBody:
			print("Working...")
			print(collision.get_normal())
			collider.apply_central_impulse(-collision.get_normal() * PUSH)
		else:
			print("gojo")

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("Move_right"):
		velocity.x = min(velocity.x + ACCELERATION, SPEED)
	elif Input.is_action_pressed("Move_left"):
		velocity.x = max(velocity.x - ACCELERATION, -SPEED)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.1)
	move_and_slide()
