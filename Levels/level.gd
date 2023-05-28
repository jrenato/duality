extends Node2D
class_name Level

@onready var tile_map_white: TileMap = $TileMapWhite
@onready var tile_map_blue: TileMap = $TileMapBlue

@export_enum("White", "Blue") var current_dimension: String = "White" :
	set(dimension):
		current_dimension = dimension
		update_dimensions()
	get:
		return current_dimension


func _ready() -> void:
	Events.toggled_dimension.connect(toggle_dimension)
	update_dimensions()


func toggle_dimension() -> void:
	if current_dimension == "White":
		current_dimension = "Blue"
	elif current_dimension == "Blue":
		current_dimension = "White"


func update_dimensions() -> void:
	if current_dimension == "White":
		tile_map_white.modulate.a = 1.0
		tile_map_blue.modulate.a = 0.3
	elif current_dimension == "Blue":
		tile_map_white.modulate.a = 0.3
		tile_map_blue.modulate.a = 1.0

	Events.activated_dimension.emit(current_dimension)
