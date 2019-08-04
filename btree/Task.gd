class_name Task

var status: int = Globals.TaskStatus.FRESH setget setStatus, getStatus

var parent setget setParent, getParent

var guard setget setGuard, getGuard

func _init():
	pass

func setStatus(var _status: int):
	status = _status

func getStatus():
	return status

func setParent(var _parent):
	parent = _parent

func getParent():
	return parent

func setGuard(var _guard):
	guard = _guard

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