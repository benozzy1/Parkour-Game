extends Node3D

@onready var camera_animator = $CameraAnimator


func set_layer(layer: int, value: bool) -> void:
	$HeadPivot/HeadOffset/Head.set_layer_mask_value(layer, value)
	$HeadPivot/HeadOffset/Head/RightEye.set_layer_mask_value(layer, value)
	$HeadPivot/HeadOffset/Head/LeftEye.set_layer_mask_value(layer, value)
	$HeadPivot/HeadOffset/Head.set_layer_mask_value(layer, value)
	$TorsoPivot/Torso.set_layer_mask_value(layer, value)
