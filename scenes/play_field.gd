extends Node2D

export var block_size := 8
export var width := 10
export var height := 20
export var hard_drop_rate := 10

onready var _hard_drop_delta := 1.0 / hard_drop_rate

var _board_state := []
var _active_tetromino: Tetromino = null
var _active_tetromino_x := 0
var _active_tetromino_y := 0
var _hard_drop_delta_acc := 0.0

enum { OCCUPIED, FREE }


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
			row.append(FREE)


func _reposition_active() -> void:
	_active_tetromino.position.x = _active_tetromino_x * block_size
	_active_tetromino.position.y = _active_tetromino_y * block_size


func _move_x(delta: int) -> void:
	var x = _active_tetromino_x + delta
	var y = _active_tetromino_y + delta
	var block_coords := _active_tetromino.get_all_block_coords()
	if _is_in_bounds(x, y, block_coords):
		$MoveSoundEffect.play()
		_active_tetromino_x += delta
		_reposition_active()


func _move_y(delta: int) -> void:
	var x = _active_tetromino_x
	var y = _active_tetromino_y + delta
	var block_coords := _active_tetromino.get_all_block_coords()
	if _is_in_bounds(x, y, block_coords):
		_active_tetromino_y += delta
		_reposition_active()


func _rotate_active_clockwise() -> void:
	var x = _active_tetromino_x
	var y = _active_tetromino_y
	var block_coords := _active_tetromino.get_clockwise_coords()
	if _is_in_bounds(x, y, block_coords):
		$RotateSoundEffect.play()
		_active_tetromino.rotate_clockwise()


func _rotate_active_counter_clockwise() -> void:
	var x = _active_tetromino_x
	var y = _active_tetromino_y
	var block_coords := _active_tetromino.get_counter_clockwise_coords()
	if _is_in_bounds(x, y, block_coords):
		$RotateSoundEffect.play()
		_active_tetromino.rotate_counter_clockwise()


func _is_in_bounds(x: int, y: int, block_coords) -> bool:
	var left_most_value = width
	var right_most_value = 0
	var bottom_most_value = 0

	for position in block_coords:
		var block_pos_x = x + position.x
		var block_pos_y = y + position.y
		left_most_value = min(left_most_value, block_pos_x)
		right_most_value = max(right_most_value, block_pos_x)
		bottom_most_value = max(bottom_most_value, block_pos_y)

	return left_most_value >= 0 && right_most_value < width && bottom_most_value < height
