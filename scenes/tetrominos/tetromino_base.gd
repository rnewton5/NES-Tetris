extends Position2D
class_name Tetromino

var _block_width := 0.0
var _block_height := 0.0
var _rotation_movements := []
var _rotation_index := 0 setget set_rotation_index
var _center_vector := Vector2(0.0, 0.0)
var _is_centered := false
var _sprite_column := 0
var _sprite_row := 0
var _scale := 1.0
var _type := "default"

onready var _blocks := get_children()


func _ready() -> void:
	update_blocks()


func get_type() -> String:
	return _type


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
		var x = block_coords.x * _block_width
		var y = block_coords.y * _block_height
		if _is_centered:
			x += _center_vector.x * _block_width
			y += _center_vector.y * _block_height
		block.position = Vector2(x, y)
		block.apply_scale(Vector2(_scale, _scale))


func update_block_dimensions() -> void:
	var block_dimensions := get_block_dimensions()
	_block_width = _scale * block_dimensions.x
	_block_height = _scale * block_dimensions.y


func get_block_dimensions() -> Vector2:
	var block: Block = _blocks[0]
	return block.region_rect.size


func set_block_scale(scale: float) -> void:
	_scale = scale
	if _blocks != null:
		update_block_positions()


func set_centered(is_centered: bool) -> void:
	_is_centered = is_centered
	if _blocks != null:
		update_block_positions()


func get_all_block_coords() -> Array:
	return _rotation_movements[_rotation_index]


func get_clockwise_coords() -> Array:
	return get_rotation_coords(_rotation_index + 1)


func get_counter_clockwise_coords() -> Array:
	return get_rotation_coords(_rotation_index - 1)


func rotate_clockwise() -> void:
	set_rotation_index(_rotation_index + 1)


func rotate_counter_clockwise() -> void:
	set_rotation_index(_rotation_index - 1)


func set_rotation_index(value: int) -> void:
	_rotation_index = value % _rotation_movements.size()
	update_block_positions()


func get_rotation_coords(index: int) -> Array:
	index = index % _rotation_movements.size()
	return _rotation_movements[index]


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
