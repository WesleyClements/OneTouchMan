extends KinematicBody2D

onready var collisionRight = $collisionRight

var direction := 1

func _ready():
	pass
	
func _physics_process(delta):
	if collisionRight.is_colliding():
		direction = -1
	
	move_and_slide(Vector2(50 * direction, 0))
	
	scale = Vector2(direction, 1)
	
