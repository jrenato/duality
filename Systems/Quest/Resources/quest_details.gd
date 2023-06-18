extends Resource
class_name QuestDetails

@export var quest_id : int
@export var quest_name : String
@export_multiline var log_description : String
@export_multiline var tracking_description : String
@export var is_main_quest : bool
@export var stages : Array[StageDetails]
