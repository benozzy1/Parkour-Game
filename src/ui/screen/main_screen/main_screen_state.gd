extends State

@export var screen_path: PackedScene
@onready var screen: Control = screen_path.instantiate()


func _state_enter(args: Array = []) -> void:
	print("UI SCREEN: ENTER MAIN SCREEN")
	add_child(screen)
	GameManager.state_machine.set_state("in_menu")
	UIManager.state_machine.push_state("main_menu")

func _state_exit() -> void:
	print("UI SCREEN: EXIT MAIN SCREEN")
	remove_child(screen)
