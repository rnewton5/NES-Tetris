extends Node2D

var BoardScene: PackedScene = preload("res://scenes/board.tscn")


func _ready() -> void:
	pass


func _open_game_board(level: int, height: int) -> void:
	var board_scene: Board = BoardScene.instance()
	board_scene.board_type = "A TYPE"
	board_scene.level = level
	board_scene.height = height
	add_child(board_scene)
