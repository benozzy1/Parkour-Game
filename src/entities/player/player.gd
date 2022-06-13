extends CharacterBody3D

@export var walk_speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var gravity: float = 9.81

@export var camera_pivot_path: NodePath
@onready var camera_pivot: Node3D = get_node(camera_pivot_path)

@export var camera_path: NodePath
@onready var camera: Camera3D = get_node(camera_path)

@export var head_pivot_path: NodePath
@onready var head_pivot: Node3D = get_node(head_pivot_path)

@onready var state_machine: StateMachine = $StateMachine

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	if not is_multiplayer_authority():
		camera_pivot.queue_free()
	else:
		state_machine.set_state("air")
		$Model.set_layer(1, false)
		$Model.set_layer(2, true)


func _process(delta: float) -> void:
	if not is_multiplayer_authority():
		return
	
	$Model/HeadPivot.rotation = camera.rotation


func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority():
		return


func get_input_vector() -> Vector2:
	return Input.get_vector(
		"player_move_left",
		"player_move_right",
		"player_move_forward",
		"player_move_backward"
	)


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
