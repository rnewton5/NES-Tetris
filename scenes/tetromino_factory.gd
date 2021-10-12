class_name TetrominoFactory

const _packed_scenes := [
	preload("res://scenes/tetrominos/tetromino_i.tscn"),
	preload("res://scenes/tetrominos/tetromino_j.tscn"),
	preload("res://scenes/tetrominos/tetromino_l.tscn"),
	preload("res://scenes/tetrominos/tetromino_o.tscn"),
	preload("res://scenes/tetrominos/tetromino_s.tscn"),
	preload("res://scenes/tetrominos/tetromino_t.tscn"),
	preload("res://scenes/tetrominos/tetromino_z.tscn"),
]

static func get_random() -> Tetromino:
	var index = rand_range(0, _packed_scenes.size())
	var scene: PackedScene = _packed_scenes[index]
	return scene.instance() as Tetromino
