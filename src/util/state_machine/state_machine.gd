class_name StateMachine
extends Node

@export var preloader_path: NodePath

var _states_dict: Dictionary = {}


func _ready() -> void:
	var preloader: ResourcePreloader = get_node(preloader_path)
	for state in preloader.get_resource_list():
		_states_dict[state] = preloader.get_resource(state).instantiate()


func set_state(state_name: String) -> void:
	clear_all_states()
	push_state(state_name)


func push_state(state_name: String) -> void:
	add_child(_states_dict[state_name])
#	if _state_stack.size() > 0 and not _state_stack.front().process_in_background: # Prevent exit twice.
#		_state_stack.front()._exit()
#
#	_state_stack.push_front(states[state_name])
#
#	add_child(_state_stack.front())
#	_state_stack.front()._enter()


func pop_state() -> void:
	get_child(get_child_count() - 1).queue_free()
#	_state_stack.front()._exit()
#	remove_child(_state_stack.front())
#
#	_state_stack.pop_front()
#
#	if _state_stack.size() > 0 and not _state_stack.front().process_in_background: # Prevent enter twice.
#		_state_stack.front()._enter()


func clear_all_states() -> void:
	for child in get_children():
		if not child is ResourcePreloader:
			child.queue_free()
