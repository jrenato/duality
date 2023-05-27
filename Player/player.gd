extends PlatformerController2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var vortex_nearby: Area2D


func _ready() -> void:
	super()


func _process(delta: float) -> void:
	if is_feet_on_ground():
		if velocity.x == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")
			animated_sprite.flip_h = velocity.x < 0
	else:
		animated_sprite.play("jump")
