extends Control

func _ready():
	$Lobby/HBoxContainer/UserList.text = 'Establishing connections... \n'
	
	get_tree().connect('network_peer_connected', self, '_onPeerConnected')
	get_tree().connect('network_peer_disconnected', self, '_onPeerDisconnected')
	
	Networking.connect("player_connected", self, "_onPlayerConnected")
		
	Networking.createServer(Globals.username, Globals.port)

func _onPeerConnected(username):
	$Lobby/HBoxContainer/UserList.text += '\n' + str(username) + 'connected'

func _onPlayerConnected(id):
	$Lobby/HBoxContainer/UserList.text += '\n' + str(Networking.players[id].name) + 'connected'

func _onPeerDisconnected(username):
	$Lobby/HBoxContainer/UserList.text += '\n' + str(username) + 'disconnected'

func _onStartGamePressed():
	get_tree().change_scene("res://main.tscn")