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


static func get_i() -> Tetromino:
	return _packed_scenes[0].instance() as Tetromino


static func get_j() -> Tetromino:
	return _packed_scenes[1].instance() as Tetromino


static func get_l() -> Tetromino:
	return _packed_scenes[2].instance() as Tetromino


static func get_o() -> Tetromino:
	return _packed_scenes[3].instance() as Tetromino


static func get_s() -> Tetromino:
	return _packed_scenes[4].instance() as Tetromino


static func get_t() -> Tetromino:
	return _packed_scenes[5].instance() as Tetromino


static func get_z() -> Tetromino:
	return _packed_scenes[6].instance() as Tetromino
