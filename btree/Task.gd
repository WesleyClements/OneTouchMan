var status: int = globals.TaskStatus.FRESH setget setStatus, getStatus

var parent setget setParent, getParent

var guard setget setGuard, getGuard

func setStatus(var status: int):
	self.status = status

func getStatus():
	return status

func setParent(var parent):
	self.parent = parent

func getParent():
	return parent

func setGuard(var parent):
	self.guard = guard

func getGuard():
	return guard

func checkGuard():
	pass

func start():
	pass

func run():
	pass

func end():
	pass
