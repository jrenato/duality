extends Area2D

@onready var quest_giver_component: Node = %QuestGiverComponent

@export var active : bool = true


func _ready() -> void:
	pass


func interact_with(player : Player) -> void:
	quest_giver_component.interact_with(player)
