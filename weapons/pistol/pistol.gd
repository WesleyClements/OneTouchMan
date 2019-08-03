extends Sprite

export(float) var damage;
export(float) var bulletSpeed;
export(float) var fireRate;
export(float) var recoil;

var fireTimer: float;

func canShoot() -> bool:
	return (fireTimer * fireRate) >= 1;

func _ready():
	fireTimer = 1e20;

func _process(delta):
	fireTimer += delta;