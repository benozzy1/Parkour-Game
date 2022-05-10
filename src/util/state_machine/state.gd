class_name State
extends Node

@export var process_in_background: bool = false


func _enter_tree() -> void:
	set_process(false)
	set_physics_process(false)
	set_process_input(false)


# Called when the state is entered.
func _enter() -> void:
	pass


# Called every state frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Called every state physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass


# Called every state input frame. 'input' is the any input event.
func _input(input: InputEvent) -> void:
	pass


# Called when the state is exited.
func exit() -> void:
	pass
