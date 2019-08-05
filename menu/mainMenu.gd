extends Control

var listeningForServer: bool = false

func _ready():
	$Start/VBoxContainer/Network/IP.text = Globals.ip
	$Start/VBoxContainer/Network/Port.text = String(Globals.port)

func _onTextFieldChanged(newName):
	Globals.username = newName

func _onTextFieldEntered(newName):
	Globals.username = newName

func _onIPEntered(newIP):
	Globals.ip = newIP

func _onPortEntered(newPort):
	Globals.port = newPort

func _onJoinButtonPressed():
	if Globals.username.length() > 0:
		$Start/VBoxContainer/Error.text = ""
		
		$Start.disable()
		if not listeningForServer:
			get_tree().connect('connection_failed', self, "_onConnectionFailed")
			get_tree().connect('connected_to_server', self, "_onConnectedToServer")
			get_tree().connect('server_disconnected', self, "_onDisconnectFromServer")
			listeningForServer = true
		
		Networking.connectToServer(Globals.username, Globals.ip, Globals.port)
	else:
		$Start/VBoxContainer/Error.text = "Please Enter a Username"
		

func _onConnectionFailed(error):
	print("a");
	$Start/VBoxContainer/Error.text = "Failed to Connect (" + error + ")";
	$Start.enable()

func _onConnectedToServer():
	$Start/VBoxContainer/Error.text = ""
	get_tree().change_scene("res://menu/clientLobby.tscn")

func _onDisconnectFromServer():
	print("b");
	

func _onCreateButtonPressed():
	if Globals.username.length() > 0:
		$Start/VBoxContainer/Error.text = ""
		get_tree().change_scene("res://menu/hostLobby.tscn")
	else:
		$Start/VBoxContainer/Error.text = "Please Enter a Username"