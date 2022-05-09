class_name StateMachine
extends Node

var states: Dictionary = {}

var _state_stack: Array[State] = []


func process(delta: float) -> void:
	for state in _get_active_states():
		state._state_process(delta)


func physics_process(delta: float) -> void:
	for state in _get_active_states():
		state._state_physics_process(delta)


func input(input: InputEvent) -> void:
	for state in _get_active_states():
		state._state_input(input)



func push_state(state_name: String) -> void:
	if _state_stack.size() > 0 and not _state_stack.front().process_in_background: # Prevent exit twice.
		_state_stack.front()._state_exit()
		
	_state_stack.push_front(states[state_name])
	
	add_child(_state_stack.front())
	_state_stack.front()._state_enter()


func pop_state() -> void:
	_state_stack.front()._state_exit()
	remove_child(_state_stack.front())
	
	_state_stack.pop_front()
	
	if _state_stack.size() > 0 and not _state_stack.front().process_in_background: # Prevent enter twice.
		_state_stack.front()._state_enter()


func clear_all_states() -> void:
	for i in _state_stack.size():
		pop_state()



func _get_active_states() -> Array[State]:
	var active_states: Array[State] = []
	for i in _state_stack.size():
		var state: State = _state_stack[i]
		if i == 0:
			active_states.push_back(state)
		else:
			if state.process_in_background:
				active_states.push_back(state)
	return active_states
