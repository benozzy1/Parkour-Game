extends Node


func _ready() -> void:
	GameManager.state_machine.push_state("loading")
