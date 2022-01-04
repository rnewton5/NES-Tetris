tool
extends Node2D

var _top_score = 010000  # TODO: pull this from file
var _score = 0
var _lines = 0
var _tetromino_stats = {
	"I": 0,
	"J": 0,
	"L": 0,
	"O": 0,
	"S": 0,
	"T": 0,
	"Z": 0,
}

onready var _type_label_dict := {
	"I": $StatLabel_I,
	"J": $StatLabel_J,
	"L": $StatLabel_L,
	"O": $StatLabel_O,
	"S": $StatLabel_S,
	"T": $StatLabel_T,
	"Z": $StatLabel_Z,
}


func _ready() -> void:
	_update_child_tetromino_transforms($Tetromino_I)
	_update_child_tetromino_transforms($Tetromino_J)
	_update_child_tetromino_transforms($Tetromino_L)
	_update_child_tetromino_transforms($Tetromino_O)
	_update_child_tetromino_transforms($Tetromino_S)
	_update_child_tetromino_transforms($Tetromino_T)
	_update_child_tetromino_transforms($Tetromino_Z)


func increment_count_for_type(tetromino_type: String) -> void:
	_tetromino_stats[tetromino_type] += 1
	var current_value = _tetromino_stats[tetromino_type]
	var label: Label = _type_label_dict[tetromino_type]
	label.text = _zero_pad_left(current_value, 3)


func add_to_line_total(value: int) -> void:
	_lines += value
	$Lines.text = _zero_pad_left(_lines, 3)


func subtract_from_line_total(value: int) -> void:
	_lines -= value
	$Lines.text = _zero_pad_left(_lines, 3)


func add_to_score(value: int) -> void:
	_score += value
	$Score.text = _zero_pad_left(_lines, 6)


func _update_child_tetromino_transforms(tetromino: Tetromino) -> void:
	tetromino.set_centered(true)
	tetromino.set_block_scale(.8)


func _zero_pad_left(value: int, num_digits: int) -> String:
	var temp = pow(10, num_digits) as int
	return str(value + temp).substr(1)
