extends Control

var ipAddressEntered = false
var portEntered = false

func _onIPAddressEntered(newIP):
	globals.serverIP = newIP
	ipAddressEntered = true

func _onPortEntered(newPort):
	globals.serverPort = newPort
	portEntered = true

func _onDoneButtonPressed():
	if ipAddressEntered and portEntered:
		#connect to server and enter lobby
		pass