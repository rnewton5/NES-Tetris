extends Node2D

signal active_dropped

var Block := preload("res://scenes/block.tscn")

export var block_size := 8
export var width := 10
export var height := 20
export var hard_drop_rate := 10

var _board_state := []
var _active_tetromino: Tetromino = null
var _active_tetromino_x := 0
var _active_tetromino_y := 0
var _hard_drop_delta_acc := 0.0
var _rows_being_cleared := []
var _clear_index := 0
var _level := 0

onready var _hard_drop_delta := 1.0 / hard_drop_rate


func _ready() -> void:
	var _discard = Events.connect("level_up", self, "_on_Level_up")
	$DropTimer.wait_time = _get_drop_time_for_level(_level)
	_reset_board_state()


func _process(_delta: float) -> void:
	_process_input()


func drop_tetromino(tetromino: Tetromino) -> void:
	_active_tetromino = tetromino
	_active_tetromino_x = (width / 2.0) as int
	_active_tetromino_y = 0
	add_child(tetromino)
	_reposition_active()


func tick() -> void:
	_move_y(1)


func _process_input() -> void:
	if Input.is_action_just_pressed("ui_left"):
		_move_x(-1)
	if Input.is_action_just_pressed("ui_right"):
		_move_x(1)
	if Input.is_action_just_pressed("ui_down"):
		_set_is_hard_dropping(true)
	if Input.is_action_just_released("ui_down"):
		_set_is_hard_dropping(false)
	if Input.is_action_just_pressed("ui_rotate_clockwise"):
		_rotate_active_clockwise()
	if Input.is_action_just_pressed("ui_rotate_counter_clockwise"):
		_rotate_active_counter_clockwise()


func _set_is_hard_dropping(value: bool) -> void:
	$DropTimer.stop()
	if value:
		$DropTimer.wait_time = _get_drop_time_for_level(28)
	else:
		$DropTimer.wait_time = _get_drop_time_for_level(_level)
	$DropTimer.start()


func _reset_board_state():
	_board_state = []
	for _i in range(height):
		_prepend_board_row()


func _prepend_board_row():
	var row := []
	_board_state.push_front(row)
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
	elif _active_tetromino_y == 0:
		_process_game_over()
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
	$PlaceSoundEffect.play()
	var block_coords := _active_tetromino.get_all_block_coords()
	var blocks := _active_tetromino.get_all_blocks()
	var rows_to_check := {}
	for i in block_coords.size():
		var block_coord: Vector2 = block_coords[i]
		var block: Block = blocks[i]
		var x = _active_tetromino_x + block_coord.x
		var y = _active_tetromino_y + block_coord.y
		_board_state[y][x] = block
		_active_tetromino.remove_child(block)
		block.position = _translate_coords_to_position(x, y)
		add_child(block)
		if !rows_to_check.has(y):
			rows_to_check[y] = true

	_rows_being_cleared = _get_rows_to_clear()
	if _rows_being_cleared.size() == 0:
		var type = _active_tetromino.get_type()
		_active_tetromino.free()
		emit_signal("active_dropped", type, 0)
	else:
		$DropTimer.stop()
		$RowClearTimer.start()


func _get_rows_to_clear():
	var rows_to_clear := []
	for y in range(height):
		var row_full = true
		for x in range(width):
			row_full = row_full && (_board_state[y][x] != null)
		if row_full:
			rows_to_clear.append(y)
	return rows_to_clear


func _lower_blocks(row_index: int, num_down: int) -> void:
	for y in range(row_index):
		for x in range(width):
			if _board_state[y][x] != null:
				_board_state[y][x].position.y += num_down * block_size

	for i in range(num_down):
		_board_state.remove(row_index - i)
		_prepend_board_row()


func _process_game_over() -> void:
	$DropTimer.stop()
	for y in range(height):
		for x in range(width):
			if _board_state[y][x] != null:
				_board_state[y][x].free()
				_board_state[y][x] = null
			var block = Block.instance()
			add_child(block)
			block.position = _translate_coords_to_position(x, y)
			block.set_clear_sprite(_level)


func _get_drop_time_for_level(level: int) -> float:
	if level == 0:
		return 43 / 60.0
	if level == 1:
		return 38 / 60.0
	if level == 2:
		return 38 / 60.0
	if level == 3:
		return 33 / 60.0
	if level == 4:
		return 28 / 60.0
	if level == 5:
		return 23 / 60.0
	if level == 6:
		return 18 / 60.0
	if level == 7:
		return 13 / 60.0
	if level == 8:
		return 8 / 60.0
	if level == 9:
		return 6 / 60.0
	if level <= 12:
		return 5 / 60.0
	if level <= 15:
		return 4 / 60.0
	if level <= 18:
		return 3 / 60.0
	if level <= 28:
		return 2 / 60.0
	return 1 / 60.0


func _on_Level_up(level: int) -> void:
	_level = level
	$DropTimer.wait_time = _get_drop_time_for_level(level)


func _on_DropTimer_timeout() -> void:
	tick()


func _on_RowClearTimer_timeout() -> void:
	for row in _rows_being_cleared:
		_board_state[row][_clear_index].free()

	_clear_index += 1
	if _clear_index == width:
		_clear_index = 0
		_lower_blocks(_rows_being_cleared[-1], 1)
		var type = _active_tetromino.get_type()
		_active_tetromino.free()
		emit_signal("active_dropped", type, _rows_being_cleared.size())
		$RowClearTimer.stop()
		$DropTimer.start()
