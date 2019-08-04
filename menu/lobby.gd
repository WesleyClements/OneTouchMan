extends Label

func _ready():
	text = 'Establishing connection... \n'
	var network = NetworkedMultiplayerENet.new()
	network.create_client(globals.serverIP, globals.serverPort)
	get_tree().set_network_peer(network)
	network.connect('connection_failed', self, '_onConnectionFailed')
	get_tree().multiplayer.connect('network_peer_packet', self, '_onPacketReceived')
	

func _onConnectionFailed(error):
	pass
	

func _onPacketReceived(packet):
	pass