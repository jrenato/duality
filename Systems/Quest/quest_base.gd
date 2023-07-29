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

	if quest_details.stages.size() <= current_stage:
		return

	current_stage_details = quest_details.stages[current_stage]
	create_current_objective_progress()


func create_current_objective_progress() -> void:
	current_objective_progress.clear()

	for objective_detail in current_stage_details.objectives:
		current_objective_progress[objective_detail.objective_id] = {
			"quantity": 0
		}


func get_objective_details(objective_id: String) -> ObjectiveDetails:
	for objective in current_stage_details.objectives:
		if objective.objective_id == objective_id:
			return objective

	return null


func is_objective_complete(objective_id: String) -> bool:
	var objective_details: ObjectiveDetails = get_objective_details(objective_id)

	if current_objective_progress.has(objective_id):
		return current_objective_progress[objective_id]["quantity"] >= objective_details.quantity

	return false


func update_quest_status() -> void:
	for objective in current_stage_details.objectives:
		if not is_objective_complete(objective.objective_id):
			# There are still remaining objectives in the current stage
			return

	# Current stage is complete, check if there are remaining stages
	if quest_details.stages.size() > current_stage + 1:
		# There are still remaining stages in the quest, move to the next stage
		current_stage += 1
	else:
		# Quest is complete
		is_completed = true


func _on_objective_updated(objective_id: String, objective_type: String, quantity: int) -> void:
	var objective_details: ObjectiveDetails = get_objective_details(objective_id)

	if current_objective_progress.has(objective_id) and not is_objective_complete(objective_id):
		var new_quantity: int = current_objective_progress[objective_id]["quantity"] + quantity
		if new_quantity < objective_details.quantity:
			current_objective_progress[objective_id]["quantity"] = new_quantity
		else:
			# Discard the excedent
			current_objective_progress[objective_id]["quantity"] = objective_details.quantity
			Events.objective_completed.emit(objective_id, objective_details.objective_name)
			update_quest_status()
