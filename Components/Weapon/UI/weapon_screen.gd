extends CanvasLayer
class_name WeaponScreenScene

@export var projectile_slot_scene : PackedScene
@onready var slots_container: HBoxContainer = %ProjectilesSlotsContainer


func update_projectiles_slots(projectiles_info : Array[ProjectileInfo]) -> void:
	for projectile_slot in slots_container.get_children():
		projectile_slot.queue_free()
	for projectile_info in projectiles_info:
		var slot : ProjectileSlot = projectile_slot_scene.instantiate()
		slots_container.add_child(slot)
