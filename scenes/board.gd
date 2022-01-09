tool
extends Node2D
class_name Board

var _board_a_texture: Texture = preload("res://images/board_a.png")
var _board_b_texture: Texture = preload("res://images/board_b.png")

export(String, "A TYPE", "B TYPE") var board_type := "A TYPE"
export var level := 0
export var height := 0

var _next_tetromino: Tetromino
var _lines_per_level = 10
var _lines_cleared = 0
var _lines_for_b_type = 25
var _num_rows_for_height := {0: 0, 1: 3, 2: 5, 3: 7, 4: 10, 5: 12}


func _ready() -> void:
	if board_type == "A TYPE":
		$Foreground.set_texture(_board_a_texture)
		$Statistics.hide_height()
	if board_type == "B TYPE":
		$Foreground.set_texture(_board_b_texture)
		$Statistics.set_level(level)
		$Statistics.set_height(height)
		$Statistics.set_lines(_lines_for_b_type)
	$SuccessMessage.hide()
	$Statistics.set_level(level)
	$PlayField.add_garbage(_num_rows_for_height[height])
	_drop_next_tetromino()
	Events.emit_signal("level_up", level)


func _drop_next_tetromino() -> void:
	if _next_tetromino == null:
		_next_tetromino = _get_random_tetromino()
	$PlayField.drop_tetromino(_next_tetromino)
	_next_tetromino.update_block_sprite_for_level(level)

	_next_tetromino = _get_random_tetromino()
	$NextDisplay.display_tetromino(_next_tetromino.get_type(), level)


func _get_random_tetromino() -> Tetromino:
	return TetrominoFactory.get_random()


func _on_PlayField_active_dropped(type: String, lines_cleared: int) -> void:
	_lines_cleared += lines_cleared
	$Statistics.increment_count_for_type(type)
	$Statistics.update_score_for_lines_cleared(lines_cleared)

	if board_type == "A TYPE":
		$Statistics.set_lines(_lines_cleared)
		var tempLevel: int = _lines_cleared / _lines_per_level
		if tempLevel > level:
			level = tempLevel
			$Statistics.set_level(level)
			Events.emit_signal("level_up", level)
		_drop_next_tetromino()
	else:
		var lines_remaining = max(0, _lines_for_b_type - _lines_cleared)
		$Statistics.set_lines(lines_remaining)
		if lines_remaining == 0:
			$SuccessMessage.show()
		else:
			_drop_next_tetromino()
