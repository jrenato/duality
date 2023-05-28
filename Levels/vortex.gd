extends Area2D
class_name Vortex

@onready var recharge_timer: Timer = $RechargeTimer

var active: bool = true


func _ready() -> void:
	Events.toggled_dimension.connect(_on_toggled_dimension)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.enterable_nearby = self


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		body.enterable_nearby = null


func _on_toggled_dimension() -> void:
	active = false
	recharge_timer.start()


func _on_recharge_timer_timeout() -> void:
	active = true
