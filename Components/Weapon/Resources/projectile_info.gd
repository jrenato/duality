extends Resource
class_name ProjectileInfo

@export var projectile_scene : PackedScene
@export var projectile_icon : Texture

@export var damage : float
@export var reload_time : float
@export_enum("Impact", "Piercing", "Fire", "Ice", "Poison") var damage_type: String = "Impact"

@export var speed : float
@export var gravity : float
