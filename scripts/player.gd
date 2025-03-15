extends Area2D
@export var move_speed = 1000
@export var move_accel = 1
@export var turn_speed = 1
@export var turn_accel = 1
var screen_size
var current_turn_accel= 0
var current_move_accel= 0

func _ready() -> void:
	print_debug("player awake")
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	var turn = 0 # LEFT IS -1, RIGHT IS 1
	
	#MOVEMENT HANDLING - UNFINISHED
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_backward"):
		velocity.y += 1
	if Input.is_action_pressed("move_forward"):
		velocity.y -= 1
	if velocity.length() > 0: #make sure we dont move faster diagonally
		velocity = velocity.normalized() * move_speed
	position += velocity * delta # velocity just helps us move, this is actually what sets our position
	
	#TURN HANDLING
	if Input.is_action_pressed("turn_left"):
		turn = -1;
		current_turn_accel += turn_accel
		
	if Input.is_action_pressed("turn_right"):
		turn = 1;
		current_turn_accel += turn_accel
	
	print_debug(current_turn_accel)
	rotation += turn * turn_speed * current_turn_accel * delta;
