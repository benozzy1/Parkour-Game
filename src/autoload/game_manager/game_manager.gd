extends Node

@onready var states: Dictionary = {
	"loading": preload("res://src/game/state/loading/loading_state.tscn").instantiate(),
	"main": preload("res://src/game/state/main/main_state.tscn").instantiate(),
	"ingame": preload("res://src/game/state/ingame/ingame_state.tscn").instantiate(),
	"paused": preload("res://src/game/state/paused/paused_state.tscn").instantiate(),
}
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	state_machine.states = states
