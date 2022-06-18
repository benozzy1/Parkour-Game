extends PlayerGroundedState

@export var acceleration_curve: Curve = Curve.new()
@export var slide_acceleration: float = 16.0
@export var min_slide_speed: float = 2.0

var apply_friction: bool = false


func _enter_state() -> void:
	print("PLAYER: ENTER SLIDE STATE")
	
	get_root().crouch()
	
	await get_tree().create_timer(0.5).timeout
	if get_root().state_machine.has_state("slide"):
		apply_friction = true


func _process(delta: float) -> void:
	return
	#var h_vel: Vector3 = root_node.velocity * Vector3(1, 0, 1)
	#root_node.get_camera().fov = lerp(root_node.get_camera().fov, 75 + (h_vel.length() - 2.0), 10 * delta)


func _physics_process(delta: float) -> void:
	var root_node = get_root()
	
	var h_vel = root_node.velocity * Vector3(1, 0, 1)
	
	var currentSpeed = root_node.get_move_vector().dot(root_node.velocity)
	var accel = slide_acceleration * delta
	accel = max(0.0, min(accel, 0.0 - currentSpeed))
	var strafe_vector = root_node.get_move_vector() * accel
	
	if can_jump():
		root_node.state_machine.set_state("air")
		root_node.velocity += root_node.velocity.normalized() * acceleration_curve.interpolate(root_node.velocity.length() / 20) * 2
		root_node.velocity += root_node.get_floor_normal() * jump_force
		root_node.move_and_slide()
		get_root().uncrouch()
		return
	
	h_vel += strafe_vector
	#h_vel += root_node.get_move_vector() * 5 * delta
	
	if apply_friction:
		var friction: float = 0.99
		var friction_ratio: float = 1.0 / (1.0 + (delta * friction))
		h_vel *= friction_ratio
	
	root_node.velocity.x = h_vel.x
	root_node.velocity.z = h_vel.z
	
	#var dot = root_node.velocity.normalized().dot(-root_node.get_floor_normal())
	var slope_speed = -root_node.velocity.normalized().dot(-root_node.get_floor_normal()) * 50
	root_node.velocity += root_node.velocity.normalized() * slope_speed * delta
	
	root_node.move_and_slide()
	
	if not root_node.is_on_floor():
		root_node.state_machine.set_state("air")
		get_root().uncrouch()
		return
	elif not can_crouch():
		root_node.state_machine.set_state("ground")
		get_root().uncrouch()
		return
	elif root_node.velocity.length() < min_slide_speed:
		root_node.state_machine.set_state("crouch")
		return


func move_slide(delta: float) -> void:
	var root_node = get_root()
	root_node.velocity = root_node.velocity.lerp(root_node.get_move_vector() * Vector3(1, 0, 0), 0.75 * delta)
	root_node.move_and_slide()


func _exit_state() -> void:
	print("PLAYER: EXIT SLIDE STATE")
	apply_friction = false
