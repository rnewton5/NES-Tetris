extends Node2D

export var block_size := 8
export var width := 10
export var height := 20

onready var _board_state := []

func _ready() -> void:
	randomize()
	reset_board_state()
	add_child(_get_random_tetromino())
	pass

func reset_board_state():
	_board_state = []
	for i in range(height):
		var row := []
		_board_state.append(row)
		for j in range(width):
			row.append(false)

func _get_random_tetromino():
	return TetrominoFactory.get_random()
