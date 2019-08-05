class_name BehaviorTree

var rootTask: Task

func _init(var _rootTask: Task):
	rootTask = _rootTask
	
	setParents(rootTask)

func setParents(task: Task):
	if task is BranchTask:
		for child in task.children:
			child.parent = task
			setParents(child)

func _process(delta: float):
	if (rootTask.status == Globals.TaskStatus.RUNNING):
		rootTask.run(delta)
	else:
		rootTask.start()
		if (rootTask.checkGuard(delta)):
			rootTask.run(delta)
		else:
			rootTask.failed(delta)