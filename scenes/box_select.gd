extends Node2D

export var padding := 1
export var cell_height := 16
export var cell_width := 16
export var num_cols := 5
export var num_rows := 2
export var active := false setget set_active

var _cur_value := 0
var _min_value := 0
var _max_value := 0


func _ready() -> void:
	_max_value = (num_cols * num_rows) - 1


func _process(_delta: float) -> void:
	if !active:
		return

	if Input.is_action_just_pressed("ui_up"):
		_cur_value = max(_min_value, _cur_value - num_cols) as int
	if Input.is_action_just_pressed("ui_down"):
		_cur_value = min(_max_value, _cur_value + num_cols) as int
	if Input.is_action_just_pressed("ui_left"):
		_cur_value = max(_min_value, _cur_value - 1) as int
	if Input.is_action_just_pressed("ui_right"):
		_cur_value = min(_max_value, _cur_value + 1) as int

	_update_background_postion()


func get_value() -> int:
	return _cur_value


func set_active(value: bool) -> void:
	active = value
	if active:
		$FlashTimer.start()
	else:
		$FlashTimer.stop()
		$Background.show()


func _update_background_postion() -> void:
	var x = _cur_value % num_cols as int
	var y = _cur_value / num_cols as int
	x *= $Background.rect_size.x
	y *= $Background.rect_size.y
	x += padding
	y += padding
	$Background.set_position(Vector2(x, y))


func _on_FlashTimer_timeout() -> void:
	if $Background.visible:
		$Background.hide()
	else:
		$Background.show()
