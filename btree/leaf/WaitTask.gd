extends LeafTask

class_name WaitTask

var waitTimeSeconds: float
var secondsRemaining: float

func _init(_waitTimeSeconds: float):
	waitTimeSeconds = _waitTimeSeconds

func start():
	secondsRemaining = waitTimeSeconds

func execute(delta: float) -> int:
	secondsRemaining -= delta
	if (secondsRemaining <= 0):
		return Globals.TaskStatus.SUCCEEDED
	else: 
		return Globals.TaskStatus.RUNNING