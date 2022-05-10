extends State

@export var screen_path: PackedScene
@onready var screen: Control = screen_path.instantiate()


func _state_enter(args: Array = []) -> void:
	print("UI SCREEN: ENTER PAUSE SCREEN")
	add_child(screen)
	UIManager.state_machine.push_state("pause_menu")

func _state_exit() -> void:
	print("UI SCREEN: EXIT PAUSE SCREEN")
	remove_child(screen)
