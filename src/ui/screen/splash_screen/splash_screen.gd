extends Control


func _on_timer_timeout() -> void:
	UIManager.state_machine.set_state("main_screen")
