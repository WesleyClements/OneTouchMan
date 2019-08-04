extends Node2D

var username: String
var ip: String
var port: int

var connecting = false

func _ready():
	username = ""
	ip = Networking.DEFAULT_IP
	port = Networking.DEFAULT_PORT
	
	$Start/VBoxContainer/HBoxContainer1/IP.text = ip
	$Start/VBoxContainer/HBoxContainer1/Port.text = String(port)
	
	$Start.enable()
	$Start.visible = true;

func _onTextFieldChanged(newName):
	username = newName

func _onTextFieldEntered(newName):
	username = newName

func _onIPEntered(newIP):
	ip = newIP

func _onPortEntered(newPort):
	port = newPort

func _onJoinButtonPressed():
	if username.length() > 0:
		$Start/VBoxContainer/Error.text = ""
		
		$Start.disable()
		
		Networking.addConnectedToServerListener(self, "_onConnectedToServer")
		Networking.addConnectionFailedListener(self, "_onConnectionFailed")
		
		Networking.addNetworkPeerConnectedListener(self, '_onPeerConnected')
		Networking.addNetworkPeerDisconnectedListener(self, '_onPeerDisconnected')
		
		Networking.connectToServer(username, ip, port)
	else:
		$Start/VBoxContainer/Error.text = "Please Enter a Username"
		

func _onConnectionFailed(error):
	$Start/VBoxContainer/Error.text = "Failed to Connect"
	print($Start/VBoxContainer/Error.text)
	$Start.enable()

func _onConnectedToServer():
	$Start.visible = false;
	$Join/Lobby.enable()
	$Join/Lobby.visible = true;
	
	$Join/Lobby/HBoxContainer/UserList.text = 'Establishing connection... \n' + $Join/Lobby/HBoxContainer/UserList.text
	Networking.connect("player_connected", self, "_onPlayerConnected")
	

func _onPacketReceived(packet):
	pass

func _onCreateButtonPressed():
	if username.length() > 0:
		$Start/VBoxContainer/Error.text = ""
		
		$Start.disable()
		$Start.visible = false;
		$Create/Lobby.enable()
		$Create/Lobby.visible = true;
		
		$Create/Lobby/HBoxContainer/UserList.text = 'Establishing connections... \n'
		
		Networking.addNetworkPeerConnectedListener(self, '_onPeerConnected')
		Networking.addNetworkPeerDisconnectedListener(self, '_onPeerDisconnected')
		
		Networking.connect("player_connected", self, "_onPlayerConnected")
		
		Networking.createServer(username, port)
	else:
		$Start/VBoxContainer/Error.text = "Please Enter a Username"

func _onPeerConnected(username):
	$Create/Lobby/HBoxContainer/UserList.text += '\n' + str(username) + 'connected'

func _onPlayerConnected(id):
	$Create/Lobby/HBoxContainer/UserList.text += '\n' + str(Networking.players[id].name) + 'connected'

func _onPeerDisconnected(username):
	$Create/Lobby/HBoxContainer/UserList.text += '\n' + str(username) + 'disconnected'

func _onStartGamePressed():
	get_tree().change_scene("res://main.tscn")
	pass