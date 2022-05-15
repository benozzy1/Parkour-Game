class_name PlayerGroundedState
extends PlayerState

@export var acceleration: float = 12.0
@export var jump_force: float = 8.0

var jump_queued: bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_jump"):
		jump_queued = true


func move_horizontal(speed: float, acceleration: float, delta: float) -> void:
	var root_node = get_root()
	var move_dir: Vector3 = root_node.get_move_vector()
	
	var h_vel: Vector3 = root_node.velocity * Vector3(1, 0, 1)
	h_vel = h_vel.lerp(move_dir * speed, acceleration * delta)
	root_node.velocity.x = h_vel.x
	root_node.velocity.z = h_vel.z


func can_jump() -> bool:
	return Input.is_action_just_pressed("player_jump") and get_root().is_on_floor() and jump_queued


func jump(force: float) -> void:
	var root_node = get_root()
	root_node.velocity += root_node.get_floor_normal() * force
	jump_queued = false
