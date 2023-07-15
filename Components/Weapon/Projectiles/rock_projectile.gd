extends ProjectileScene

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	super()
	sprite.rotation = randf_range(0, TAU)


func _process(delta: float) -> void:
	super(delta)
