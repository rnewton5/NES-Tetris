extends Node2D

var TitleScreenScene: PackedScene = preload("res://scenes/title_screen.tscn")
var BoardScene: PackedScene = preload("res://scenes/board.tscn")
var OptionsScene: PackedScene = preload("res://scenes/options.tscn")

var _active_scene = null


func _ready() -> void:
	_active_scene = $TitleScreen


func _process(_delta: float) -> void:
	pass


func _on_TitleScreen_start_accepted() -> void:
	remove_child(_active_scene)
	_active_scene = OptionsScene.instance()
	_active_scene.connect("options_accepted", self, "_on_Options_accepted")
	_active_scene.connect("options_backed_out", self, "_on_Options_backed_out")
	add_child(_active_scene)


func _on_Options_accepted(type: String, music: int, level: int, height: int) -> void:
	remove_child(_active_scene)
	_active_scene = BoardScene.instance()
	_active_scene.board_type = "A TYPE"
	_active_scene.level = level
	_active_scene.height = height
	add_child(_active_scene)


func _on_Options_backed_out() -> void:
	remove_child(_active_scene)
	_active_scene = TitleScreenScene.instance()
	_active_scene.connect("start_accepted", self, "_on_TitleScreen_start_accepted")
	add_child(_active_scene)
