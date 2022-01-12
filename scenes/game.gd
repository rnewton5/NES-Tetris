extends Node2D

enum CURRENT_SCREEN { TITLE, OPTIONS, BOARD }

var BoardScene: PackedScene = preload("res://scenes/board.tscn")
var current_screen = CURRENT_SCREEN.TITLE


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if current_screen == CURRENT_SCREEN.TITLE:
		_process_input_title_screen()


func _process_input_title_screen() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$TitleScreen.hide()
		$Options.show()
		# var boardInstance = BoardScene.instance()
		# add_child(boardInstance)
		# $Options.show()
		# current_screen = CURRENT_SCREEN.OPTIONS


func _open_game_board(level: int, height: int) -> void:
	var board_scene: Board = BoardScene.instance()
	board_scene.board_type = "A TYPE"
	board_scene.level = level
	board_scene.height = height
	add_child(board_scene)
