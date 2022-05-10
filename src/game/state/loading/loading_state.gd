extends State


func _enter() -> void:
	print("GAME: ENTER LOADING STATE")
	$Timer.start()
	pass


func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	pass


func _exit() -> void:
	print("GAME: EXIT LOADING STATE")
	pass


func _on_timer_timeout() -> void:
	return
	#UIManager.screens.state_machine.push_state("splash")
