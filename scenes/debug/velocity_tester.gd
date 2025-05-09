extends RichTextLabel

func _process(delta: float) -> void:
	text = str(get_parent().velocity_vector)
