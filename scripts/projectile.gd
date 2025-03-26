extends Area2D

func _ready() -> void:
	print_debug("bullet fired")

func _on_timer_timeout() -> void:
	queue_free()
