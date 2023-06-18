extends Node

@export var quest_data : Resource


func get_quest(quest_id) -> QuestDetails:
	for quest in quest_data.quests:
		if quest.quest_id == quest_id:
			return quest

	return null
