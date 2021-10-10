extends Position2D
class_name Tetrimino

onready var _blocks := get_children();

var block_width := 0
var block_height := 0
var _rotation_movements := []
var _rotation_index := 0 setget set_rotation_index

func get_block_dimensions() -> void:
	var block: Block = _blocks[0]
	var block_dimensions := block.region_rect.size
	block_width = block_dimensions.x
	block_height = block_dimensions.y

func set_block_positions() -> void:
	for i in _blocks.size():
		var block = _blocks[i]
		var block_coords: Vector2 = _get_block_coords(i)
		var x = block_coords.x
		var y = block_coords.y
		block.position = Vector2(x * block_width, y * block_height)

func get_all_block_coords() -> Vector2:
	return _rotation_movements[_rotation_index]

func rotate_right() -> void:
	set_rotation_index(_rotation_index + 1)

func rotate_left() -> void:
	set_rotation_index(_rotation_index - 1)

func set_rotation_index(value: int) -> void:
	_rotation_index = value % _blocks.size()
	set_block_positions()

func clear_by_y_position(first_to_clear: int, last_to_clear: int) -> void:
	if last_to_clear < first_to_clear:
		return
	for i in _blocks.size():
		var block: Block = _blocks[i]
		var block_coords: Vector2 = _get_block_coords(i)
		if block.y < first_to_clear:
			_lower_block(block, i, last_to_clear - first_to_clear)
		elif block.y <= last_to_clear:
			_clear_block(block, i)

func _get_block_coords(index: int) -> Vector2:
	var currentRotation = get_all_block_coords()
	return currentRotation[index]

func _clear_block(block: Block, index: int) -> void:
	block.queue_free()
	for i in _rotation_movements.size():
		var rotation_movement: Array = _rotation_movements[i]
		rotation_movement.remove(index)

func _lower_block(block: Block, index: int, num_lower: int) -> void:
	for i in _rotation_movements.size():
		var rotation_movement: Array = _rotation_movements[i]
		var block_position: Vector2 = rotation_movement[index]
		block_position.y -= num_lower
