extends Area2D

##This is the maximum move speed of the player.
@export var move_speed_max = 2000
##This is the speed the mech will move at base, without any acceleration.
@export var move_speed = 1000
##This is how much the mech will accelerate by each frame.
@export var move_accel = 1
##This is how much the mech will deccelerate by each frame, when not holding down any movement key.
@export var move_decceleration = 1


##This is the current turn speed of the player. It glides towards 0, and caps at max_turn_speed
var current_turn_speed = 0;
var current_move_speed = 0;



##This is the maximum turn speed of the player, measured in Degrees per Second. 
@export var mech_max_turn_speed = 360;

##This is the speed the mech will start turning at. UNIT: Degrees/Second
@export var mech_turn_speed = 1;

##This is by how much the mech will start accelerating its turning. UNIT: Degrees/Second
@export var mech_turn_acceleration = 1;

##This is the speed the mech will deccelerate and try to stop turning at. UNIT: Degrees/Second
@export var mech_turn_decceleration = 1;



func _ready() -> void:
	print_debug("player awake")

func _process(delta: float) -> void:

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
	
	#first, add the turning to the current turn speed...
	current_turn_speed += (turn_direction * (mech_turn_speed + mech_turn_decceleration))
	#second, clamp the value so it doesn't turn too fast
	current_turn_speed = clamp(current_turn_speed, -mech_max_turn_speed, mech_max_turn_speed)
	
	rotation_degrees += (current_turn_speed) * delta;
	
	
	#MOVEMENT HANDLING - UNFINISHED
	var direction = 0 # The player's movement vector. describes wether he's moving forward or not +1 forward, -1 backward
	
	if Input.is_action_pressed("move_forward"):
		direction += 1
	if Input.is_action_pressed("move_backward"):
		direction -= 1
	
	if (abs(current_move_speed) <= move_decceleration): #makes the deccelleration stop the mech once it gets close enough to 0
		current_move_speed = 0
	elif (current_move_speed < 0): 
		current_move_speed += move_decceleration
	else:
		current_move_speed -= move_decceleration
	
	current_move_speed += direction * (move_speed + move_decceleration)
	
	current_move_speed = clamp(current_move_speed, -move_speed_max, move_speed_max)
	
	print_debug(current_move_speed)
	
	position.y += current_move_speed*-cos(rotation) * delta
	position.x += current_move_speed*sin(rotation) * delta
