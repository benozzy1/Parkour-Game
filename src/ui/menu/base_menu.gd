class_name Menu
extends Control

func _init() -> void:
	modulate.a = 0
	rect_scale = Vector2(0.75, 0.75)
	rect_pivot_offset = rect_size / 2

func tween_enter() -> void:
	var tween = create_tween()
	tween.parallel().tween_property(
		self,
		"modulate:a",
		1.0,
		0.25
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	tween.parallel().tween_property(
		self,
		"rect_scale",
		Vector2(1.0, 1.0),
		0.25
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func tween_exit() -> void:
	var tween = create_tween()
	tween.parallel().tween_property(
		self,
		"modulate:a",
		0.0,
		0.25
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	tween.parallel().tween_property(
		self,
		"rect_scale",
		Vector2(0.75, 0.75),
		0.25
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	tween.tween_callback(hide_after_animation)

func hide_after_animation():
	super.hide()
