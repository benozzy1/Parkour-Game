extends State

@export var screen_path: PackedScene
@onready var screen: Control = screen_path.instantiate()


func _state_enter(args: Array = []) -> void:
	print("UI SCREEN: ENTER SPLASH SCREEN")
	add_child(screen)

func _state_exit() -> void:
	print("UI SCREEN: EXIT SPLASH SCREEN")
	remove_child(screen)
