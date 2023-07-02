extends Area2D

@onready var quest_giver_component: QuestGiverComponent = %QuestGiverComponent
#@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D

@export var quest_id : int
@export var active : bool = true


func _ready() -> void:
	quest_giver_component.quest_id = quest_id


func interact_with(player : Player) -> void:
	quest_giver_component.interact_with(player)


#func enter_interaction_area() -> void:
#	animated_sprite_2d.modulate = Color(Color.WHITE, 0.5)


#func exit_interaction_area() -> void:
#	animated_sprite_2d.modulate = Color(Color.WHITE, 1.0)
