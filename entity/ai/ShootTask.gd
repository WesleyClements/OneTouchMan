extends LeafTask

class_name ShootTask

var entity: Entity

func _init(_entity: Entity):
	entity = _entity

func execute(delta: float) -> int:
	print("Bang!")
	return Globals.TaskStatus.SUCCEEDED