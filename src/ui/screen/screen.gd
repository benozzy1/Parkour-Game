class_name Screen
extends Node

var _menu_state_machine: StateMachine


func _ready() -> void:
	_menu_state_machine = StateMachine.new()
	_menu_state_machine.states = UIManager.menu_states
	add_child(_menu_state_machine)
