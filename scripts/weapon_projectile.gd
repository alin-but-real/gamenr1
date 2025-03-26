extends Node2D
var projectile = preload("res://scenes/projectile.tscn")

func _ready():
	var parent = get_parent()
	parent.fire_weapon.connect(_on_fire_weapon)

func _on_fire_weapon():
	var instance = projectile.instantiate()
	add_child(instance)
	
	
