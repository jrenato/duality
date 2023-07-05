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
	quest_log_screen.close_button.pressed.connect(_on_close_button_pressed)


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_log"):
		if quest_log_screen.visible:
			hide_quest_log_screen()
			get_viewport().set_input_as_handled()


func add_new_quest(quest_id : int) -> void:
	if quest_id not in current_active_quests:
		var quest_base : QuestBase  = quest_base_scene.instantiate()
		var quest_details : QuestDetails = QuestDatabase.get_quest(quest_id)

		current_quests.add_child(quest_base)
		quest_base.quest_details = quest_details
		quest_base.current_stage = 0

		current_active_quests.append(quest_id)


func display_quest_log_screen() -> void:
	load_quests_log()
	quest_log_screen.visible = true
	quest_log_screen.quest_details_container.visible = false
	get_tree().paused = true


func load_quests_log() -> void:
	clear_quests_log()
	for current_quest in current_quests.get_children():
		var quest_entry : QuestLogScreenEntry = quest_log_screen_entry.instantiate()

		if current_quest.quest_details.is_main_quest:
			quest_log_screen.main_quests.add_child(quest_entry)
		else:
			quest_log_screen.side_quests.add_child(quest_entry)

		quest_entry.button.text = current_quest.quest_details.quest_name
		quest_entry.button.pressed.connect(_on_quest_button_pressed.bind(current_quest))


func clear_quests_log() -> void:
	for quest_entry in quest_log_screen.main_quests.get_children():
		quest_entry.queue_free()
	for quest_entry in quest_log_screen.side_quests.get_children():
		quest_entry.queue_free()


func hide_quest_log_screen() -> void:
	quest_log_screen.visible = false
	get_tree().paused = false


func complete_quest() -> void:
	pass


func query_active_quest(quest_id : int) -> bool:
	return quest_id in current_active_quests


func track_quest() -> void:
	pass


func _on_quest_button_pressed(quest_base : QuestBase) -> void:
	quest_log_screen.quest_base = quest_base
	quest_log_screen.quest_details_container.visible = true


func _on_close_button_pressed() -> void:
	hide_quest_log_screen()
