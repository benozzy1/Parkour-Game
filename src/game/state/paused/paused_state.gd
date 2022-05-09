extends State


func _state_enter() -> void:
	print("GAME: ENTER PAUSED STATE")
	pass

func _state_process(delta: float) -> void:
	pass

func _state_physics_process(delta: float) -> void:
	pass

func _state_input(event: InputEvent) -> void:
	pass

func _state_exit() -> void:
	print("GAME: EXIT PAUSED STATE")
	pass
