extends Control


func _ready() -> void:
	pass


func _on_FlashTimer_timeout() -> void:
	if $SelectArrow.visible:
		$SelectArrow.hide()
		$SelectArrow2.hide()
	else:
		$SelectArrow.show()
		$SelectArrow2.show()
