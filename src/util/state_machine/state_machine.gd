class_name StateMachine
extends Node

var _state_stack: Array[State] = []

## Calls the process method on all active states.
func process(delta: float) -> void:
	for state in _get_active_states():
		state._state_process(delta)

## Calls the physics process method on all active states.
func physics_process(delta: float) -> void:
	for state in _get_active_states():
		state._state_physics_process(delta)

## Calls the input method on all active states.
func input(input: InputEvent) -> void:
	for state in _get_active_states():
		state._state_input(input)

## Push new state onto the stack.
func push(state: State) -> void:
	if _state_stack.size() > 0 and not _state_stack.front().process_in_background: # Prevent exit twice.
		_state_stack.front()._state_exit()
	_state_stack.push_front(state)
	_state_stack.front()._state_enter()

## Pop latest state from the stack.
func pop() -> void:
	_state_stack.front()._state_exit()
	_state_stack.pop_front()
	if _state_stack.size() > 0 and not _state_stack.front().process_in_background: # Prevent enter twice.
		_state_stack.front()._state_enter()

# Returns all active states.
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
