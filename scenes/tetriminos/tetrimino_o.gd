extends Tetrimino
class_name Tetrimino_O

func _ready() -> void:
	_rotation_movements = [
		[Vector2(0, 0), Vector2(1, 0), Vector2(0, 1), Vector2(1, 1)],
	]
	get_block_dimensions()
	set_block_positions()
