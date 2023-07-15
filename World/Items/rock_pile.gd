extends Area2D

@onready var sprite: Sprite2D = $Sprite2D

@export var objective_id: String

var active: bool


func _ready() -> void:
	active = true


func interact_with(player : Player) -> void:
	# print("Picking rocks")
	Events.objective_updated.emit(objective_id, "interact", 1)


func enter_interaction_area() -> void:
	sprite.modulate = Color(Color.WHITE, 0.5)


func exit_interaction_area() -> void:
	sprite.modulate = Color(Color.WHITE, 1.0)
