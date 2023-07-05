extends Node
class_name QuestBase

var quest_id : int :
	set(value):
		quest_id = value
		load_quest_details()
	get:
		return quest_id

var current_stage : int :
	set(value):
		current_stage = value
		load_current_stage_details()
	get:
		return current_stage

var quest_details : QuestDetails
var current_stage_details : StageDetails

var current_objective_progress : Dictionary
var is_completed : bool


func _ready() -> void:
	Events.objective_updated.connect(_on_objective_updated)


func load_quest_details() -> void:
	if not quest_id:
		return

	quest_details = QuestDatabase.get_quest(quest_id)


func load_current_stage_details() -> void:
	if not quest_details or current_stage == null:
		return

	current_stage_details = quest_details.stages[current_stage]
	create_current_objective_progress()


func get_objective_details(objective_id: String) -> ObjectiveDetails:
	for objective in current_stage_details.objectives:
		if objective.objective_id == objective_id:
			return objective

	return null


func create_current_objective_progress() -> void:
	current_objective_progress.clear()

	for objective_detail in current_stage_details.objectives:
		current_objective_progress[objective_detail.objective_id] = {
			"quantity": 0
		}


func _on_objective_updated(objective_id: String, objective_type: String, quantity: int) -> void:
	var objective_details: ObjectiveDetails = get_objective_details(objective_id)

	if current_objective_progress.has(objective_id):
		var new_quantity: int = current_objective_progress[objective_id]["quantity"] + quantity
		if new_quantity < objective_details.quantity:
			current_objective_progress[objective_id]["quantity"] = new_quantity
		else:
			# Discard the excedent
			current_objective_progress[objective_id]["quantity"] = objective_details.quantity
