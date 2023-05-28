extends PlatformerController2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var enterable_nearby: Area2D


func _ready() -> void:
	super()
	jumped.connect(_on_jumped)


func _process(delta: float) -> void:
	if is_feet_on_ground():
		if velocity.x == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")
			animated_sprite.flip_h = velocity.x < 0
	else:
		animated_sprite.play("jump")

	if position.y > 300:
		Events.player_died.emit()
		queue_free()


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("enter") and enterable_nearby and enterable_nearby.active:
		if enterable_nearby is Vortex:
			Events.toggled_dimension.emit()
			set_collision_layer_value(1, !get_collision_layer_value(1))
			set_collision_layer_value(2, !get_collision_layer_value(2))

			set_collision_mask_value(1, !get_collision_mask_value(1))
			set_collision_mask_value(2, !get_collision_mask_value(2))
		elif enterable_nearby is ExitDoor and enterable_nearby.next_level:
			get_tree().change_scene_to_packed(enterable_nearby.next_level)


func die() -> void:
	Events.player_died.emit()
	queue_free()


func _on_jumped(is_ground_jump: bool) -> void:
	SoundPlayer.play_sound(SoundPlayer.JUMP)
