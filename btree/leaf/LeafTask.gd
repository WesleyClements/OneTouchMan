extends Task

class_name LeafTask

func execute(delta: float) -> int:
	return Globals.TaskStatus.FRESH

func run(delta: float) -> void:
	var result = execute(delta)
	match (result):
		Globals.TaskStatus.SUCCEEDED:
			succeeded(delta)
		Globals.TaskStatus.FAILED:
			failed(delta)
		Globals.TaskStatus.RUNNING:
			running(delta)
		_:
			printerr("Illegal State: execute() returned invalid status")

func childSucceeded(delta: float) -> void:
	printerr("Illegal State: LeafTask cannot have a child")

func childFailed(delta: float) -> void:
	printerr("Illegal State: LeafTask cannot have a child")

func childRunning(delta: float) -> void:
	printerr("Illegal State: LeafTask cannot have a child")
