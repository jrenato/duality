extends CanvasLayer

@onready var main_menu: PanelContainer = %MainMenuPanelContainer
@onready var credits_container: HBoxContainer = %CreditsHBoxContainer


func _ready() -> void:
	# SoundPlayer.play_music(SoundPlayer.INTRO_MUSIC)
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://World/Levels/level01.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	main_menu.visible = false
	credits_container.visible = true


func _on_return_button_pressed() -> void:
	main_menu.visible = true
	credits_container.visible = false
