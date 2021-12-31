extends Node2D

export var block_size := 8
export var width := 10
export var height := 20

var _board_state := []
var _active_tetromino: Tetromino = null
var _active_tetromino_x := 0
var _active_tetromino_y := 0

enum { OCCUPIED, FREE }


func _ready() -> void:
	randomize()
	reset_board_state()
	drop_tetromino(_get_random_tetromino())


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		move_x(-1)
	if Input.is_action_just_pressed("ui_right"):
		move_x(1)


func reset_board_state():
	_board_state = []
	for _i in range(height):
		var row := []
		_board_state.append(row)
		for _j in range(width):
			row.append(FREE)


func drop_tetromino(tetromino: Tetromino) -> void:
	_active_tetromino = tetromino
	_active_tetromino_x = (width / 2.0) as int
	_active_tetromino_y = 0
	add_child(tetromino)
	_reposition_active()


func _reposition_active() -> void:
	_active_tetromino.position.x = _active_tetromino_x * block_size
	_active_tetromino.position.y = _active_tetromino_y * block_size


func move_x(delta: int) -> void:
	_active_tetromino_x += delta
	_reposition_active()


func tick() -> void:
	_active_tetromino_y += 1
	_reposition_active()


func _get_random_tetromino() -> Tetromino:
	return TetrominoFactory.get_random()
