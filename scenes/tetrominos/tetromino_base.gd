extends Position2D
class_name Tetromino

onready var _blocks := get_children()

var _block_width := 0
var _block_height := 0
var _rotation_movements := []
var _rotation_index := 0 setget set_rotation_index
var _sprite_column := 0
var _sprite_row := 0


func update_blocks() -> void:
	update_block_positions()
	update_block_sprites()


func update_block_sprites() -> void:
	for i in _blocks.size():
		var block = _blocks[i]
		var sprite_coords := Vector2(_sprite_column, _sprite_row)
		block.set_current_sprite(sprite_coords)


func update_block_positions() -> void:
	update_block_dimensions()
	for i in _blocks.size():
		var block = _blocks[i]
		var block_coords: Vector2 = _get_block_coords(i)
		var x = block_coords.x
		var y = block_coords.y
		block.position = Vector2(x * _block_width, y * _block_height)


func update_block_dimensions() -> void:
	var block_dimensions := get_block_dimensions()
	_block_width = block_dimensions.x as int
	_block_height = block_dimensions.y as int


func get_block_dimensions() -> Vector2:
	var block: Block = _blocks[0]
	return block.region_rect.size


func get_all_block_coords() -> Vector2:
	return _rotation_movements[_rotation_index]


func rotate_clockwise() -> void:
	set_rotation_index(_rotation_index + 1)


func rotate_counter_clockwise() -> void:
	set_rotation_index(_rotation_index - 1)


func set_rotation_index(value: int) -> void:
	_rotation_index = value % _rotation_movements.size()
	update_block_positions()


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
