extends Node
class_name QuestLogComponent

@export var quest_base_scene : PackedScene

var current_active_quests : Array[int]
var completed_quests : Array[int]
var currect_tracked_quest : String

@onready var current_quests: Node = %CurrentQuests


func add_new_quest(quest_details : QuestDetails) -> void:
	if quest_details.quest_id not in current_active_quests:
		current_active_quests.append(quest_details.quest_id)
		var quest_base : QuestBase  = quest_base_scene.instantiate()
		current_quests.add_child(quest_base)
		quest_base.quest_details = quest_details


func complete_quest() -> void:
	pass


func query_active_quest(quest_id : int) -> bool:
	return quest_id in current_active_quests


func track_quest() -> void:
	pass
