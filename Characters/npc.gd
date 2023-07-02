extends Area2D

@onready var quest_giver_component: QuestGiverComponent = %QuestGiverComponent

@export var quest_id : int
@export var active : bool = true


func _ready() -> void:
	quest_giver_component.quest_id = quest_id


func interact_with(player : Player) -> void:
	quest_giver_component.interact_with(player)
