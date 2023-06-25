extends Node

const INTRO_MUSIC : AudioStream = preload("res://Assets/Stay the Course.mp3")
const LEVEL_MUSIC : AudioStream = preload("res://Assets/Limit 70.mp3")

const JUMP : AudioStream = preload("res://Assets/jump.wav")
const COIN : AudioStream = preload("res://Assets/coin.wav")
const DIAMOND : AudioStream = preload("res://Assets/diamond.wav")
const DIMENSION_TOGGLE : AudioStream = preload("res://Assets/dimension_toggle.wav")
const DIE : AudioStream = preload("res://Assets/die.wav")

@onready var sound_players: Node = $SoundPlayers
@onready var music_player: AudioStreamPlayer = $MusicStreamPlayer


func play_sound(sound : AudioStream) -> void:
	for sound_player in sound_players.get_children():
		# Prevent playing the same sound
		if sound_player.playing and sound_player.stream == sound:
			return

		if not sound_player.playing:
			sound_player.stream = sound
			sound_player.play()
			break


func play_music(music : AudioStream) -> void:
	if music_player.stream != music:
		music_player.stream = music
		music_player.play()
