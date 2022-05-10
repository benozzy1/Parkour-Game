extends Control


func _on_resume_button_pressed() -> void:
	GameManager.state_machine.pop_state()
	UIManager.state_machine.clear()


func _on_main_menu_button_pressed() -> void:
	GameManager.state_machine.set_state("in_menu")
	UIManager.state_machine.set_state("main_screen")
