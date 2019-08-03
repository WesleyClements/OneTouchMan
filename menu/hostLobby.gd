extends Control

#each player has a username, ip address, and socket object
var players = {}
var numConnectedPlayers = 0
var numExpectedPlayers = 4
var serverIP = '127.0.0.1'
var serverPort = 0

#create waiting socket
#remember addresses of new connections, then receive player data from them
#update lobby screen and send updated player list to all connected players
#player clients receive this data and update their lobby screens
#once numConnectedPlayers equals numExpectedPlayers, hit done to start the game
#this sends the initial gamestate to the player clients

func _ready(numPlayers, ):
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _onStartPressed():
	#launch game