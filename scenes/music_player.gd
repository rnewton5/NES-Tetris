extends Node2D


func _ready() -> void:
	_silence_all()


func play_music_one() -> void:
	_silence_all_and_play($MusicOne)


func play_music_two() -> void:
	_silence_all_and_play($MusicTwo)


func play_music_three() -> void:
	_silence_all_and_play($MusicThree)


func _silence_all_and_play(player: AudioStreamPlayer) -> void:
	_silence_all()
	player.play()


func _silence_all() -> void:
	for child in get_children():
		child.stop()
