extends Control

var ipAddressEntered = false
var portEntered = false
var playerCountEntered = false

func _onIPAddressEntered(newIP):
	globals.serverIP = newIP
	ipAddressEntered = true

func _onPortEntered(newPort):
	globals.serverPort = newPort
	portEntered = true

func _onExpectedPlayersEntered(newNum):
	globals.playerCount = newNum
	playerCountEntered = true

func _onDoneButtonPressed():
	if ipAddressEntered and portEntered and playerCountEntered:
		#move to lobby and establish connections
		pass