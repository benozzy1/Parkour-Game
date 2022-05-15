extends BaseState


func _ready() -> void:
	print("GAME: ENTER LOADING STATE")
	await get_tree().create_timer(0.1).timeout
	GameManager.state_machine.set_state("home")


func _exit_state() -> void:
	print("GAME: EXIT LOADING STATE")
