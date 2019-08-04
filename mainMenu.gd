extends Node2D

var username:= ''

var numConnectedPlayers = 0

func _ready():
	$Start.enable()

func _onTextFieldChanged(newName):
	username = newName

func _onTextFieldEntered(newName):
	username = newName

func _onJoinButtonPressed():
	if username.length() > 3:
		$Start.disable()
		$Join/SetUp.enable()
		pass

func _onCreateButtonPressed():
	if username.length() > 3:
		$Start.disable()
		$Create/SetUp.enable()

func _onIPEntered(newIP):
	globals.serverIP = newIP

func _onPortEntered(newPort):
	globals.serverPort = newPort

func _onPlayerNumberSelected(id):
	globals.playerCount = id

func _onDoneButtonPressed(isServer):
	if isServer:
		$Create/SetUp.disable()
		$Create/Lobby.enable()
		
		$Create/Lobby/HBoxContainer/UserList.text = 'Establishing connections... \n'
		var network = NetworkedMultiplayerENet.new()
		network.create_server(globals.serverPort, globals.playerCount)
		get_tree().set_network_peer(network)
		network.connect('peer_connected', self, '_onPeerConnected')
		network.connect('peer_disconnected', self, '_onPeerDisconnected')
	else:
		$Join/SetUp.disable()
		$Join/Lobby.enable()
		
		$Join/Lobby/HBoxContainer/UserList.text = 'Establishing connection... \n'
		var network = NetworkedMultiplayerENet.new()
		network.create_client(globals.serverIP, globals.serverPort)
		get_tree().set_network_peer(network)
		network.connect('connection_failed', self, '_onConnectionFailed')
		get_tree().multiplayer.connect('network_peer_packet', self, '_onPacketReceived')
	

func _onConnectionFailed(error):
	pass
	

func _onPacketReceived(packet):
	pass

func _onPeerConnected(username):
	$Create/Lobby/HBoxContainer/UserList.text += '\n' + str(username) + 'connected'
	globals.players[numConnectedPlayers] = username
	numConnectedPlayers+= 1

func _onPeerDisconnected(username):
	$Create/Lobby/HBoxContainer/UserList.text += '\n' + str(username) + 'disconnected'
	numConnectedPlayers-= 1

func _onStartGamePressed():
	if numConnectedPlayers == globals.playerCount:
		#launch game
		pass