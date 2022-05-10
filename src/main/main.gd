extends Node


func _ready() -> void:
	GameManager.state_machine.set_state("loading")
	
	CommandManager.add_command("print", c_print)
	CommandManager.add_command("host", c_host)
	CommandManager.add_command("connect", c_connect)
	CommandManager.add_command("quit", c_quit)


func c_print(args: Array = []) -> void:
	var result: String = ""
	for arg in args:
		result += arg + " "
	print(result)


func c_host(args: Array = []) -> void:
	var port: int = 6942
	if args.size() == 1:
		port = args[0].to_int()
	
	print("Hosting on port: %s" % [port])


func c_connect(args: Array = []) -> void:
	if args.size() < 1:
		printerr("Please specity an ip and a port to connect to")
		return
	elif args.size() >= 1:
		var ip: String = args[0]
		var port: int = "6942".to_int()
		
		if args.size() == 2:
			port = args[1].to_int()
		elif args.size() > 2:
			printerr("Too many arguments")
			return
		
		print("Connecting to %s:%s" % [ip, port])


func c_quit(args: Array = []) -> void:
	get_tree().quit()
