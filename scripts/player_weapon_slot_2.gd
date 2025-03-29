extends Node2D
signal fire_weapon

func _on_player_fire_weapon_2() -> void:
	fire_weapon.emit()
