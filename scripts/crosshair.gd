extends Area2D

@export var player : Area2D
var viewport_x_offset;
var viewport_y_offset;

func _ready() -> void:
	viewport_x_offset = get_viewport_rect().size.x / 2;
	viewport_y_offset = get_viewport_rect().size.y / 2;

func _process(delta: float) -> void:
	position.x = get_viewport().get_mouse_position().x - viewport_x_offset + player.position.x
	position.y = get_viewport().get_mouse_position().y - viewport_y_offset + player.position.y
