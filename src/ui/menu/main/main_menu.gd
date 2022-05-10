extends Menu

func _on_play_button_pressed() -> void:
	UIManager.navigate_to("play_menu")

func _on_settings_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	UIManager.clear_navigation()
