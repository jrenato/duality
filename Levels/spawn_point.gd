extends Sprite2D
class_name SpawnPoint

@onready var point: Sprite2D = $Point


func _ready() -> void:
	point.visible = false


func get_spawn_position() -> Vector2:
	return point.global_position
