extends Node

signal player_connected(id)

const DEFAULT_IP = "127.0.0.1";
const DEFAULT_PORT = 35555;
const PLAYER_COUNT = 4;

var players = {}
var selfData = { name: "" }

func _ready():
	pass # Replace with function body.

func createServer(username, port):
	if get_tree().get_network_peer():
		push_error("server already created")
		
	selfData.name = username;
	players[1] = selfData;
	
	var peer = NetworkedMultiplayerENet.new()
	var err = peer.create_server(port, PLAYER_COUNT)
	if err:
		push_error(err)
	get_tree().set_network_peer(peer)

func connectToServer(username, ip, port):
	if get_tree().get_network_peer():
		push_error("server already created")
		
	selfData.name = username;
	
	get_tree().connect('connected_to_server', self, "onConnectToServer")
	
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ip, port)
	get_tree().set_network_peer(peer)
	#get_tree().multiplayer.connect('network_peer_packet', self, '_onPacketReceived')

func onConnectToServer():
	players[get_tree().get_network_unique_id()] = selfData;
	rpc("sendPlayerData", selfData)

remotesync func sendPlayerData(data):
	var id = get_tree().get_rpc_sender_id()
	if get_tree().is_network_server():
		for peerID in players:
			rpc_id(id, "sendPlayerData", peerID, players[peerID])
	players[id] = data
	
	emit_signal("player_connected", id)
	
	#initialize player
	
	
	
	
	
	