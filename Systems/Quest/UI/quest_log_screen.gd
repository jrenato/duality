extends CanvasLayer
class_name QuestLogScreen

@onready var main_quests: VBoxContainer = %MainQuestsContainer
@onready var side_quests: VBoxContainer = %SideQuestsContainer

@onready var title_label: Label = %TitleLabel
@onready var description_label: Label = %DescriptionLabel
@onready var stage_label: Label = %StageLabel
@onready var objectives_label: Label = %ObjectivesLabel