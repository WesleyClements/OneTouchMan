extends Entity

class_name Eye

func _init().(10):
	var patrolTask = PatrolTask.new(self)
	var rootTask = Sequence.new([PatrolTask.new(self), WaitTask.new(1), ShootTask.new(self)])
	var brain = BehaviorTree.new(rootTask)

	setBrain(brain)
