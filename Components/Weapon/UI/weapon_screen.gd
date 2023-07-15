extends CanvasLayer
class_name WeaponScreenScene

@export var projectile_slot_scene : PackedScene
@onready var projectiles_slots_container: HBoxContainer = %ProjectilesSlotsContainer


func update_projectiles_slots(projectiles : Array[ProjectileInfo]) -> void:
	pass
