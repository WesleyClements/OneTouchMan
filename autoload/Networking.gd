extends Node

signal player_connected(id)

const DEFAULT_IP = "127.0.0.1";
const DEFAULT_PORT = 35555;
const PLAYER_COUNT = 4;

var players = {}
var selfData = { name: "" }

var peer: NetworkedMultiplayerENet

func _ready():
	pass # Replace with function body.

func createServer(username, port):
	if peer:
		push_error("server already created")
	selfData.name = username;
	players[1] = selfData;
	peer = NetworkedMultiplayerENet.new()
	var err = peer.create_server(port, PLAYER_COUNT)
	if err:
		push_error(err)
	get_tree().set_network_peer(peer)

func connectToServer(username, ip, port):
	if peer:
		push_error("server already created")
	addConnectedToServerListener(self, "onConnectToServer")
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().set_network_peer(peer)
	#get_tree().multiplayer.connect('network_peer_packet', self, '_onPacketReceived')

func addConnectionFailedListener(target: Object, method: String):
	var err = get_tree().connect('connection_failed', target, method)
	if err:
		push_error(err)

func addConnectedToServerListener(target: Object, method: String):
	var err = get_tree().connect('connected_to_server', target, method)
	if err:
		push_error(err)

func addNetworkPeerConnectedListener(target: Object, method: String):
	var err = get_tree().connect('network_peer_connected', target, method)
	if err:
		push_error(err)
	
func addNetworkPeerDisconnectedListener(target: Object, method: String):
	var err = get_tree().connect('network_peer_disconnected', target, method)
	if err:
		push_error(err)

func onConnectToServer():
	players[get_tree().get_network_unique_id()] = selfData;
	rpc("sendPlayerData", get_tree().get_network_unique_id(), selfData)

remote func sendPlayerData(id, data):
	if get_tree().is_network_server():
		for peerID in players:
			rpc_id(id, "sendPlayerData", peerID, players[peerID])
	players[id] = data
	
	emit_signal("player_connected", id)
	
	#initialize player
	
	
	
	
	
	