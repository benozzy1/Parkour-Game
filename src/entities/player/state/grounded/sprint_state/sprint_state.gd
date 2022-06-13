extends PlayerGroundedState

@export var min_speed_threshold: float = base_speed / 2.0
@export var speed_multiplier: float = 1.25


func _enter_state() -> void:
	print("PLAYER: ENTER SPRINT STATE")


func _physics_process(delta: float) -> void:
	var root_node = get_root()
	move_horizontal(base_speed * speed_multiplier, acceleration, delta)
	
	if can_jump():
		jump(jump_force)
	
	root_node.move_and_slide()
	
	if not root_node.is_on_floor():
		root_node.state_machine.set_state("air")
		return
	elif can_crouch():
		root_node.state_machine.set_state("slide")
		return
	elif Input.is_action_just_released("player_sprint"):
		root_node.state_machine.set_state("ground")
		return
	elif root_node.velocity.length() < min_speed_threshold:
		root_node.state_machine.set_state("ground")
		return


func _exit_state() -> void:
	print("PLAYER: EXIT SPRINT STATE")
