extends StaticBody2D


@export var objective_id: String


func receive_damage(damage : float, damage_type : String):
	Events.objective_updated.emit(objective_id, "kill", 1)
	queue_free()
