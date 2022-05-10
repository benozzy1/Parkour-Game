extends Node

@onready var screens: Node = $Screens
@onready var _fade_rect: ColorRect = $CanvasLayer/FadeRect

@onready var screen_states: Dictionary = {
	#"splash": preload().instantiate(),
	#"main": preload().instantiate(),
	#"pause": preload().instantiate(),
}
@onready var menu_states: Dictionary = {
}


func load_screen(screen_name: String) -> void:
	pass


func fade_transition(duration: float, callable: Callable) -> void:
	_fade_rect.show()
	
	var tween: Tween = create_tween()
	tween.tween_property(
		_fade_rect,
		"modulate:a",
		1.0,
		duration,
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	tween.tween_callback(callable)
	
	tween.tween_property(
		_fade_rect,
		"modulate:a",
		0.0,
		duration,
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(_fade_rect.hide)
