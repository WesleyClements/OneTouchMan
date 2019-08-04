extends Node

const gravity:= 700.0;

var players = {}
var serverIP = '127.0.0.1'
var serverPort = 0
var playerCount = 4

enum TaskStatus { FRESH, RUNNING, FAILED, SUCCEEDED, CANCELLED }

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
