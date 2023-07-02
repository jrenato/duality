extends Area2D
class_name Sign

@export_multiline var message: String

var active: bool

@onready var sign_sprite: Sprite2D = $SignSprite


func _ready() -> void:
	active = true


func interact_with(player : Player) -> void:
	print(message)


func enter_interaction_area() -> void:
	sign_sprite.modulate = Color(Color.WHITE, 0.5)


func exit_interaction_area() -> void:
	sign_sprite.modulate = Color(Color.WHITE, 1.0)
