extends BaseState


func _enter_state() -> void:
	print("GAME: ENTER HOME STATE")
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	Console.open()
	Console.show()


func _exit_state() -> void:
	print("GAME: EXIT HOME STATE")
	multiplayer.connected_to_server.disconnect(_on_connected_to_server)
	Console.close()


func _on_connected_to_server() -> void:
	print("SERVER: CONNECTED TO SERVER")
	GameManager.state_machine.set_state("ingame")
