extends Area2D
class_name Vortex

@onready var recharge_timer: Timer = $RechargeTimer
@onready var spawn_point: Node2D = %SpawnPoint

var active: bool = true


func _ready() -> void:
	Events.toggled_dimension.connect(_on_toggled_dimension)
	recharge_timer.timeout.connect(_on_recharge_timer_timeout)


func interact_with(player : Player) -> void:
	Events.toggled_dimension.emit()
	player.global_position = spawn_point.global_position
	player.set_collision_layer_value(1, !player.get_collision_layer_value(1))
	player.set_collision_layer_value(2, !player.get_collision_layer_value(2))

	player.set_collision_mask_value(1, !player.get_collision_mask_value(1))
	player.set_collision_mask_value(2, !player.get_collision_mask_value(2))


func _on_toggled_dimension() -> void:
	active = false
	recharge_timer.start()


func _on_recharge_timer_timeout() -> void:
	active = true
