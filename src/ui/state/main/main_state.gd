extends State


func _enter() -> void:
	print("UI: ENTER MAIN STATE")
	UIManager.menus.push_menu("main_menu")


func _exit() -> void:
	print("UI: EXIT MAIN STATE")
	UIManager.menus.clear()
 
