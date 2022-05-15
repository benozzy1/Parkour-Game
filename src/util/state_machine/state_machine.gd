class_name StateMachine
extends Node

signal state_added(state_name: String)
signal state_removed(state_name: String)

@export var root_path: NodePath

@export var state_parent_path: NodePath
@onready var state_parent: Node = get_node(state_parent_path)

var _active_states: Array[String] = []
var _state_history: Array[String] = []
var _states_dict: Dictionary = {}


func _ready() -> void:
	for child in state_parent.get_children():
		var state_name: String = str(child.name).to_lower()
		child.set_process_all(false)
		child.name = state_name
		_states_dict[state_name] = child


func set_state(state_name: String) -> void:
	clear_states()
	
	#_state_history.push_front(state_name)
	_active_states.push_front(state_name)
	
	var state_node = _get_state_node(state_name)
	state_node.set_process_all(true)
	state_node._enter_state()
	state_added.emit(state_name)


func push_state(state_name: String) -> void:
	#_state_history.push_front(state_name)
	_active_states.push_front(state_name)
	
	var state_node = _get_state_node(state_name)
	state_node.set_process_all(true)
	state_node._enter_state()
	state_added.emit(state_name)


func pop_state() -> void:
	var current_state: String = get_current_state()
	_active_states.erase(current_state)
	_state_history.push_front(current_state)
	
	var state = _get_state_node(current_state)
	state.set_process_all(false)
	state._exit_state()
	state_removed.emit(str(state.name))


func clear_states() -> void:
	for state in state_parent.get_children():
		if _active_states.has(str(state.name)):
			_active_states.erase(str(state.name))
			_state_history.push_front(str(state.name))
			
			state.set_process_all(false)
			state._exit_state()
			state_removed.emit(str(state.name))


func has_state(state_name) -> bool:
	if _active_states.size() > 0:
		return _active_states.has(state_name)
	return false


func get_current_state() -> String:
	if _active_states.size() == 0:
		return ""
	
	return _active_states[0]


func get_previous_state() -> String:
	if _state_history.size() == 0:
		return ""
	
	return _state_history[0]


func _get_state_node(state_name: String) -> Node:
	return state_parent.get_node(state_name)
