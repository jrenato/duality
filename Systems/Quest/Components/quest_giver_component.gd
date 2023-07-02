extends Node
class_name QuestGiverComponent

@export var quest_log_screen_objective : PackedScene

var quest_id : int :
	set(value):
		quest_id = value
		set_quest_details()
	get:
		return quest_id

@onready var quest_giver_screen : QuestGiverScreen = %QuestGiverScreen

var quest_details : QuestDetails

var interacting_player : Player


func _ready() -> void:
	quest_giver_screen.visible = false
	quest_giver_screen.accept_button.pressed.connect(_on_accept_button_pressed)
	quest_giver_screen.decline_button.pressed.connect(_on_decline_button_pressed)


func set_quest_details() -> void:
	quest_details = QuestDatabase.get_quest(quest_id)
	quest_giver_screen.set_quest_details(quest_details)
	var stage : StageDetails = quest_details.stages[0]
	for objective in stage.objectives:
		var stage_objective_screen : QuestLogScreenObjective = quest_log_screen_objective.instantiate()
		quest_giver_screen.objectives_container.add_child(stage_objective_screen)
		stage_objective_screen.objective_label.text = objective.description


func interact_with(player : Player) -> void:
	if not quest_details:
		return

	if player.quest_log_component.query_active_quest(quest_details.quest_id):
		print("You already have that quest")
		return

	interacting_player = player
	display_quest_screen()


func display_quest_screen() -> void:
	quest_giver_screen.visible = true
	quest_giver_screen.accept_button.grab_focus()
	get_tree().paused = true


func hide_quest_screen() -> void:
	quest_giver_screen.visible = false
	get_tree().paused = false


func _on_accept_button_pressed() -> void:
	interacting_player.quest_log_component.add_new_quest(quest_details)
	quest_giver_screen.visible = false
	get_tree().paused = false


func _on_decline_button_pressed() -> void:
	hide_quest_screen()
