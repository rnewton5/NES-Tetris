extends Node2D

export var block_size := 8
export var width := 10
export var height := 20

func _ready() -> void:
	var tetromino_factory = TetrominoFactory.new()
	var rand_tetromino = tetromino_factory.get_random()
	add_child(rand_tetromino)
	pass
