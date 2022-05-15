class_name BaseState
extends Node

@export var root_path: NodePath


func _enter_state() -> void:
	pass


func _exit_state() -> void:
	pass


func set_process_all(value: bool) -> void:
	set_process(value)
	set_process_input(value)
	set_physics_process(value)


func get_root() -> Node:
	return get_node(root_path)
