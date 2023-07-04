extends Node
class_name QuestBase

var quest_id : int :
	set(value):
		quest_id = value
		update_quest_details()
	get:
		return quest_id

var current_stage : int :
	set(value):
		current_stage = value
		update_current_stage_details()
	get:
		return current_stage

var quest_details : QuestDetails
var current_stage_details : StageDetails

var objectives_progress : Dictionary
var is_completed : bool


func update_quest_details() -> void:
	if not quest_id:
		return

	quest_details = QuestDatabase.get_quest(quest_id)


func update_current_stage_details() -> void:
	if not quest_details or not current_stage:
		return

	current_stage_details = quest_details.stages[current_stage]
