class_name Task

var status: int = Globals.TaskStatus.FRESH

var parent: Task setget setParent, getParent

var guard: Task setget setGuard, getGuard

func setParent(_parent: Task) -> void:
	parent = _parent

func getParent() -> Task:
	return parent

func setGuard(_guard: Task) -> void:
	guard = _guard

func getGuard() -> Task:
	return guard

func checkGuard(delta: float) -> bool:
	if (guard == null):
		return true
	
	if (!guard.checkGuard(delta)):
		return false
	
	guard.start()
	guard.run(delta)
	match (guard.status):
		Globals.TaskStatus.SUCCEEDED:
			return true
		Globals.TaskStatus.FAILED:
			return false
		_:
			printerr("Illegal State: Guard status must only be SUCCEEDED or FAILED")
			return false

func succeeded(delta: float) -> void:
	status = Globals.TaskStatus.SUCCEEDED
	end()
	if (parent != null):
		parent.childSucceeded(delta)

func failed(delta: float) -> void:
	status = Globals.TaskStatus.FAILED
	end()
	if (parent != null):
		parent.childFailed(delta)

func running(delta: float) -> void:
	status = Globals.TaskStatus.RUNNING
	if (parent != null):
		parent.childRunning(delta)

func childSucceeded(delta: float) -> void:
	pass

func childFailed(delta: float) -> void:
	pass

func childRunning(delta: float) -> void:
	pass

func start() -> void:
	pass

func run(delta: float) -> void:
	pass

func end() -> void:
	pass