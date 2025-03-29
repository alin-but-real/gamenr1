extends Node2D
@export var projectile: PackedScene


#used to refer where the bullet should start position/rotation at
var muzzle

#used to link the signals
var weapon_slot

#used to refer who to parent the bullet to
var main_node

func _ready():
	#this section ties the code together for firing the weapons to the weapon's slot, and position data
	weapon_slot = get_parent()
	weapon_slot.fire_weapon.connect(_on_fire_weapon)
	muzzle = $Muzzle
	main_node = get_node("/root/Main")

func _on_fire_weapon():
	var bullet_instance = projectile.instantiate()
	bullet_instance.rotation = muzzle.global_rotation
	bullet_instance.position = muzzle.global_position
	main_node.add_child(bullet_instance) #THIS IS REALLY FRAGILE IF WE MOVE MAIN.
	
	
	
