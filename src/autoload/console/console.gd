extends Node

signal command_added(name: String)
signal command_removed(name: String)
signal command_executed(name: String, args: Array)

var command_history: Array[String] = []
var _commands_dict: Dictionary = {}


func _ready() -> void:
	add_command("print", c_print)
	add_command("bruh", c_bruh)


func add_command(name: String, callable: Callable) -> void:
	_commands_dict[name] = callable
	command_added.emit(name)
	return self


func remove_command(name: String) -> void:
	_commands_dict.erase(name)
	command_removed.emit(name)


func execute_command(name: String, args: Array = []) -> void:
	if not _commands_dict.has(name):
		printerr("Console: Command not found!")
		return
	
	if command_history.has(name):
		command_history.erase(name)
	command_history.push_front(name)
	_commands_dict[name].call(args)
	command_executed.emit(name, args)


func c_print(args: Array = []) -> void:
	var result: String = ""
	for arg in args:
		result += arg + " "
	print(result)


func c_bruh(args: Array = []) -> void:
	print("BRUHH: " + str(args.size()))
