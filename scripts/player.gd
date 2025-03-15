extends Area2D
@export var move_speed = 1000
@export var move_accel = 1

##This is the current turn speed of the player. It glides towards 0, and caps at max_turn_speed
var current_turn_speed = 0;



##This is the maximum turn speed of the player, measured in Degrees per Second. 
@export var mech_max_turn_speed = 360;

##This is the speed the mech will start turning at. UNIT: Degrees/Second
@export var mech_turn_speed = 1;

##This is by how much the mech will start accelerating its turning. UNIT: Degrees/Second
@export var mech_turn_acceleration = 1

##This is the speed the mech will deccelerate and try to stop turning at. UNIT: Degrees/Second
@export var mech_turn_decceleration = 1;



func _ready() -> void:
	print_debug("player awake")

func _process(delta: float) -> void:
	
	#MOVEMENT HANDLING - UNFINISHED
	var velocity = Vector2.ZERO # The player's movement vector.
	
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
	var turn_direction: int = 0 # LEFT IS -1, RIGHT IS 1
	
	
	if Input.is_action_pressed("turn_left"):
		turn_direction += -1;
		

	if Input.is_action_pressed("turn_right"):
		turn_direction += 1;
		
	
	
	
	if (abs(current_turn_speed) <= mech_turn_decceleration): #makes the deccelleration stop the mech once it gets close enough to 0
		current_turn_speed = 0
	elif (current_turn_speed < 0): 
		current_turn_speed += mech_turn_decceleration
	else: #(if current_turn_speed > 0):
		current_turn_speed -= mech_turn_decceleration
	
	current_turn_speed += (turn_direction * (mech_turn_speed + mech_turn_decceleration))
	
	current_turn_speed = clamp(current_turn_speed, -mech_max_turn_speed, mech_max_turn_speed)
	
	current_turn_speed += (turn_direction * mech_turn_speed)

	rotation_degrees += (current_turn_speed) * delta;
