extends State

func _state_enter() -> void:
	print("UI: ENTER PAUSED STATE")
	UIManager.load_background("blur_background")
	UIManager.load_menu("pause_menu")

func _state_exit() -> void:
	print("UI: EXIT PAUSED STATE")
