extends PlayerState

@export var gravity: float = 30.0
@export var acceleration: float = 16.0


func _enter_state() -> void:
	print("PLAYER: ENTER AIR STATE")


func _physics_process(delta: float) -> void:
	var root_node = get_root()
	
	var move_dir: Vector3 = root_node.get_move_vector()
	var h_vel: Vector3 = root_node.velocity * Vector3(1, 0, 1)
	
	#h_vel = h_vel.lerp(move_dir * base_speed, acceleration * delta)
	#h_vel = Vector3.FORWARD * root_node.velocity.normalized().dot(move_dir)
	var currentSpeed = root_node.get_move_vector().dot(root_node.velocity)
	var accel = acceleration * delta
	accel = max(0.0, min(accel, 0.0 - currentSpeed))
	var strafe_vector = root_node.get_move_vector() * accel
	
	h_vel += strafe_vector
	
	root_node.velocity.x = h_vel.x
	root_node.velocity.z = h_vel.z
	
	var speed: float = root_node.velocity.dot(move_dir)
	var add_speed: float = acceleration * -speed
	add_speed = clamp(add_speed, 0, 0.75)
	
	#root_node.velocity += move_dir * add_speed
	
	root_node.velocity.y -= gravity * delta
	
	root_node.move_and_slide()
	
	if root_node.is_on_floor():
		if can_slide():
			root_node.state_machine.set_state("slide")
		elif can_crouch():
			root_node.state_machine.set_state("crouch")
		else:
			root_node.state_machine.set_state("ground")
		return


func _exit_state() -> void:
	print("PLAYER: EXIT AIR STATE")
