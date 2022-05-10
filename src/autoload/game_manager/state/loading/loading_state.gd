extends Node


func _enter_tree() -> void:
	print("GAME: ENTER LOADING STATE")
	$Timer.start()
	pass


func _exit_tree() -> void:
	print("GAME: EXIT LOADING STATE")
	pass


func _on_timer_timeout() -> void:
	GameManager.state_machine.set_state("main")
