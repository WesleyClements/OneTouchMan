extends BranchTask

class_name Selector

func start() -> void:
	.start()
	childIndex = 0

func childSucceeded(delta: float) -> void:
	.childSucceeded(delta)
	succeeded(delta)

func childFailed(delta: float) -> void:
	.childFailed(delta)
	childIndex += 1
	if (childIndex < children.size()):
		run(delta)
	else:
		failed(delta)