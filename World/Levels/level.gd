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

var starting_dimension: String
var spawn_point: SpawnPoint


func _ready() -> void:
	Events.toggled_dimension.connect(toggle_dimension)
	Events.player_died.connect(_on_player_died)

	var spawn_points = get_tree().get_nodes_in_group("spawn_point")
	if spawn_points.size() > 0:
		spawn_point = spawn_points[0] as SpawnPoint
	
	starting_dimension = current_dimension
	spawn_player()
	update_dimensions()

	# SoundPlayer.play_music(SoundPlayer.LEVEL_MUSIC)


func spawn_player() -> void:
	current_dimension = starting_dimension
	if spawn_point and player_scene:
		var player: Player = player_scene.instantiate()
		add_child(player)
		player.global_position = spawn_point.get_spawn_position()


func toggle_dimension() -> void:
	SoundPlayer.play_sound(SoundPlayer.DIMENSION_TOGGLE)
	if current_dimension == "White":
		current_dimension = "Blue"
	elif current_dimension == "Blue":
		current_dimension = "White"


func update_dimensions() -> void:
	if current_dimension == "White":
		tile_map_white.modulate.a = 1.0
		tile_map_blue.modulate.a = 0.3
		RenderingServer.set_default_clear_color(Color("222323"))
	elif current_dimension == "Blue":
		tile_map_white.modulate.a = 0.3
		tile_map_blue.modulate.a = 1.0
		RenderingServer.set_default_clear_color(Color("192626"))

	Events.activated_dimension.emit(current_dimension)


func _on_player_died() -> void:
	SoundPlayer.play_sound(SoundPlayer.DIE)
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	spawn_player()
