extends Node

@export var quest_id : int

var quest_details : QuestDetails


func _ready() -> void:
	quest_details = QuestDatabase.get_quest(1001)


func interact_with(player : Player) -> void:
	if not quest_details:
		return

	if player.quest_log_component.query_active_quest(quest_details.quest_id):
		print("You already have that quest")
		return
	
	display_quest()


func display_quest() -> void:
	# TODO: Display quest
	print(quest_details.quest_name)
