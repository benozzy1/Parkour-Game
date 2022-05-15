extends PlayerGroundedState

@export var idle_velocity_threshold: float = 0.01


func _enter_state() -> void:
	print("PLAYER: ENTER MOVE STATE")


func _physics_process(delta: float) -> void:
	var root_node = get_root()
	move_horizontal(base_speed, acceleration, delta)
	
	if can_jump():
		jump(jump_force)
	
	root_node.move_and_slide()
	
	if not root_node.is_on_floor():
		root_node.state_machine.set_state("air")
		return
	elif can_crouch():
		root_node.state_machine.set_state("crouch")
		return
	elif root_node.velocity.length() < idle_velocity_threshold:
		root_node.state_machine.set_state("idle")
		return
	elif Input.is_action_pressed("player_sprint"):
		root_node.state_machine.set_state("sprint")
		return


func _exit_state() -> void:
	print("PLAYER: EXIT MOVE STATE")
