extends CharacterBody3D

@export var speed : float = 5.0
@export var jump_velocity : float = 9.0
@export var gravity : float = 20.0
@export var jump_cut_multiplier : float = 0.6

var is_jumping : bool = false

func _physics_process(delta):
	var input_dir = Vector2.ZERO
	input_dir.x = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")
	input_dir = input_dir.normalized()
	
	velocity.x = input_dir.x * speed
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0
		is_jumping = false
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		is_jumping = true
	
	if Input.is_action_just_released("ui_accept") and is_jumping and velocity.y > 0:
		velocity.y *= jump_cut_multiplier
		is_jumping = false
	move_and_slide()
