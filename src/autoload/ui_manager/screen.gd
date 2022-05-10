extends Node

@onready var screen_states: Dictionary = {
}
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	state_machine.states = screen_states


func _on_state_exited(state_name: String) -> void:
	state_machine.pop()
