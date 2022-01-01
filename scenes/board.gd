tool
extends Node2D
class_name Board

export(String, "A TYPE", "B TYPE") var board_type := "A TYPE"

var _board_a_texture: Texture = preload("res://images/board_a.png")
var _board_b_texture: Texture = preload("res://images/board_b.png")


func _ready() -> void:
	randomize()
	if board_type == "A TYPE":
		$ForeGround.set_texture(_board_a_texture)
	if board_type == "B TYPE":
		$ForeGround.set_texture(_board_b_texture)
	$PlayField.drop_tetromino(_get_random_tetromino())


func tick() -> void:
	$PlayField.tick()


func _get_random_tetromino() -> Tetromino:
	return TetrominoFactory.get_random()
