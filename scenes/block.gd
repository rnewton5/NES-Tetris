extends Sprite
class_name Block

export var individual_sprite_width := 8
export var individual_sprite_height := 8
export var default_sprite_coords := Vector2(0, 0)

func _ready() -> void:
	region_enabled = true
	_set_sprite_sheet_region(default_sprite_coords)

func set_current_sprite(sprite_coords: Vector2) -> void:
	_set_sprite_sheet_region(sprite_coords)

func _set_sprite_sheet_region(sprite_coords: Vector2) -> void:
	var x := sprite_coords.x * individual_sprite_width
	var y := sprite_coords.y * individual_sprite_height
	region_rect = Rect2(x, y, individual_sprite_width, individual_sprite_height)
	
