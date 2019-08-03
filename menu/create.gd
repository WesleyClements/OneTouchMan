extends Control

var ipAddress = '127.0.0.1'
var port = 0
var expectedPlayers = 4

var ipAddressEntered = false
var portEntered = false
var expectedPlayersEntered = false

func _onIPAddressEntered(newIP):
	ipAddress = newIP
	ipAddressEntered = true

func _onPortEntered(newPort):
	port = newPort
	portEntered = true

func _onExpectedPlayersEntered(newNum):
	expectedPlayers = newNum
	expectedPlayersEntered = true

func _onDoneButtonPressed():
	if ipAddressEntered and portEntered and expectedPlayersEntered:
		#move to lobby and establish connections