extends BaseState


func _enter_state() -> void:
	print("GAME: ENTER INGAME STATE")
	get_tree().change_scene("res://src/maps/test_map.tscn")
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent) -> void:
	if not Console.toggled:
		if event.is_action_pressed("open_console"):
			Console.open()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		if event.is_action_pressed("ui_cancel"):
			Console.close()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _exit_state() -> void:
	print("GAME: EXIT INGAME STATE")
	multiplayer.server_disconnected.disconnect(_on_server_disconnected)
	get_tree().change_scene("res://src/main/main.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_server_disconnected() -> void:
	print("SERVER DISCONNECTED")
	GameManager.state_machine.set_state("loading")
	return


func toggle_cursor() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED)
