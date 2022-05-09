extends Node

@onready var menu_states: Dictionary = {
	"splash": preload("res://src/ui/state/splash/splash_state.tscn").instantiate(),
	"background": preload("res://src/ui/state/background/background_state.tscn").instantiate(),
	"main_menu": preload("res://src/ui/state/main_menu/main_menu_state.tscn").instantiate(),
	"play_menu": preload("res://src/ui/state/play_menu/play_menu_state.tscn").instantiate(),
}
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	state_machine.states = menu_states


func _on_state_exited(state_name: String) -> void:
	state_machine.pop_state()


func _process(delta: float) -> void:
	state_machine.state_process(delta)


func _physics_process(delta: float) -> void:
	state_machine.state_physics_process(delta)


func _input(event: InputEvent) -> void:
	state_machine.state_input(event)
