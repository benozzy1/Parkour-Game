extends PlayerGroundedState

@export var speed_multiplier: float = 0.25


func _enter_state() -> void:
	print("PLAYER: ENTER CROUCH STATE")
	var root_node = get_root()
	if root_node.state_machine.get_previous_state() != "slide":
		get_root().crouch()


func _physics_process(delta: float) -> void:
	var root_node = get_root()
	
	move_horizontal(base_speed * speed_multiplier, acceleration, delta)
	
	if can_jump():
		jump(jump_force)
	
	root_node.move_and_slide()
	
	var new_state: Node = null
	if not root_node.is_on_floor():
		new_state = root_node.state_machine.set_state("air")
		root_node.uncrouch()
	elif Input.is_action_just_released("player_crouch"):
		new_state = root_node.state_machine.set_state("move")
		root_node.uncrouch()
	#new_state._enter_tree()


func _exit_state() -> void:
	print("PLAYER: EXIT CROUCH STATE")
	get_root().uncrouch()
