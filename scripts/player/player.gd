extends Area2D

##This is the maximum move speed of the player.
@export var move_speed_max = 1000
##This is the speed the mech will move at base, when holding down movement keys, without any acceleration.
@export var move_speed = 100
##This is the percent by which the mech will accelerate towards its max speed, each frame. (EX: if this is set to 0.10, it will accelerate to 100% in 10 frames.)
@export var move_accel = 0.10
##This is the percent by which the mech will decellerate towards 0, when not holding down any movement key. (EX: if this is set to 0.2, the mech will reach a full stop (from full speed) in 5 frames)
@export var move_decceleration = 0.01

##This flag dictates if the player should turn towards the crosshair automatically. This should be toggled on/off with ingame controls.
@export var turn_towards_cursor : bool = true

##This is the cooldown before the player is allowed to dash again. I don't know what this is even measured in.
# @export var dash_cooldown = 5000
##This is the speed the player will gain when dashing. It's also related to the time it takes to dash and is jank af.
# @export var dash_speed = 1000;
##This is the decceleration the player will experience each frame after a dash. So if speed = 1000, decel = 200, it's 5 frames of dash.
# @export var dash_decceleration = 20

##This is the current turn speed of the player. It glides towards 0, and caps at max_turn_speed
var current_turn_speed = 0;
##This is the current move speed of the player. It glides towards 0, and caps at max_move_speed
var current_move_speed = 0;
##This is the current dash cooldown of the player. It should be 0 most of the time, and sets to dash_cooldown when dashing.
# var current_dash_cooldown = 0;
##This is the current dash speed of the player. It should be 0 most of the time.
# var current_dash_speed = 0;

# var dash_direction

signal fire_weapon_0
signal fire_weapon_1
signal fire_weapon_2


##This is the maximum turn speed of the player, measured in Degrees per Second. 
@export var mech_max_turn_speed = 360;

##This is the speed the mech will start turning at. UNIT: Degrees/Second
@export var mech_turn_speed = 1;

##This is by how much the mech will start accelerating its turning. UNIT: Degrees/Second
@export var mech_turn_acceleration = 1;

##This is the speed the mech will deccelerate and try to stop turning at. UNIT: Degrees/Second
@export var mech_turn_decceleration = 1;

var velocity_vector : Vector2 = Vector2.ZERO

var crosshair : Node



func _ready() -> void:
	print_debug("player awake")
	crosshair = get_node("/root/Main/Crosshair")

func _process(delta: float) -> void:
	
	
	if Input.is_action_just_pressed("toggle_mouse_aim"):
		if (turn_towards_cursor):
			turn_towards_cursor = false;
		else:
			turn_towards_cursor = true;
	
	#TURN HANDLING
	
	var turn_direction: int = 0 # LEFT IS -1, RIGHT IS 1
	
	
	
	if (turn_towards_cursor):
		var angle_to_cursor = (rotation - global_position.angle_to_point(crosshair.global_position) - PI / 2)
		print_debug(angle_to_cursor)
		if (angle_to_cursor < -PI/20):
			turn_direction += 1;
		elif (angle_to_cursor > PI/20):
			turn_direction += -1;
	
	if Input.is_action_pressed("turn_left"):
		turn_direction = -1;
	if Input.is_action_pressed("turn_right"):
		turn_direction = 1;
		
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
	#var move_direction = 0 # The player's movement vector. describes wether he's moving forward or not +1 forward, -1 backward
	
	#MOVEMENT VECTOR DESCRIBES THE "INTENTION" OF THE PLAYER TO MOVE
	#movement vector is measured from (-1,-1) to (+1,+1), describing north-west and south-east movement respectively
	
	#VELOCITY VECTOR DESCRIBES THE VELOCITY OF THE PLAYER RIGHT NOW
	#velocity vector ranges from (-1/-1) to (+1/+1), where 0 is static, and 1 is max speed in that direction
	
	var move_vector : Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("move_forward"):
		move_vector.y += -1
	if Input.is_action_pressed("move_backward"):
		move_vector.y += 1
	if Input.is_action_pressed("move_left"):
		move_vector.x += -1
	if Input.is_action_pressed("move_right"):
		move_vector.x += 1
	
	move_vector = move_vector.normalized()
	
	#now handling velocity vector
	
	#velocity_vector += (move_vector/100 * move_accel) 
	
	if (move_vector == Vector2.ZERO):
		if (velocity_vector.length() <= move_decceleration):
			velocity_vector = Vector2.ZERO
	else:
		velocity_vector += move_vector * (move_accel + move_decceleration)
		velocity_vector = velocity_vector.clamp(Vector2(-1,-1), Vector2(1,1))
	
	velocity_vector += -velocity_vector.normalized() * move_decceleration
	
	position.x += ((move_vector.x * move_speed) + (velocity_vector.x * move_speed_max)) * delta
	position.y += ((move_vector.y * move_speed) + (velocity_vector.y * move_speed_max)) * delta
	
	#DASH HANDLING - Q AND E
	
	#if (current_dash_cooldown == 0):
		#dash_direction = 0;
		#if Input.is_action_pressed("move_left"):
			#dash_direction += -1 #left is -1, right is +1
			#current_dash_cooldown = dash_cooldown
			#current_dash_speed = dash_direction * dash_speed
		#if Input.is_action_pressed("move_right"):
			#dash_direction += 1 #left is -1, right is +1
			#current_dash_cooldown = dash_cooldown
			#current_dash_speed = dash_direction * dash_speed
	#else:
		#current_dash_cooldown -= 20
		#position.y += current_dash_speed*-cos(rotation + deg_to_rad(90)) * delta
		#position.x += current_dash_speed*sin(rotation + deg_to_rad(90)) * delta
	#
	#
	#if (abs(current_dash_speed) <= dash_decceleration): #makes the deccelleration stop the mech once it gets close enough to 0
		#current_dash_speed = 0
	#elif (current_dash_speed < 0): 
		#current_dash_speed += dash_decceleration
	#else:
		#current_dash_speed -= dash_decceleration

	#WEAPON HANDLING
	
	if Input.is_action_pressed("fire_weapon_0"):
		fire_weapon_0.emit()
	if Input.is_action_pressed("fire_weapon_1"):
		fire_weapon_1.emit()
	if Input.is_action_pressed("fire_weapon_2"):
		fire_weapon_2.emit()

	
	
	
	
