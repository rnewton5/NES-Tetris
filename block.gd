extends Sprite

export var sprite_width: int = 8
export var sprite_height: int = 8
export var default_sprite_mapped: Vector2 = Vector2(0, 0)

onready var _current_sprite_mapped: Vector2 = default_sprite_mapped setget set_current_sprite

func _ready() -> void:
	region_enabled = true
	_set_sprite_sheet_region()

func set_current_sprite(value: Vector2) -> void:
	_current_sprite_mapped = value
	_set_sprite_sheet_region()

func _set_sprite_sheet_region() -> void:
	var coords = _calculate_sprite_sheet_region()
	region_rect = Rect2(coords.x, coords.y, sprite_width, sprite_height)

func _calculate_sprite_sheet_region() -> Vector2:
	var x := _current_sprite_mapped.x * sprite_width
	var y := _current_sprite_mapped.y * sprite_height
	return Vector2(x, y)
