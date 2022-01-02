extends Node2D

signal active_dropped

export var block_size := 8
export var width := 10
export var height := 20
export var hard_drop_rate := 10

var _board_state := []
var _active_tetromino: Tetromino = null
var _active_tetromino_x := 0
var _active_tetromino_y := 0
var _hard_drop_delta_acc := 0.0

onready var _hard_drop_delta := 1.0 / hard_drop_rate


func _ready() -> void:
	_reset_board_state()


func _process(delta: float) -> void:
	_process_input(delta)


func drop_tetromino(tetromino: Tetromino) -> void:
	_active_tetromino = tetromino
	_active_tetromino_x = (width / 2.0) as int
	_active_tetromino_y = 0
	add_child(tetromino)
	_reposition_active()


func tick() -> void:
	_move_y(1)


func _process_input(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		_move_x(-1)
	if Input.is_action_just_pressed("ui_right"):
		_move_x(1)
	if Input.is_action_pressed("ui_down"):
		_process_hard_drop(delta)
	if Input.is_action_just_pressed("ui_rotate_clockwise"):
		_rotate_active_clockwise()
	if Input.is_action_just_pressed("ui_rotate_counter_clockwise"):
		_rotate_active_counter_clockwise()


func _process_hard_drop(delta: float) -> void:
	_hard_drop_delta_acc += delta
	if _hard_drop_delta_acc >= _hard_drop_delta:
		_move_y(1)
		_hard_drop_delta_acc = 0.0


func _reset_board_state():
	_board_state = []
	for _i in range(height):
		var row := []
		_board_state.append(row)
		for _j in range(width):
			row.append(null)


func _reposition_active() -> void:
	var x := _active_tetromino_x
	var y := _active_tetromino_y
	var position = _translate_coords_to_position(x, y)
	_active_tetromino.position = position


func _translate_coords_to_position(x: int, y: int) -> Vector2:
	return Vector2(x * block_size, y * block_size)


func _move_x(delta: int) -> void:
	if _active_tetromino == null:
		return
	var x = _active_tetromino_x + delta
	var y = _active_tetromino_y
	var block_coords := _active_tetromino.get_all_block_coords()
	if !_active_is_colliding(x, y, block_coords):
		$MoveSoundEffect.play()
		_active_tetromino_x += delta
		_reposition_active()


func _move_y(delta: int) -> void:
	if _active_tetromino == null:
		return
	var x = _active_tetromino_x
	var y = _active_tetromino_y + delta
	var block_coords := _active_tetromino.get_all_block_coords()
	if !_active_is_colliding(x, y, block_coords):
		_active_tetromino_y += delta
		_reposition_active()
	else:
		_place_active()


func _rotate_active_clockwise() -> void:
	if _active_tetromino == null:
		return
	var x = _active_tetromino_x
	var y = _active_tetromino_y
	var block_coords := _active_tetromino.get_clockwise_coords()
	if !_active_is_colliding(x, y, block_coords):
		$RotateSoundEffect.play()
		_active_tetromino.rotate_clockwise()


func _rotate_active_counter_clockwise() -> void:
	if _active_tetromino == null:
		return
	var x = _active_tetromino_x
	var y = _active_tetromino_y
	var block_coords := _active_tetromino.get_counter_clockwise_coords()
	if !_active_is_colliding(x, y, block_coords):
		$RotateSoundEffect.play()
		_active_tetromino.rotate_counter_clockwise()


func _active_is_colliding(x: int, y: int, block_coords) -> bool:
	for position in block_coords:
		var block_pos_x = x + position.x
		var block_pos_y = y + position.y
		if block_pos_x < 0 || block_pos_x >= width:
			return true
		if block_pos_y >= height:
			return true
		if block_pos_y > 0 && _board_state[block_pos_y][block_pos_x] != null:
			return true
	return false


func _place_active() -> void:
	var block_coords := _active_tetromino.get_all_block_coords()
	var blocks := _active_tetromino.get_all_blocks()
	for i in block_coords.size():
		var block_coord: Vector2 = block_coords[i]
		var block: Block = blocks[i]
		var x = _active_tetromino_x + block_coord.x
		var y = _active_tetromino_y + block_coord.y
		_board_state[y][x] = block
		_active_tetromino.remove_child(block)
		block.position = _translate_coords_to_position(x, y)
		add_child(block)

	_active_tetromino.free()
	$PlaceSoundEffect.play()
	emit_signal("active_dropped")
