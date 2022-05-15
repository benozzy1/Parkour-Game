extends PlayerGroundedState

@export var idle_velocity_threshold: float = 0.01


func _enter_state() -> void:
	print("PLAYER: ENTER IDLE STATE")
	var root_node = get_root()
	root_node.velocity = Vector3.ZERO
	root_node.move_and_slide()


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
	elif root_node.velocity.length() > idle_velocity_threshold:
		root_node.state_machine.set_state("move")
		return


func _exit_state() -> void:
	print("PLAYER: EXIT IDLE STATE")
