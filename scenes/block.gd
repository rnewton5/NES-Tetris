tool
extends Sprite
class_name Block

export var individual_sprite_width := 8
export var individual_sprite_height := 8
export var num_columns := 4
export var num_rows := 10
export var default_sprite_coords := Vector2.ZERO

var _sprite_coords := Vector2.ZERO


func _ready() -> void:
	region_enabled = true
	_set_sprite_sheet_region(default_sprite_coords)
	var _discard = Events.connect("level_up", self, "_on_Level_up")


func set_current_sprite(sprite_coords: Vector2) -> void:
	_sprite_coords = sprite_coords
	update_current_sprite()


func set_sprite_row(row: int) -> void:
	_sprite_coords.y = row
	update_current_sprite()


func set_sprite_column(col: int) -> void:
	_sprite_coords.x = col
	update_current_sprite()


func update_current_sprite() -> void:
	_set_sprite_sheet_region(_sprite_coords)


func set_clear_sprite(level: int) -> void:
	var x := (num_columns - 1) * individual_sprite_width
	var y := level * individual_sprite_height
	region_rect = Rect2(x, y, individual_sprite_width, individual_sprite_height)


func _set_sprite_sheet_region(sprite_coords: Vector2) -> void:
	var x := sprite_coords.x * individual_sprite_width
	var y := sprite_coords.y * individual_sprite_height
	region_rect = Rect2(x, y, individual_sprite_width, individual_sprite_height)


func _on_Level_up(level: int) -> void:
	set_sprite_row(level % num_rows)
