tool
extends Tetromino

func _ready() -> void:
	_sprite_column = 2
	_rotation_movements = [
		[Vector2(2, 0), Vector2(1, 0), Vector2(1, 1), Vector2(0, 1)],
		[Vector2(0, 0), Vector2(0, 1), Vector2(1, 1), Vector2(1, 2)],
	]
	update_blocks()
