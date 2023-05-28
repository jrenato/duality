extends CanvasLayer


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level01.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
