extends Menu

func _on_timer_timeout() -> void:
	UIManager.fade_transition(1.0, load_main)

func load_main() -> void:
	print("LOAD MAIN MENU")
	UIManager.clear_navigation()
	UIManager.navigate_to("background")
	UIManager.navigate_to("main_menu")
