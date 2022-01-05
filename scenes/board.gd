tool
extends Node2D
class_name Board

var _board_a_texture: Texture = preload("res://images/board_a.png")
var _board_b_texture: Texture = preload("res://images/board_b.png")

export(String, "A TYPE", "B TYPE") var board_type := "A TYPE"

var _next_tetromino: Tetromino
var _lines_per_level = 10
var _lines_cleared = 0
var _level = 0


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
	_next_tetromino.update_block_sprite_for_level(_level)

	_next_tetromino = _get_random_tetromino()
	$NextDisplay.display_tetromino(_next_tetromino.get_type(), _level)


func _get_random_tetromino() -> Tetromino:
	return TetrominoFactory.get_random()


func _on_PlayField_active_dropped(type: String, lines_cleared: int) -> void:
	_drop_next_tetromino()
	$Statistics.increment_count_for_type(type)
	$Statistics.add_to_line_total(lines_cleared)
	$Statistics.update_score_for_lines_cleared(lines_cleared)
	_lines_cleared += lines_cleared
	var tempLevel: int = _lines_cleared / _lines_per_level
	if tempLevel > _level:
		_level = tempLevel
		$Statistics.set_level(_level)
		Events.emit_signal("level_up", _level)
