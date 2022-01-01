tool
extends Node2D
class_name Board

export(String, "A TYPE", "B TYPE") var board_type := "A TYPE"

var _board_a_texture: Texture = preload("res://images/board_a.png")
var _board_b_texture: Texture = preload("res://images/board_b.png")


func _ready() -> void:
	randomize()
	if board_type == "A TYPE":
		$Foreground.set_texture(_board_a_texture)
	if board_type == "B TYPE":
		$Foreground.set_texture(_board_b_texture)
	_drop_tetromino()


func tick() -> void:
	$PlayField.tick()


func _drop_tetromino() -> void:
	$PlayField.drop_tetromino(_get_random_tetromino())


func _get_random_tetromino() -> Tetromino:
	return TetrominoFactory.get_random()


func _on_PlayField_active_dropped() -> void:
	_drop_tetromino()
