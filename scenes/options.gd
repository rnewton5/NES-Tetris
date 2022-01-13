extends Node2D

signal options_accepted(type, music, level, height)
signal options_backed_out

var _game_type := "A Type"
var _music := 1
var _level := 0
var _height := 0

onready var _active_child := $OptionsGameType


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	_active_child.process_input()


func _on_OptionsGameType_game_type_changed(type: String) -> void:
	_game_type = type


func _on_OptionsGameType_music_changed(music: String) -> void:
	_music = int(music)


func _on_OptionsGameType_options_accepted(type: String, music: String) -> void:
	_game_type = type
	_music = int(music)
	$OptionsGameType.hide()
	_active_child = $OptionsTypeA if _game_type == "A Type" else $OptionsTypeB
	_active_child.show()


func _on_OptionsTypeA_options_accepted(level: int) -> void:
	_level = level
	emit_signal("options_accepted", _game_type, _music, _level, 0)


func _on_OptionsTypeB_options_accepted(level: int, height: int) -> void:
	_level = level
	_height = height
	emit_signal("options_accepted", _game_type, _music, _level, _height)


func _on_OptionsGameType_options_backed_out() -> void:
	emit_signal("options_backed_out")


func _on_OptionsTypeA_options_backed_out() -> void:
	$OptionsTypeA.hide()
	$OptionsTypeB.hide()
	$OptionsGameType.show()
	_active_child = $OptionsGameType


func _on_OptionsTypeB_options_backed_out() -> void:
	$OptionsTypeA.hide()
	$OptionsTypeB.hide()
	$OptionsGameType.show()
	_active_child = $OptionsGameType
