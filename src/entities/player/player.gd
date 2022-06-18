extends CharacterBody3D

@export var walk_speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var gravity: float = 9.81

@export var camera_pivot_path: NodePath
@onready var camera_pivot: Node3D = get_node(camera_pivot_path)

@export var camera_offset_path: NodePath
@onready var camera_offset: Node3D = get_node(camera_offset_path)

@export var camera_path: NodePath
@onready var camera: Camera3D = get_node(camera_path)

@export var head_pivot_path: NodePath
@onready var head_pivot: Node3D = get_node(head_pivot_path)

@onready var state_machine: StateMachine = $StateMachine

@onready var player_animator = $PlayerAnimator

#@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var animation_tree: AnimationTree = $AnimationTree

@export var breathe_intensity_curve: Curve

var tiredness: float = 0.0


func _ready() -> void:
	if not is_multiplayer_authority():
		camera_pivot.hide()
	else:
		state_machine.set_state("air")
		$Model.set_layer(1, false)
		$Model.set_layer(2, true)


func _process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	
	$Model/HeadPivot.rotation = $Model/HeadPivot.rotation.lerp(camera_pivot.rotation, 10 * delta)
	
	_process_animation(delta)


func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	
	var h_vel = velocity * Vector3(1, 0, 1)
	var mag = h_vel.length() / 16
	if mag > tiredness:
		tiredness = mag
	tiredness = clamp(tiredness, 0, 1)
	tiredness = lerp(tiredness, 0.0, 0.125 * delta)
	print("TIREDNESS: " + str(tiredness))
	

func get_input_vector() -> Vector2:
	return Input.get_vector(
		"player_move_left",
		"player_move_right",
		"player_move_forward",
		"player_move_backward"
	).limit_length(1.0)


func get_move_vector() -> Vector3:
	var input_vector: Vector2 = get_input_vector()
	var move_vector: Vector3 = (Vector3(input_vector.x, 0, input_vector.y)).rotated(Vector3.UP, camera_pivot.rotation.y)
	return move_vector


func get_local_velocity() -> Vector3:
	return velocity.rotated(Vector3.UP, -camera_pivot.rotation.y)


func _on_state_machine_state_added(state_name: String) -> void:
	#state_machine.get_node(state_name).player = self
	return
	print(state_machine.get_node(state_name))


func crouch() -> void:
	var tween = create_tween()
	tween.tween_property(animation_tree, "parameters/crouch/add_amount", 1.0, 0.25).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


func uncrouch() -> void:
	var tween = create_tween()
	tween.tween_property(animation_tree, "parameters/crouch/add_amount", 0.0, 0.25).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


func _process_animation(delta: float) -> void:
	var scale_amount = tiredness * 6 + 1
	animation_tree.set("parameters/TimeScale/scale", scale_amount)
	
	var blend_amount: float = max((1 - velocity.length() / 5), 0) * (tiredness * 0.25)
	animation_tree.set("parameters/crouch 2/blend_amount", blend_amount)
	
	var local_velocity = get_local_velocity()
	var blend_position = animation_tree.get("parameters/crouch 3/blend_position")
	animation_tree.set("parameters/crouch 3/blend_position", blend_position.lerp(Vector2(local_velocity.x, -local_velocity.z) / 30, 5 * delta))
