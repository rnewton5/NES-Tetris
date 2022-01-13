extends Sprite

signal options_accepted(level, height)
signal options_backed_out


func _ready() -> void:
	_make_level_select_active()


func process_input() -> void:
	$LevelSelect.process_input()
	$HeightSelect.process_input()
	if Input.is_action_just_pressed("ui_rotate_counter_clockwise"):
		_process_back_input()
	if (
		Input.is_action_just_pressed("ui_rotate_clockwise")
		|| Input.is_action_just_pressed("ui_accept")
	):
		_process_forward_input()


func _process_back_input() -> void:
	if $LevelSelect.active:
		emit_signal("options_backed_out")
	else:
		_make_level_select_active()


func _process_forward_input() -> void:
	if $HeightSelect.active:
		var level = $LevelSelect.get_value()
		var height = $HeightSelect.get_value()
		emit_signal("options_accepted", level, height)
	else:
		_make_height_select_active()


func _make_level_select_active() -> void:
	$LevelSelect.active = true
	$HeightSelect.active = false


func _make_height_select_active() -> void:
	$LevelSelect.active = false
	$HeightSelect.active = true
