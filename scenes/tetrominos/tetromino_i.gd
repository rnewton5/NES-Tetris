tool
extends Tetromino


func _init() -> void:
	_type = "I"
	_sprite_column = 0
	_rotation_movements = [
		[Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0), Vector2(2, 0)],
		[Vector2(1, -2), Vector2(1, -1), Vector2(1, 0), Vector2(1, 1)],
	]
	_center_vector = Vector2(-1.0, -0.5)
