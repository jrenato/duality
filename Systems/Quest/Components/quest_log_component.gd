extends Node
class_name QuestLogComponent

@export var quest_base_scene : PackedScene
@export var quest_log_screen_entry : PackedScene

var current_active_quests : Array[int]
var completed_quests : Array[int]
var current_tracked_quest : String

@onready var current_quests: Node = %CurrentQuests
@onready var quest_log_screen: QuestLogScreen = %QuestLogScreen


func _ready() -> void:
	quest_log_screen.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_log"):
		if quest_log_screen.visible:
			hide_quest_log_screen()
			get_viewport().set_input_as_handled()


func add_new_quest(quest_details : QuestDetails) -> void:
	if quest_details.quest_id not in current_active_quests:
		var quest_base : QuestBase  = quest_base_scene.instantiate()
		quest_base.quest_details = quest_details
		current_quests.add_child(quest_base)

		current_active_quests.append(quest_details.quest_id)


func display_quest_log_screen() -> void:
	for quest in quest_log_screen.main_quests.get_children():
		quest.queue_free()

	for current_quest in current_quests.get_children():
		var quest_entry : QuestLogScreenEntry = quest_log_screen_entry.instantiate()
		quest_log_screen.main_quests.add_child(quest_entry)
		quest_entry.button.text = current_quest.quest_details.quest_name

	quest_log_screen.visible = true
	get_tree().paused = true


func hide_quest_log_screen() -> void:
	quest_log_screen.visible = false
	get_tree().paused = false


func complete_quest() -> void:
	pass


func query_active_quest(quest_id : int) -> bool:
	return quest_id in current_active_quests


func track_quest() -> void:
	pass
