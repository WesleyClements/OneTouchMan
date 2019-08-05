extends Node

const gravity:= 700.0;

<<<<<<< HEAD
enum TaskStatus { FRESH, RUNNING, FAILED, SUCCEEDED }
=======
enum TaskStatus { FRESH, RUNNING, FAILED, SUCCEEDED, CANCELLED }

var username: String
var ip: String
var port: int

func _ready():
	username = ""
	ip = Networking.DEFAULT_IP
	port = Networking.DEFAULT_PORT
>>>>>>> refined main menu scripts
