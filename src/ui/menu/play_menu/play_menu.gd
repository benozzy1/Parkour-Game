extends Control


func _on_play_button_pressed() -> void:
	GameManager.state_machine.set_state("in_game")
	UIManager.state_machine.clear()

func _on_back_button_pressed() -> void:
	UIManager.state_machine.pop_state()
