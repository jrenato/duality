@tool
extends Area2D

@export_enum("White", "Blue") var parent_dimension: String = "White":
	set(value):
		parent_dimension = value
		update_parent_dimension()
	get:
		return parent_dimension


func _ready() -> void:
	if not Engine.is_editor_hint():
		Events.activated_dimension.connect(update_active_dimension)
	update_parent_dimension()


func update_parent_dimension() -> void:
	if parent_dimension == "White":
		modulate = Color.WHITE
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, false)
	elif parent_dimension == "Blue":
		modulate = Color.CYAN
		set_collision_mask_value(1, false)
		set_collision_mask_value(2, true)


func update_active_dimension(active_dimension: String) -> void:
	if active_dimension == parent_dimension:
		modulate.a = 1.0
	else:
		modulate.a = 0.3


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SoundPlayer.play_sound(SoundPlayer.DIAMOND)
		queue_free()
