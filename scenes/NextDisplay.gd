extends Position2D

var _current_tetromino: Tetromino


func display_tetromino(type: String) -> void:
	remove_child(_current_tetromino)
	if type == "I":
		_current_tetromino = TetrominoFactory.get_i()
	if type == "J":
		_current_tetromino = TetrominoFactory.get_j()
	if type == "L":
		_current_tetromino = TetrominoFactory.get_l()
	if type == "O":
		_current_tetromino = TetrominoFactory.get_o()
	if type == "S":
		_current_tetromino = TetrominoFactory.get_s()
	if type == "T":
		_current_tetromino = TetrominoFactory.get_t()
	if type == "Z":
		_current_tetromino = TetrominoFactory.get_z()
	_current_tetromino.set_block_scale(0.9)
	_current_tetromino.set_centered(true)
	add_child(_current_tetromino)
