extends Node

@export var quest_id : int

@onready var quest_giver_screen : QuestGiverScreen = %QuestGiverScreen

var quest_details : QuestDetails


func _ready() -> void:
	quest_giver_screen.visible = false
	quest_details = QuestDatabase.get_quest(1001)
	quest_giver_screen.set_quest_details(quest_details)


func interact_with(player : Player) -> void:
	if not quest_details:
		return

	if player.quest_log_component.query_active_quest(quest_details.quest_id):
		print("You already have that quest")
		return
	
	display_quest()


func display_quest() -> void:
	quest_giver_screen.visible = true
