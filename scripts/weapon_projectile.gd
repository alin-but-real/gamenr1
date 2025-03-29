extends Node2D
@export var projectile: PackedScene

var player
var weapon_slot

func _ready():
	#this section ties the code together for firing the weapons to the weapon's slot, and position data
	weapon_slot = get_parent()
	weapon_slot.fire_weapon.connect(_on_fire_weapon)

func _on_fire_weapon():
	var bullet_instance = projectile.instantiate()
	bullet_instance.rotation = weapon_slot.global_rotation
	bullet_instance.position = weapon_slot.global_position
	get_node("/root/Main").add_child(bullet_instance) #THIS IS REALLY FRAGILE IF WE MOVE MAIN.
	
	
	
