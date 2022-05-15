class_name PlayerState
extends BaseState

@export var base_speed: float = 5.0


func _process(delta: float) -> void:
	if Console.toggled:
		set_process_input(false)
		if get_root().state_machine.get_current_state() != "idle":
			get_root().state_machine.set_state("idle")
	else:
		set_process_input(true)


func can_crouch() -> bool:
	return Input.is_action_pressed("player_crouch")


func can_slide() -> bool:
	return can_crouch() and get_root().velocity.length() > base_speed
