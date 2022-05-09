extends State


func _state_enter() -> void:
	print("GAME: ENTER LOADING STATE")
	$Timer.start()
	pass

func _state_process(delta: float) -> void:
	pass

func _state_physics_process(delta: float) -> void:
	pass

func _state_input(event: InputEvent) -> void:
	pass

func _state_exit() -> void:
	print("GAME: EXIT LOADING STATE")
	pass

func _on_timer_timeout() -> void:
	UIManager.screens.load("splash")
