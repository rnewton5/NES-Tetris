extends Node2D

signal options_accepted(type, level, height)
signal options_backed_out

onready var active_child := $OptionsGameType


func _ready() -> void:
	pass
