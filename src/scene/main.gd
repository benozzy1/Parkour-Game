extends Node


func _ready() -> void:
	GameManager.state_machine.set_state("loading")
