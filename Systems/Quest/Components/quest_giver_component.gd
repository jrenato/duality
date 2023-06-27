extends Node

@export var quest_id : int

@onready var quest_giver_screen : QuestGiverScreen = %QuestGiverScreen

var quest_details : QuestDetails

var interacting_player : Player


func _ready() -> void:
	quest_giver_screen.visible = false
	quest_details = QuestDatabase.get_quest(1001)
	quest_giver_screen.set_quest_details(quest_details)

	quest_giver_screen.accept_button.pressed.connect(_on_accept_button_pressed)
	quest_giver_screen.decline_button.pressed.connect(_on_decline_button_pressed)


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
