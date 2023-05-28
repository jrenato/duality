extends Node2D
class_name Level

@onready var tile_map_white: TileMap = $TileMapWhite
@onready var tile_map_blue: TileMap = $TileMapBlue
@onready var spawn_timer: Timer = $SpawnTimer

@export var player_scene: PackedScene

@export_enum("White", "Blue") var current_dimension: String = "White" :
	set(dimension):
		current_dimension = dimension
		update_dimensions()
	get:
		return current_dimension


var spawn_point: SpawnPoint


func _ready() -> void:
	Events.toggled_dimension.connect(toggle_dimension)
	Events.player_died.connect(_on_player_died)

	var spawn_points = get_tree().get_nodes_in_group("spawn_point")
	if spawn_points.size() > 0:
		spawn_point = spawn_points[0] as SpawnPoint

	spawn_player()
	update_dimensions()


func spawn_player() -> void:
	if spawn_point and player_scene:
		var player: Player = player_scene.instantiate()
		add_child(player)
		player.global_position = spawn_point.get_spawn_position()


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


func _on_player_died() -> void:
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	spawn_player()
