extends Node2D

##This should refer to the scene of the projectile this fires.
@export var projectile: PackedScene
##This is the time in between firing a projectile, in seconds.
@export var rate_of_fire : float = 0.5


#used to refer where the bullet should start position/rotation at
var muzzle

#used to link the signals
var weapon_slot

#used to refer who to parent the bullet to
var main_node

#used to refer to the timer so we don't spam it
var timer

func _ready():
	#this section ties the code together for firing the weapons to the weapon's slot, and position data
	weapon_slot = get_parent()
	weapon_slot.fire_weapon.connect(_on_fire_weapon)
	muzzle = $Muzzle
	timer = $Timer
	main_node = get_node("/root/Main")
	
	timer.wait_time = rate_of_fire

func _on_fire_weapon():
	
	#if we are not on cooldown
	if (timer.is_stopped()):
		timer.start()
		var bullet_instance = projectile.instantiate()
		bullet_instance.rotation = muzzle.global_rotation
		bullet_instance.position = muzzle.global_position
		main_node.add_child(bullet_instance) #THIS IS REALLY FRAGILE IF WE MOVE MAIN.
