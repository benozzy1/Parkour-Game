class_name State
extends Node

@export var process_in_background: bool = false


# Called when the state is entered.
func _state_enter() -> void:
	pass


# Called every state frame. 'delta' is the elapsed time since the previous frame.
func _state_process(delta: float) -> void:
	pass


# Called every state physics frame. 'delta' is the elapsed time since the previous frame.
func _state_physics_process(delta: float) -> void:
	pass


# Called every state input frame. 'input' is the any input event.
func _state_input(input: InputEvent) -> void:
	pass


# Called when the state is exited.
func _state_exit() -> void:
	pass
