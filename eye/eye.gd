extends KinematicBody2D

class_name Eye

var brain: BehaviorTree

func _init():
	var patrolTask = PatrolTask.new(self)
	
	var rootTask = Sequence.new([PatrolTask.new(self), WaitTask.new(self, 1)])
	
	brain = BehaviorTree.new(rootTask)
	
func _process(delta):
	brain._process(delta)