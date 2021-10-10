extends Tetrimino
class_name Tetrimino_Z

func _ready() -> void:
	_rotation_movements = [
		[Vector2(0, 0), Vector2(1, 0), Vector2(1, 1), Vector2(2, 1)],
		[Vector2(1, 0), Vector2(1, 1), Vector2(0, 1), Vector2(0, 2)],
	]
	get_block_dimensions()
	set_block_positions()
