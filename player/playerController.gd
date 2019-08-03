extends KinematicBody2D

export(float) var gravity:= 700.0;

export(float) var frictionCoef:= 8;

export(float) var inputTimeEpsilon:= 0.1;

enum JumpState { IDLE, JUMPING }

export(float) var jumpCoyoteTime:= 0.1;
export(float) var jumpHeight:= 80;
export(float) var jumpHeightMin:= 10;

var jumpSpeed: float;
var jumpSpeedMin: float;

enum MoveState { IDLE, MOVE_LEFT, MOVE_RIGHT }

export(float) var maxSpeedX:= 200;
export(float) var maxSpeedY:= 500;
export(float) var airMoveForceScale:= 0.7;
export(float) var moveForce:= 700.0;

var moveForceAir: float;

var jumpState;
var jumpStateTime: float;

var moveState;
var moveStateTime: float;

var velocity: Vector2;

var facing: int setget setFacing;
func setFacing(newFacing) -> void:
	facing = newFacing;
	if facing == -1:
		$sprites.set_flip_h(false);
	else:
		$sprites.set_flip_h(true);

var timeOffGround;

func _ready():
	jumpSpeedMin = sqrt(2 * jumpHeightMin * gravity);
	jumpSpeed = sqrt(2 * jumpHeight * gravity);
	
	moveForceAir = airMoveForceScale * moveForce;
	
	jumpState = JumpState.IDLE;
	jumpStateTime = 1e20;
	
	moveState = MoveState.IDLE;
	moveStateTime = 1e20;
	
	velocity = Vector2();
	
	facing = -1;
	
	timeOffGround = 1e20;

func _process(delta):
	var jump = Input.is_action_pressed("jump");
	var moveDir:= ((-1 if Input.is_action_pressed("move_left" ) else 0) +
			 		( 1 if Input.is_action_pressed("move_right") else 0));
	
	if is_on_floor():
		timeOffGround = 0;
	else:
		timeOffGround += delta;
	
	processJump(delta, jump);
	
	var force = gravity * Vector2.DOWN;
	
	force += processMove(delta, moveDir);
	
	velocity += force * delta;
	if abs(velocity.x) > maxSpeedX:
		velocity.x = sign(velocity.x) * maxSpeedX;
	if abs(velocity.y) > maxSpeedY:
		velocity.y = sign(velocity.y) * maxSpeedX;
	
	velocity = move_and_slide(velocity, Vector2.UP);
	
func processJump(delta, jump) -> void:
	match jumpState:
		JumpState.IDLE:
			jumpStateTime += delta;
			
			if not jump:
				return;
			if not (is_on_floor() or timeOffGround < jumpCoyoteTime):
				return;
			
			velocity += jumpSpeed * Vector2.UP;
			
			jumpState = JumpState.JUMPING;
			jumpStateTime = 0;
		JumpState.JUMPING:
			var falling = (velocity.y > 0);
			var onFloor = (is_on_floor() and jumpStateTime > 0);
			if falling or onFloor or not jump:
				jumpState = JumpState.IDLE;
				jumpStateTime = 0;
				if not falling and not onFloor:
					velocity.y = max(velocity.y, jumpSpeedMin);
			else:
				jumpStateTime += delta;

func processMove(delta, moveDir) -> Vector2:
	moveStateTime += delta;
		
	var applyForce: bool;
	match moveState:
		MoveState.IDLE:
			if not moveDir:
				return Vector2();
				
			applyForce = true;
			facing = moveDir;
			moveState = (MoveState.MOVE_LEFT if moveDir == -1 else MoveState.MOVE_RIGHT);
			moveStateTime = 0;
		MoveState.MOVE_LEFT, MoveState.MOVE_RIGHT:
			if moveDir:
				var newMoveState = (MoveState.MOVE_LEFT if moveDir == -1 else MoveState.MOVE_RIGHT);
				if moveState == newMoveState:
					applyForce = true;
				else:
					velocity.x = 0;
					facing = moveDir;
					moveState = newMoveState;
					moveStateTime = 0;
			else:
				if velocity.x == 0:
					moveState = MoveState.IDLE;
					moveStateTime = 0;
	if applyForce:
		var forceScalar = (moveForce if is_on_floor() else moveForceAir);
		return moveDir * forceScalar * Vector2.RIGHT;
	elif not moveDir and velocity.x:
		return frictionCoef * -velocity.x * Vector2.RIGHT;
	else:
		return Vector2();
