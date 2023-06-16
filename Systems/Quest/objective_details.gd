extends Resource
class_name ObjectiveDetails

@export var objective_id : String
@export var objective_name : String
@export_multiline var description : String
@export_enum("location", "inspect", "kill", "collect") var objective_type: String
@export var quantity : int
@export var is_optional : bool
@export var bonus_xp : int
