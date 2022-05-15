extends Node

@onready var network_peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()

var connected_players: Array[int] = []


func _ready() -> void:
	CommandManager.add_command("host", c_host)
	CommandManager.add_command("connect", c_connect)
	CommandManager.add_command("disconnect", c_disconnect)
	
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.server_disconnected.connect(_on_server_disconnected)


func disconnect_from_server() -> void:
	network_peer.close_connection()
	connected_players.clear()
	multiplayer.set_multiplayer_peer(null)
	for child in NetworkManager.get_children():
		child.queue_free()


func c_host(args: Array = []) -> void:
	if multiplayer.multiplayer_peer:
		Console.write_line("[[color=red]ERROR[/color]] Already connected to a server")
		return
	
	var port: int = 6942
	if args.size() == 1:
		port = args[0].to_int()
	
	var err: int = network_peer.create_server(port)
	
	if err != OK:
		Console.write_line("[[color=red]ERROR[/color]] Could not create server")
		return
	
	multiplayer.set_multiplayer_peer(network_peer)
	
	multiplayer.connected_to_server.emit()
	connected_players.append(1)
	
	Console.write_line("[[color=dark_gray]INFO[/color]] Hosting on port: %s" % [port])


func c_connect(args: Array = []) -> void:
	if multiplayer.multiplayer_peer:
		Console.write_line("[[color=red]ERROR[/color]] Already connected to a server")
		return
	
	if args.size() < 1:
		Console.write_line("[[color=red]ERROR[/color]] Please specify an ip to connect to")
		return
	elif args.size() >= 1:
		var ip: String = args[0]
		var port: int = "6942".to_int()
		
		if args.size() == 2:
			port = args[1].to_int()
		elif args.size() > 2:
			Console.write_line("[[color=red]ERROR[/color]]Too many arguments")
			return
		
		var err: int = network_peer.create_client(ip, port)
		
		if err != OK:
			Console.write_line("[[color=red]ERROR[/color]] Could not connect to server")
		
		multiplayer.set_multiplayer_peer(network_peer)
		connected_players.append(multiplayer.get_unique_id())
		
		Console.write_line("[[color=dark_gray]INFO[/color]] Connecting to %s:%s" % [ip, port])


func c_disconnect(args: Array = []) -> void:
	if multiplayer.multiplayer_peer:
		disconnect_from_server()
		multiplayer.server_disconnected.emit()
		Console.write_line("[[color=dark_gray]INFO[/color]] Disconnected from server")
	else:
		Console.write_line("[[color=red]ERROR[/color]] There is no server to disconnect from")


func _on_connected_to_server() -> void:
	Console.write_line("[[color=green]OK[/color]] Connected to server")


func _on_peer_connected(id: int) -> void:
	print("PEER CONNECTED: " + str(id))
	connected_players.append(id)
	
	if multiplayer.is_server():
		Console.write_line("[[color=dark_gray]INFO[/color]] '%s' connected to the server" % [id])


func _on_peer_disconnected(id: int) -> void:
	connected_players.erase(id)
	
	if multiplayer.is_server():
		Console.write_line("[[color=dark_gray]INFO[/color]] '%s' disconnected from the server" % [id])


func _on_server_disconnected() -> void:
	disconnect_from_server()
