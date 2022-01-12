extends Sprite

signal start_accepted


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("start_accepted")


func _on_StartFlashTimer_timeout() -> void:
	if $PushStartLabel.visible:
		$PushStartLabel.hide()
	else:
		$PushStartLabel.show()
