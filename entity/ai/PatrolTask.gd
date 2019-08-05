extends WaitTask

class_name PatrolTask

var entity: Entity

var direction: int

func _init(_entity: Entity).(3):
	entity = _entity
	direction = 1

func execute(delta: float) -> int:
	if entity.get_node("collisionRight").is_colliding():
		direction = -1
		
	if entity.get_node("collisionLeft").is_colliding():
		direction = 1
	
	entity.move_and_slide(Vector2(60 * direction, 0))
	
	entity.get_node("sprite").scale.x = direction

	return .execute(delta)