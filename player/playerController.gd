extends KinematicBody2D
class_name Player

export(float) var frictionCoef:= 30;

export(float) var inputTimeEpsilon:= 0.1;

enum CrouchState { IDLE, CROUCHING, CROUCHED, UNCROUCHING }

enum JumpState { IDLE, JUMPING, RECOVERY }

export(float) var jumpCoyoteTime:= 0.1;
export(float) var jumpHeight:= 100;
export(float) var jumpHeightCrouched:= 60;
export(float) var jumpHeightMin:= 40;
export(float) var jumpHeightMinCrouched:= 10;

var jumpSpeed: float;
var jumpSpeedCrouched: float;
var jumpSpeedMin: float;
var jumpSpeedMinCrouched: float;

enum MoveState { IDLE, MOVE_LEFT, MOVE_RIGHT }

export(float) var maxSpeedX:= 200;
export(float) var maxSpeedXCrouched:= 50;
export(float) var maxSpeedY:= 5000;
export(float) var minSpeedEpsilon:= 5;
export(float) var airMoveForceScale:= 0.7;
export(float) var moveForce:= 700.0;

var moveForceAir: float;

var crouchState;
var crouchStateTime: float;

func setCrouchState(state: String) -> void:
	match state:
		"idle":
			crouchState = CrouchState.IDLE;
		"crouching":
			crouchState = CrouchState.CROUCHING;
		"crouched":
			crouchState = CrouchState.CROUCHED;
		"uncrouching":
			crouchState = CrouchState.UNCROUCHING;
	crouchStateTime = 0;
	updateAnimationState();

func isCrouching() -> bool:
	return (crouchState == CrouchState.CROUCHING or
			crouchState == CrouchState.UNCROUCHING);

func isCrouched() -> bool:
	return crouchState == CrouchState.CROUCHED;

var jumpState;
var jumpStateTime: float;

var moveState;
var moveStateTime: float;

var velocity: Vector2;

var facing: int setget setFacing;
func setFacing(newFacing) -> void:
	facing = newFacing;
	if facing == -1:
		$playerBodySprites.scale.x = 1;
	else:
		$playerBodySprites.scale.x = -1;

var timeOffGround;

func _ready():
	jumpSpeed = sqrt(2 * jumpHeight * globals.gravity);
	jumpSpeedCrouched = sqrt(2 * jumpHeightCrouched * globals.gravity);
	jumpSpeedMin = sqrt(2 * jumpHeightMin * globals.gravity);
	jumpSpeedMinCrouched = sqrt(2 * jumpHeightMinCrouched * globals.gravity);
	
	moveForceAir = airMoveForceScale * moveForce;
	
	crouchState = CrouchState.IDLE;
	
	jumpState = JumpState.IDLE;
	jumpStateTime = 1e20;
	
	moveState = MoveState.IDLE;
	moveStateTime = 1e20;
	
	velocity = Vector2();
	
	facing = -1;
	
	timeOffGround = 1e20;

func _physics_process(delta):
	var jump = Input.is_action_pressed("jump");
	var crouch = Input.is_action_pressed("crouch");
	var moveDir:= ((-1 if Input.is_action_pressed("move_left" ) else 0) +
			 		( 1 if Input.is_action_pressed("move_right") else 0));
	
	if is_on_floor():
		timeOffGround = 0;
	else:
		timeOffGround += delta;
	
	processCrouch(delta, crouch);
	processJump(delta, jump);
	
	var force = globals.gravity * Vector2.DOWN;
	
	var moveForce = processMove(delta, moveDir);
	
	if not moveForce and is_on_floor() and velocity.x:
		force += frictionCoef * -velocity.x * Vector2.RIGHT;
	else:
		force += moveForce;
	
	velocity += force * delta;
	var _maxSpeedX = (maxSpeedXCrouched if isCrouched() else maxSpeedX);
	if abs(velocity.x) > _maxSpeedX:
		velocity.x = sign(velocity.x) * _maxSpeedX;
	if abs(velocity.y) > maxSpeedY:
		velocity.y = sign(velocity.y) * maxSpeedX;
	
	velocity = move_and_slide(velocity, Vector2.UP);

func processCrouch(delta, crouch) -> void:
	if !is_on_floor():
		crouchStateTime += delta;
		return;
	match crouchState:
		CrouchState.IDLE:
			crouchStateTime += delta;
			if not crouch:
				return;
			
			crouchState = CrouchState.CROUCHING;
			crouchStateTime = 0;
			updateAnimationState();
		CrouchState.CROUCHING:
			crouchStateTime += delta;
		CrouchState.CROUCHED:
			if not crouch:
				crouchState = CrouchState.UNCROUCHING;
				crouchStateTime = 0;
				updateAnimationState();
			else:
				crouchStateTime += delta;
		CrouchState.UNCROUCHING:
			crouchStateTime += delta;

func processJump(delta, jump) -> void:
	match jumpState:
		JumpState.IDLE:
			jumpStateTime += delta;
			
			if isCrouching():
				return;
			if not jump:
				return;
			if not (is_on_floor() or timeOffGround < jumpCoyoteTime):
				return;
			
			var speed = jumpSpeedCrouched if isCrouched() else jumpSpeed;
			velocity += speed * Vector2.UP;
			
			jumpState = JumpState.JUMPING;
			jumpStateTime = 0;
			
			updateAnimationState();
		JumpState.JUMPING:
			var falling = (velocity.y > 0);
			if is_on_floor() and jumpStateTime > 0:
				jumpState = JumpState.IDLE;
				jumpStateTime = 0;
				updateAnimationState();
			elif falling or not jump:
				if not falling:
					var speed = -(jumpSpeedMinCrouched if isCrouched() else jumpSpeedMin);
					velocity.y = max(velocity.y, speed);
				jumpState = JumpState.RECOVERY;
				jumpStateTime = 0;
			else:
				jumpStateTime += delta;
		JumpState.RECOVERY:
			if is_on_floor():
				jumpState = JumpState.IDLE;
				jumpStateTime = 0;
				updateAnimationState();
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
			setFacing(moveDir);
			
			moveState = (MoveState.MOVE_LEFT if moveDir == -1 else MoveState.MOVE_RIGHT);
			moveStateTime = 0;
			
			updateAnimationState();
		MoveState.MOVE_LEFT, MoveState.MOVE_RIGHT:
			if moveDir:
				var newMoveState = (MoveState.MOVE_LEFT if moveDir == -1 else MoveState.MOVE_RIGHT);
				if moveState == newMoveState:
					applyForce = true;
				else:
					velocity.x = 0;
					setFacing(moveDir);
					
					moveState = newMoveState;
					moveStateTime = 0;
			elif abs(velocity.x) < minSpeedEpsilon:
					velocity.x = 0;
					
					moveState = MoveState.IDLE;
					moveStateTime = 0;
					
					updateAnimationState();
	if applyForce:
		var forceScalar = moveForce;
		if not is_on_floor():
			forceScalar *= airMoveForceScale;
		return moveDir * forceScalar * Vector2.RIGHT;
	else:
		return Vector2();

func updateAnimationState() -> void:
	match jumpState:
		JumpState.IDLE:
			match crouchState:
				CrouchState.IDLE:
					match moveState:
						MoveState.IDLE:
							$AnimationPlayer.play("Idle");
							return
						MoveState.MOVE_LEFT, MoveState.MOVE_RIGHT:
							$AnimationPlayer.play("Walking");
							return
				CrouchState.CROUCHING:
					$AnimationPlayer.play("Crouch");
				CrouchState.CROUCHED:
					match moveState:
						MoveState.IDLE:
							$AnimationPlayer.play("CrouchedIdle");
							return
						MoveState.MOVE_LEFT, MoveState.MOVE_RIGHT:
							$AnimationPlayer.play("CrouchedWalking");
							return
				CrouchState.UNCROUCHING:
					$AnimationPlayer.play("Uncrouch");
		JumpState.JUMPING:
			match crouchState:
				CrouchState.IDLE:
					$AnimationPlayer.play("Jump");
				CrouchState.CROUCHED:
					$AnimationPlayer.play("CrouchedJump");