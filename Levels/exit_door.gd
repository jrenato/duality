extends Area2D
class_name ExitDoor

@export var next_level: PackedScene

var active: bool


func _ready() -> void:
	active = true


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.enterable_nearby = self


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.enterable_nearby = null
