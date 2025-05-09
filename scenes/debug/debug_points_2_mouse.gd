extends Node2D

var crosshair : Node

var crosshair_position : Vector2

func _ready() -> void:
	crosshair = get_node("/root/Main/Crosshair")
	
	
func _process(delta: float) -> void:
	
	#I HAVE NO IDEA WHY THIS WORKS. DON'T TOUCH IT
	# rotation = (-global_position).angle_to(global_position - crosshair.global_position)  + PI / 1.5
	rotation = global_position.angle_to_point(crosshair.global_position) + PI / 2
