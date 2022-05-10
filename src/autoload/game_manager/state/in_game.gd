extends State


func _state_enter(args: Array = []) -> void:
	print("GAME: ENTER INGAME STATE")


func _state_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		print("PAUSE")
		if UIManager.state_machine._state_stack.front() and UIManager.state_machine._state_stack.front().name == "PauseScreen":
			GameManager.state_machine.pop_state()
			UIManager.state_machine.clear()
		else:
			GameManager.state_machine.push_state("in_menu")
			UIManager.state_machine.set_state("pause_screen")


func _state_exit() -> void:
	print("GAME: EXIT INGAME STATE")
