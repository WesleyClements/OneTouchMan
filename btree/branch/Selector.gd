extends BranchTask

class_name Selector

func _ready():
	children.append(1)

func setStatus(var status: int):
	.setStatus(status)
	match (status):
		globals.TaskStatus.FAILED:
			.raun()