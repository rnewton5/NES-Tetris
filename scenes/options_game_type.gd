extends Sprite

signal game_type_changed(type)
signal music_changed(music)
signal options_accepted(type, music)
signal options_backed_out

var _prev_selected_music_index := -1
var _prev_selected_game_type_index := -1
var _selected_music_index := 0
var _selected_game_type_index := 0
var _selected_type_data := ""
var _selected_music_data := ""

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
		_selected_music_index = max(_selected_music_index, 0) as int
	if Input.is_action_just_pressed("ui_left"):
		_selected_game_type_index -= 1
		_selected_game_type_index = max(_selected_game_type_index, 0) as int
	if Input.is_action_just_pressed("ui_right"):
		var max_index := _game_type_option_selects.size() - 1
		_selected_game_type_index += 1
		_selected_game_type_index = min(_selected_game_type_index, max_index) as int
	if Input.is_action_just_pressed("ui_rotate_counter_clockwise"):
		emit_signal("options_backed_out")
	if (
		Input.is_action_just_pressed("ui_rotate_clockwise")
		|| Input.is_action_just_pressed("ui_accept")
	):
		emit_signal("options_accepted", _selected_type_data, _selected_music_data)
	_update_selections()
	_emit_select_signals()


func _update_selections() -> void:
	for child in get_children():
		child.hide()
	_music_option_selects[_selected_music_index].show()
	_game_type_option_selects[_selected_game_type_index].show()


func _emit_select_signals() -> void:
	if _prev_selected_game_type_index != _selected_game_type_index:
		_selected_type_data = _game_type_option_selects[_selected_game_type_index].data
		emit_signal("game_type_changed", _selected_type_data)
		_prev_selected_game_type_index = _selected_game_type_index
	if _prev_selected_music_index != _selected_music_index:
		_selected_music_data = _music_option_selects[_selected_music_index].data
		emit_signal("music_changed", _selected_music_data)
		_prev_selected_music_index = _selected_music_index
