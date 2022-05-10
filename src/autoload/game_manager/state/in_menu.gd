extends State


func _state_enter(args: Array = []) -> void:
	print("GAME: ENTER INMENU STATE")


func _state_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		UIManager.state_machine.pop_state()


func _state_exit() -> void:
	print("GAME: EXIT INMENU STATE")
