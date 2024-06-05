extends CharacterBody2D


@export var SPEED = 150.0
@export var JUMP_VELOCITY = -200
@export var ACCELERATION = 20.0
@export var PUSH = 20
@export var is_on_ladder = false
@export var is_inside_checkpoint = false
@export var last_saved_place_x = 35
@export var last_saved_place_y = 60

@onready var animated_sprite = $AnimatedSprite2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and not is_on_ladder:
		velocity.y += gravity * delta
	
	# Working Checkpoint
	if is_inside_checkpoint and Input.is_action_just_pressed("Save"):
		last_saved_place_x = position.x
		last_saved_place_y = position.y
		print("game saved")
		is_inside_checkpoint = false
		
	# Restarting from last checkpoint
	if Input.is_action_just_pressed("Restart"):
		position = Vector2(last_saved_place_x, last_saved_place_y)
	
	# Detect collisions with Movable Object
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is MovableBody:
			collider.apply_central_impulse(-collision.get_normal() * PUSH)
			
	# Detect if there is any ladder
	if (is_on_ladder):
		velocity.y = 0
		if Input.is_action_pressed("Up"):
			velocity.y = -50
		elif Input.is_action_pressed("Down"):
			velocity.y = 50

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and (is_on_floor() or is_on_ladder):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_pressed("Move_right"):
		velocity.x = min(velocity.x + ACCELERATION, SPEED)
		animated_sprite.flip_h = false
	elif Input.is_action_pressed("Move_left"):
		velocity.x = max(velocity.x - ACCELERATION, -SPEED)
		animated_sprite.flip_h = true
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.2)
	
	# Playing player animations
	if is_on_ladder and Input.is_action_pressed("Is_climbing"):
		animated_sprite.play("Climb")
	elif is_on_ladder:
		animated_sprite.play("Climb_idle")
	elif not is_on_floor():
		animated_sprite.play("Jump")
	elif velocity.x != 0 and not is_on_ladder:
		animated_sprite.play("Run")
	else:
		animated_sprite.play("Idle")
		
	move_and_slide()
