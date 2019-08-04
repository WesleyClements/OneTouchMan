extends Control

var username = ''
var usernameEntered = false

func _onTextFieldChanged(newName):
	username = newName
	usernameEntered = true

func _onTextFieldEntered(newName):
	username = newName
	usernameEntered = true

func _onJoinButtonPressed():
	if usernameEntered:
		#call join.gd
		pass

func _onCreateButtonPressed():
	if usernameEntered:
		#call create.gd
		pass