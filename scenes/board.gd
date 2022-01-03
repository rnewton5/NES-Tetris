tool
extends Node2D
class_name Board

export(String, "A TYPE", "B TYPE") var board_type := "A TYPE"

var _board_a_texture: Texture = preload("res://images/board_a.png")
var _board_b_texture: Texture = preload("res://images/board_b.png")

var _next_tetromino: Tetromino


func _ready() -> void:
	if board_type == "A TYPE":
		$Foreground.set_texture(_board_a_texture)
	if board_type == "B TYPE":
		$Foreground.set_texture(_board_b_texture)
	_drop_next_tetromino()


func _drop_next_tetromino() -> void:
	if _next_tetromino == null:
		_next_tetromino = _get_random_tetromino()
	$PlayField.drop_tetromino(_next_tetromino)

	_next_tetromino = _get_random_tetromino()
	$NextDisplay.display_tetromino(_next_tetromino.get_type())


func _get_random_tetromino() -> Tetromino:
	return TetrominoFactory.get_random()


func _on_PlayField_active_dropped(type: String) -> void:
	$Statistics.increment_count_for_type(type)
	_drop_next_tetromino()
