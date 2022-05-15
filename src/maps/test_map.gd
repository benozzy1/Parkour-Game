extends Node3D


func _ready() -> void:
	multiplayer.peer_connected.connect(spawn_player)
	multiplayer.peer_disconnected.connect(despawn_player)
	for id in NetworkManager.connected_players:
		spawn_player(id)


func spawn_player(id: int) -> void:
	print("SPAWN PLAYER: " + str(id) + " AS " + str(multiplayer.get_unique_id()))
	var player_instance = preload("res://src/entities/player/player.tscn").instantiate()
	player_instance.name = str(id)
	player_instance.set_multiplayer_authority(id)
	add_child(player_instance)


func despawn_player(id: int) -> void:
	var player = get_node(str(id))
	player.queue_free()


func _exit_tree() -> void:
	multiplayer.peer_connected.disconnect(spawn_player)
	multiplayer.peer_disconnected.disconnect(despawn_player)
