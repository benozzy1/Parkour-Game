extends Node

@onready var screen_states: Dictionary = {
}
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	state_machine.states = screen_states

func _on_state_exited(state_name: String) -> void:
	state_machine.pop()

func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)

func _input(event: InputEvent) -> void:
	state_machine.input(event)
