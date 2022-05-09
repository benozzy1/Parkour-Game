extends State


func _state_enter() -> void:
	print("UI: ENTER SPLASH STATE")
	$Timer.start()

func _state_exit() -> void:
	print("UI: EXIT SPLASH STATE")

func _on_timer_timeout() -> void:
	GameManager.screens.set("main")
