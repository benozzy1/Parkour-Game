extends Node

signal command_added(name: String)
signal command_removed(name: String)
signal command_executed(name: String, args: Array)

var _commands_dict: Dictionary = {}


func _ready() -> void:
	_setup_base_commands()


func add_command(name: String, callable: Callable) -> void:
	_commands_dict[name] = callable
	command_added.emit(name)
	return self


func remove_command(name: String) -> void:
	_commands_dict.erase(name)
	command_removed.emit(name)


func execute_command(name: String, args: Array = []) -> void:
	command_executed.emit(name, args)
	
	if not _commands_dict.has(name):
		printerr("CommandManager: Command not found!")
		return
	
	_commands_dict[name].call(args)


func has_command(name: String) -> bool:
	return _commands_dict.has(name)


func get_commands() -> Array[String]:
	return _commands_dict.keys()


func _setup_base_commands() -> void:
	CommandManager.add_command("print", c_print)
	CommandManager.add_command("quit", c_quit)
	CommandManager.add_command("clear", c_clear)
	CommandManager.add_command("help", c_help)


func c_print(args: Array = []) -> void:
	if args.size() == 0:
		Console.write_line("")
		return
	
	var result: String = ""
	for arg in args:
		result += arg + " "
	Console.write_line(result)


func c_quit(args: Array = []) -> void:
	get_tree().quit()


func c_clear(args: Array = []) -> void:
	Console.clear()


func c_help(args: Array = []) -> void:
	Console.write("[indent]")
	for command in CommandManager.get_commands():
		Console.write_line(command)
	Console.write("[/indent]")
