extends Control


func _on_button_pressed() -> void:
	UIManager.state_machine.push_state("play_menu")
