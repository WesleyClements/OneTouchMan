extends KinematicBody2D

var direction := 1

func _ready():
	pass
	
func _physics_process(delta):
	if $collisionRight.is_colliding():
		direction = -1
		
	if $collisionLeft.is_colliding():
		direction = 1
	
	move_and_slide(Vector2(60 * direction, 0))
	
	$sprite.scale.x = direction
