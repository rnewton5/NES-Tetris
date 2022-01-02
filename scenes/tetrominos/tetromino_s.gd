tool
extends Tetromino


func _init() -> void:
	_type = "S"
	_sprite_column = 2
	_rotation_movements = [
		[Vector2(2, 0), Vector2(1, 0), Vector2(1, 1), Vector2(0, 1)],
		[Vector2(0, 0), Vector2(0, 1), Vector2(1, 1), Vector2(1, 2)],
	]
	_center_vector = Vector2(-1.5, -1.0)
