extends Node2D

var BoardScene: PackedScene = preload("res://scenes/board.tscn")


func _ready() -> void:
	var board_scene: Board = BoardScene.instance()
	board_scene.board_type = "B TYPE"
	board_scene.level = 0
	board_scene.height = 1
	add_child(board_scene)
