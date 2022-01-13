extends Sprite

signal options_accepted(level)
signal options_backed_out


func _ready() -> void:
	$LevelSelect.active = true


func process_input() -> void:
	$LevelSelect.process_input()
	if Input.is_action_just_pressed("ui_rotate_counter_clockwise"):
		emit_signal("options_backed_out")
	if (
		Input.is_action_just_pressed("ui_rotate_clockwise")
		|| Input.is_action_just_pressed("ui_accept")
	):
		var level = $LevelSelect.get_value()
		emit_signal("options_accepted", level)
