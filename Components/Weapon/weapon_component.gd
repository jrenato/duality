extends Node
class_name WeaponComponent

@onready var projectiles: Node = %Projectiles
@onready var weapon_screen: WeaponScreenScene = %WeaponScreen

@export var spawn_position : Node2D
@export var available_projectiles : Array[ProjectileInfo]
@export var selected_projectile : int


func add_projectile(projectile_info : ProjectileInfo) -> void:
	if available_projectiles.size() == 0:
		available_projectiles.append(projectile_info)
		selected_projectile = 0
	else:
		available_projectiles[selected_projectile] = projectile_info
	weapon_screen.update_projectiles_slots(available_projectiles)


func shoot(direction : Vector2) -> void:
	if available_projectiles.size() >= selected_projectile + 1:
		var projectile_info : ProjectileInfo = available_projectiles[selected_projectile]
		var projectile_scene : PackedScene = projectile_info.projectile_scene
		var projectile : ProjectileScene = projectile_scene.instantiate()

		projectiles.add_child(projectile)

		projectile.global_position = spawn_position.global_position
		projectile.damage = projectile_info.damage
		projectile.damage_type = projectile_info.damage_type
		projectile.speed = projectile_info.speed
		projectile.direction = direction
		projectile.gravity = projectile_info.gravity
