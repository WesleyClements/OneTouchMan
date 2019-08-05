extends BranchTask

class_name Sequence

func _init(children: Array).(children):
	pass

func start() -> void:
	.start()
	childIndex = 0

func childSucceeded(delta: float) -> void:
	.childSucceeded(delta)
	childIndex += 1
	if (childIndex < children.size()):
		run(delta)
	else:
		failed(delta)

func childFailed(delta: float) -> void:
	.childFailed(delta)
	failed(delta)