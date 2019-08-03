extends Control

var ipAddress = '127.0.0.1'
var port = 0

var ipAddressEntered = false
var portEntered = false

func _onIPAddressEntered(newIP):
	ipAddress = newIP
	ipAddressEntered = true

func _onPortEntered(newPort):
	port = newPort
	portEntered = true

func _onDoneButtonPressed():
	if ipAddressEntered and portEntered:
		#connect to server and enter lobby