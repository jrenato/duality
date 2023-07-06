extends CanvasLayer
class_name QuestNotificationScreen

@onready var notification_label: Label = %NotificationLabel
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	Events.objective_completed.connect(_on_objective_completed)
	visible = false


func hide_screen() -> void:
	visible = false


func _on_objective_completed(objective_id : String, objective_name : String) -> void:
	visible = true
	notification_label.text = objective_name
	if animation_player.is_playing():
		animation_player.stop()
	animation_player.play("display")
