extends CanvasLayer
class_name QuestLogScreen

@export var quest_log_screen_objective : PackedScene

@onready var main_quests: VBoxContainer = %MainQuestsContainer
@onready var side_quests: VBoxContainer = %SideQuestsContainer

@onready var quest_details_container: MarginContainer = %QuestDetailsMarginContainer
@onready var objectives_container: VBoxContainer = %ObjectivesContainer

@onready var title_label: Label = %TitleLabel
@onready var description_label: Label = %DescriptionLabel
@onready var stage_label: Label = %StageLabel
@onready var objectives_label: Label = %ObjectivesLabel

@onready var close_button: Button = %CloseButton

var quest_base : QuestBase :
	set(value):
		quest_base = value
		update_quest_details()
	get:
		return quest_base


func update_quest_details() -> void:
	if not quest_base:
		return

	title_label.text = quest_base.quest_details.quest_name
	description_label.text = quest_base.quest_details.log_description
	stage_label.text = quest_base.current_stage_details.description

	clear_objectives_log()
	load_objectives_for_stage()


func load_objectives_for_stage() -> void:
	var stage : StageDetails = quest_base.quest_details.stages[quest_base.current_stage]
	for objective in stage.objectives:
		var stage_objective_screen : QuestLogScreenObjective = quest_log_screen_objective.instantiate()
		objectives_container.add_child(stage_objective_screen)

		var current_quantity = 0
		if quest_base.current_objective_progress.has(objective.objective_id):
			current_quantity = quest_base.current_objective_progress[objective.objective_id]["quantity"]

		stage_objective_screen.objective_label.text = "%s %s/%s" % [objective.objective_name, current_quantity, objective.quantity]
		stage_objective_screen.objective_check_box.button_pressed = current_quantity == objective.quantity


func clear_objectives_log() -> void:
	for objective_entry in objectives_container.get_children():
		objective_entry.queue_free()
