extends Node2D

var crosshair : Node

func _ready() -> void:
	crosshair = get_node("/root/Main/Crosshair")
	
	
func _process(delta: float) -> void:
	rotation = global_position.angle_to_point(crosshair.global_position) + PI / 2
	
