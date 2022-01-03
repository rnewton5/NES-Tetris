tool
extends Node2D

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
	var label: Label = _type_label_dict[tetromino_type]
	var current_value = int(label.text)
	current_value += 1
	label.text = str(current_value + 1000).substr(1)


func _update_child_tetromino_transforms(tetromino: Tetromino) -> void:
	tetromino.set_centered(true)
	tetromino.set_block_scale(.8)
