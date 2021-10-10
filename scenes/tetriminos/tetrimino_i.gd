extends Tetrimino
class_name Tetrimino_I

func _ready() -> void:
	_rotation_movements = [
		[Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0), Vector2(2, 0)],
		[Vector2(1, -2), Vector2(1, -1), Vector2(1, 0), Vector2(1, 1)],
	]
	get_block_dimensions()
	set_block_positions()
