extends Node

const INTRO_MUSIC : AudioStream = preload("res://assets/Stay the Course.mp3")
const LEVEL_MUSIC : AudioStream = preload("res://assets/Limit 70.mp3")

const JUMP : AudioStream = preload("res://assets/jump.wav")
const COIN : AudioStream = preload("res://assets/coin.wav")
const DIAMOND : AudioStream = preload("res://assets/diamond.wav")
const DIMENSION_TOGGLE : AudioStream = preload("res://assets/dimension_toggle.wav")
const DIE : AudioStream = preload("res://assets/die.wav")

@onready var audio_players: Node = $AudioPlayers
@onready var song_audio_player: AudioStreamPlayer = $SongAudioStreamPlayer


func play_sound(sound : AudioStream) -> void:
	for audio_stream_player in audio_players.get_children():
		# Prevent playing the same sound (it increases the volume)
		if audio_stream_player.playing and audio_stream_player.stream == sound:
			return

	for audio_stream_player in audio_players.get_children():
		if not audio_stream_player.playing:
			audio_stream_player.stream = sound
			audio_stream_player.play()
			break


func play_song(song : AudioStream) -> void:
	if song_audio_player.stream != song:
		song_audio_player.stream = song
		song_audio_player.play()
