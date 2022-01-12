extends Sprite

signal options_accepted
signal options_backed_out


func _ready() -> void:
	$LevelSelect.active = true


func process_input(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_rotate_counter_clockwise"):
		emit_signal("options_backed_out")
	if Input.is_action_just_pressed("ui_rotate_clockwise"):
		emit_signal("options_accepted")
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("options_accepted")
