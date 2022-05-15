extends Node3D


func _process(delta: float) -> void:
	var velocity: Vector3 = owner.velocity / 15
	$TorsoPivot.rotation = $TorsoPivot.rotation.lerp(
		Vector3(velocity.z, 0, -velocity.x),
		5 * delta
	)


func set_layer(layer: int, value: bool) -> void:
	$HeadPivot/Head.set_layer_mask_value(layer, value)
	$HeadPivot/Head/RightEye.set_layer_mask_value(layer, value)
	$HeadPivot/Head/LeftEye.set_layer_mask_value(layer, value)
	$HeadPivot/Head.set_layer_mask_value(layer, value)
	$TorsoPivot/Torso.set_layer_mask_value(layer, value)
