extends CanvasLayer


func _ready() -> void:
	SoundPlayer.play_song(SoundPlayer.INTRO_MUSIC)


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level01.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.
