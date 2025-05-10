extends Area2D

@export var bullet_speed = 1000
@export var bullet_lifetime = 2

func _ready() -> void:
	#print_debug("bullet fired")
	$Timer.wait_time = bullet_lifetime

func _process(delta: float) -> void:
	position.y += bullet_speed*-cos(rotation) * delta
	position.x += bullet_speed*sin(rotation) * delta

func _on_timer_timeout() -> void:
	queue_free()
