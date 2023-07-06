extends Node

signal toggled_dimension
signal activated_dimension(dimension: String)

signal objective_updated(objective_id : String, objective_type: String, quantity: int)
signal objective_completed(objective_id : String, objective_name : String)

signal player_died
