extends State

@export var menu_path: PackedScene
@onready var menu: Control = menu_path.instantiate()


func _state_enter(args: Array = []) -> void:
	print("UI MENU: ENTER MAIN MENU")
	add_child(menu)

func _state_exit() -> void:
	print("UI MENU: EXIT MAIN MENU")
	remove_child(menu)
