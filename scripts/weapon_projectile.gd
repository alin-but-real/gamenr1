extends Node2D
@export var projectile: PackedScene


func _ready():
	var parent = get_parent()
	parent.fire_weapon.connect(_on_fire_weapon)

func _on_fire_weapon():
	var bullet_instance = projectile.instantiate()
	get_node("Main").add_child(bullet_instance) #THIS IS BUGGED. GET_NODE NEEDS TO REFER TO THE WORLD, THEN THIS WORKS
	
	
	
