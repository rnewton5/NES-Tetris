extends Node2D

export var block_size = 8

func _ready() -> void:
	var tetromino_factory = TetrominoFactory.new()
	var rand_tetromino = tetromino_factory.get_random()
	add_child(rand_tetromino)
	pass
