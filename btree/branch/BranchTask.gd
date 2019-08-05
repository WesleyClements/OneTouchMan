extends Task

class_name BranchTask

var children: Array
var runningChild: Task
var childIndex: int

func _init(_children: Array):
	children = _children

func childSucceeded(delta: float) -> void:
	runningChild = null

func childFailed(delta: float) -> void:
	runningChild = null

func childRunning(delta: float) -> void:
	running(delta)

func start() -> void:
	runningChild = null

func run(delta: float) -> void:
	if (runningChild != null):
		runningChild.run(delta)
	else:
		runningChild = children[childIndex]
		runningChild.start()
		
		if (runningChild.checkGuard(delta)):
			runningChild.run(delta)
		else:
			runningChild.failed(delta)
