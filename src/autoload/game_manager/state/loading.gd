extends State


func _state_enter(args: Array = []) -> void:
	print("GAME: ENTER LOADING STATE")
	GameManager.state_machine.set_state("in_menu")
	UIManager.state_machine.set_state("splash_screen")


func _state_exit() -> void:
	print("GAME: EXIT LOADING STATE")
