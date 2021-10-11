class_name TetriminoFactory

const _packed_scenes := [
	preload("res://scenes/tetriminos/tetrimino_i.tscn"),
	preload("res://scenes/tetriminos/tetrimino_j.tscn"),
	preload("res://scenes/tetriminos/tetrimino_l.tscn"),
	preload("res://scenes/tetriminos/tetrimino_o.tscn"),
	preload("res://scenes/tetriminos/tetrimino_s.tscn"),
	preload("res://scenes/tetriminos/tetrimino_t.tscn"),
	preload("res://scenes/tetriminos/tetrimino_z.tscn"),
]

func _init():
	randomize()

func get_random() -> Node:
	var index = rand_range(0, _packed_scenes.size())
	var scene: PackedScene = _packed_scenes[index]
	return scene.instance()
