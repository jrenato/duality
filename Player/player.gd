extends PlatformerController2D
class_name Player

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var interaction_area : Area2D = %InteractionArea2D

@onready var quest_log_component : QuestLogComponent = %QuestLogComponent
@onready var weapon_component: WeaponComponent = %WeaponComponent

var interactable_nearby : Area2D


func _ready() -> void:
	super()
	jumped.connect(_on_jumped)
	interaction_area.area_entered.connect(_on_interaction_area_area_entered)
	interaction_area.area_exited.connect(_on_interaction_area_area_exited)


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
	if Input.is_action_just_pressed("interact"):
		if interactable_nearby and "active" in interactable_nearby and interactable_nearby.active:
			if interactable_nearby.has_method("interact_with"):
				interactable_nearby.interact_with(self)
	elif Input.is_action_just_pressed("shoot"):
		var direction : Vector2 = Vector2.RIGHT
		if animated_sprite.flip_h:
			direction = Vector2.LEFT
		weapon_component.shoot(direction)
	elif Input.is_action_just_pressed("toggle_log"):
		quest_log_component.display_quest_log_screen()


func die() -> void:
	Events.player_died.emit()
	queue_free()


func _on_jumped(is_ground_jump: bool) -> void:
	SoundPlayer.play_sound(SoundPlayer.JUMP)


func _on_interaction_area_area_entered(area: Area2D) -> void:
	if area.has_method("enter_interaction_area"):
		area.enter_interaction_area()

	interactable_nearby = area


func _on_interaction_area_area_exited(area: Area2D) -> void:
	if area.has_method("exit_interaction_area"):
		area.exit_interaction_area()

	interactable_nearby = null
