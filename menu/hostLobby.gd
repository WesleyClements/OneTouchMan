extends Label

#each player has a username, ip address, and socket object

var numConnectedPlayers = 0

#create waiting socket
#remember addresses of new connections, then receive player data from them
#update lobby screen and send updated player list to all connected players
#player clients receive this data and update their lobby screens
#once numConnectedPlayers equals numExpectedPlayers, hit done to start the game
#this sends the initial gamestate to the player clients

func _ready():
	text = 'Establishing connections... \n'
	var network = NetworkedMultiplayerENet.new()
	network.create_server(globals.serverPort, globals.playerCount)
	get_tree().set_network_peer(network)
	network.connect('peer_connected', self, '_onPeerConnected')
	network.connect('peer_disconnected', self, '_onPeerDisconnected')

func _onPeerConnected(username):
	text = text + '\n' + str(username) + 'connected'
	globals.players[numConnectedPlayers] = username
	numConnectedPlayers+= 1

func _onPeerDisconnected(username):
	text = text + '\n' + str(username) + 'disconnected'
	numConnectedPlayers-= 1

func _onStartGamePressed():
	if numConnectedPlayers == globals.playerCount:
		#launch game
		pass