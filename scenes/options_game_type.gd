extends Sprite

signal options_accepted(type, music)
signal options_backed_out

var _selected_music_index := 0
var _selected_game_type_index := 0

onready var _music_option_selects := [
	$MusicOneOptionSelect, $MusicTwoOptionSelect, $MusicThreeOptionSelect, $MusicOffOptionSelect
]
onready var _game_type_option_selects := [$ATypeOptionSelect, $BTypeOptionSelect]


func _ready() -> void:
	_update_selections()


func process_input() -> void:
	if Input.is_action_just_pressed("ui_down"):
		var max_index := _music_option_selects.size() - 1
		_selected_music_index += 1
		_selected_music_index = min(_selected_music_index, max_index) as int
	if Input.is_action_just_pressed("ui_up"):
		_selected_music_index -= 1
		_selected_music_index = max(_selected_music_index - 1, 0) as int
	if Input.is_action_just_pressed("ui_left"):
		_selected_game_type_index -= 1
		_selected_game_type_index = max(_selected_game_type_index, 0) as int
	if Input.is_action_just_pressed("ui_right"):
		var max_index := _game_type_option_selects.size() - 1
		_selected_game_type_index += 1
		_selected_game_type_index = min(_selected_game_type_index, max_index) as int
	if Input.is_action_just_pressed("ui_rotate_counter_clockwise"):
		emit_signal("options_backed_out")
	if Input.is_action_just_pressed("ui_rotate_clockwise"):
		emit_signal("options_accepted")
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("options_accepted")
	_update_selections()


func _update_selections() -> void:
	for child in get_children():
		child.hide()
	_music_option_selects[_selected_music_index].show()
	_game_type_option_selects[_selected_game_type_index].show()
