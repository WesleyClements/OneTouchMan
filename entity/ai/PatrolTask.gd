extends WaitTask

class_name PatrolTask

var direction: int

func _init(var eye).(eye, 3):
	direction = 1

func execute(delta: float) -> int:
	if eye.get_node("collisionRight").is_colliding():
		direction = -1
		
	if eye.get_node("collisionLeft").is_colliding():
		direction = 1
	
	eye.move_and_slide(Vector2(60 * direction, 0))
	
	eye.get_node("sprite").scale.x = direction

	return .execute(delta)