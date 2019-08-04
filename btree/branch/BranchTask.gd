extends "../Task.gd"

class_name BranchTask

var children: Array
var runningChild
var childIndex: int

func _init(children: Array):
	self.children = children

func setStatus(var status: int):
	.setStatus(status)
	match (status):
		globals.TaskStatus.FAILED:
			runningChild = null
		globals.TaskStatus.SUCCEEDED:
			runningChild = null

func start():
	runningChild = null

func run():
	if (runningChild != null):
		runningChild.run()
	else:
		runningChild = children[childIndex]
		runningChild.start()
		
		if (!runningChild.checkGuard()):
			status = globals.TaskStatus.FAILED
		else:
			status = runningChild.run()
