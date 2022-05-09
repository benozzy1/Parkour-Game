extends State


func _state_enter() -> void:
	print("UI: ENTER MAIN STATE")
	UIManager.menus.push("main_menu")

func _state_exit() -> void:
	print("UI: EXIT MAIN STATE")
	UIManager.menus.clear()
 
