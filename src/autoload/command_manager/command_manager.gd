extends Node

signal command_added(name: String)
signal command_removed(name: String)
signal command_executed(name: String, args: Array)

var _commands_dict: Dictionary = {}


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
	
	_commands_dict[name].call(args)
	command_executed.emit(name, args)
