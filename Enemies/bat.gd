@tool
extends Path2D

enum ANIMATION_TYPE { LOOP, BOUNCE }

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var area_2d: Area2D = $PathFollow2D/Area2D

@export var speed : int = 50 : 
	set(value):
		speed = value
		# Set value if running inside editor (tool)
		if Engine.is_editor_hint():
			await ready
			animation_player.speed_scale = speed / curve.get_baked_length()
	get:
		return speed

@export var animation_type : ANIMATION_TYPE = ANIMATION_TYPE.LOOP :
	set(value):
		animation_type = value
		# Set value if running inside editor (tool)
		if Engine.is_editor_hint():
			await ready
			set_animation_type()
	get:
		return animation_type


@export_enum("White", "Blue") var parent_dimension: String = "White":
	set(value):
		parent_dimension = value
		if not Engine.is_editor_hint():
			await ready
		update_parent_dimension()
	get:
		return parent_dimension


func _ready() -> void:
	set_animation_type()
	if animation_player:
		if not Engine.is_editor_hint():
			animation_player.speed_scale = speed / curve.get_baked_length()

	if not Engine.is_editor_hint():
		Events.activated_dimension.connect(update_active_dimension)
		update_parent_dimension()


func set_animation_type() -> void:
	match animation_type:
		ANIMATION_TYPE.BOUNCE: animation_player.play("MoveBounce")
		ANIMATION_TYPE.LOOP: animation_player.play("MoveLoop")


func update_parent_dimension() -> void:
	if parent_dimension == "White":
		modulate = Color.WHITE
		area_2d.set_collision_mask_value(1, true)
		area_2d.set_collision_mask_value(2, false)
	elif parent_dimension == "Blue":
		modulate = Color.CYAN
		area_2d.set_collision_mask_value(1, false)
		area_2d.set_collision_mask_value(2, true)


func update_active_dimension(active_dimension: String) -> void:
	if active_dimension == parent_dimension:
		modulate.a = 1.0
	else:
		modulate.a = 0.3


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
 
