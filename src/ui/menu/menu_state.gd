class_name MenuState
extends State

@export var menu_scene: PackedScene

var _menu_instance: Menu

func _ready() -> void:
	_menu_instance = menu_scene.instantiate()

func _enter_state() -> void:
	add_child(_menu_instance)

func _exit_state() -> void:
	remove_child(_menu_instance)
