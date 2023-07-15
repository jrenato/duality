extends Area2D
class_name ProjectileScene

var damage : float = 0
var damage_type : String
var reload_time : float = 0

var speed : float = 0
var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var gravity_pull : Vector2 = Vector2.ZERO


func _ready() -> void:
	var visible_notififier : VisibleOnScreenNotifier2D = VisibleOnScreenNotifier2D.new()
	add_child(visible_notififier)

	visible_notififier.screen_exited.connect(_on_screen_exited)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _process(delta: float) -> void:
	if direction != Vector2(0, 0) and speed > 0:
		gravity_pull += gravity_direction * gravity * delta
		velocity = (direction * speed) + gravity_pull
		translate(velocity * delta)


func _on_area_entered(area: Area2D) -> void:
	pass


func _on_area_exited(area: Area2D) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("receive_damage"):
		body.receive_damage(damage, damage_type)
	queue_free()


func _on_body_exited(body: Node2D) -> void:
	pass


func _on_screen_exited() -> void:
	queue_free()
