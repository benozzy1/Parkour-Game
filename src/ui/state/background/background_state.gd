extends State


func _state_enter() -> void:
	print("UI: ENTER BACKGROUND STATE")
	pass

func _state_process(delta: float) -> void:
	pass

func _state_physics_process(delta: float) -> void:
	pass

func _state_input(event: InputEvent) -> void:
	pass

func _state_exit() -> void:
	print("UI: EXIT BACKGROUND STATE")
	pass
