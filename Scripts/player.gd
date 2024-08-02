extends CharacterBody2D

const SPEED = 550
const JUMP_POWER = -2000

const ACCELERATION = 50
const FRICTION = 70

const GRAVITY = 120

const MAX_JUMPS = 2
var current_jumps = 1

func _physics_process(delta):
	var input_direction: Vector2 = input()
	
	if input_direction != Vector2.ZERO:
		accelerate(input_direction)
		#play_animation()
	else:
		add_friction()
		#play_animation
	player_movement()
	jump()

func input() -> Vector2:
	var input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_axis("ui_left", "ui_right")
	input_direction = input_direction.normalized()
	return input_direction

func accelerate(direction):
	velocity = velocity.move_toward(SPEED * direction, ACCELERATION)

func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION)

func player_movement():
	move_and_slide()

func jump():
	if Input.is_action_just_pressed("ui_up"):
		if current_jumps < MAX_JUMPS:
			velocity.y = JUMP_POWER
			current_jumps += 1
	else:
		velocity.y+= GRAVITY
	
	if is_on_floor():
		current_jumps = 1
