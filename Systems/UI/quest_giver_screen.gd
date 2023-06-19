extends CanvasLayer
class_name QuestGiverScreen

@onready var title_label: Label = %TitleLabel
@onready var description_label: Label = %DescriptionLabel
@onready var stage_label: Label = %StageLabel
@onready var objectives_label: Label = %ObjectivesLabel
@onready var accept_button: Button = %AcceptButton
@onready var decline_button: Button = %DeclineButton


func _ready() -> void:
	visible = false


func set_quest_details(quest_details : QuestDetails) -> void:
	title_label.text = quest_details.quest_name
	description_label.text = quest_details.log_description
