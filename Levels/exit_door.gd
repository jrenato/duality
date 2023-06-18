extends Area2D
class_name ExitDoor

@export var next_level: PackedScene

var active: bool


func _ready() -> void:
	active = true


func interact_with(player : Player) -> void:
	if next_level:
		get_tree().change_scene_to_packed(next_level)
