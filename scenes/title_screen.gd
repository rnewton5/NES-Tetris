extends Sprite


func _ready() -> void:
	pass


func _on_StartFlashTimer_timeout() -> void:
	if $PushStartLabel.visible:
		$PushStartLabel.hide()
	else:
		$PushStartLabel.show()
