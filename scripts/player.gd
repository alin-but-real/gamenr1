extends Area2D
@export var speed = 1000
var screen_size

func _ready() -> void:
	print_debug("player awake")
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0: #make sure we dont move faster diagonally
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
