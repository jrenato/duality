extends Area2D

@export var objective_id: String


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Events.objective_updated.emit(objective_id, "location", 1)


func _on_body_exited(body: Node2D) -> void:
	pass
