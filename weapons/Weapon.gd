extends Sprite
class_name Weapon

export(float) var damage: float;
export(float) var bulletSpeed: float;
export(float) var fireRate: float;
export(float) var recoil: float;

export(Vector2) var firePoint;

var fireTimer: float;

func canShoot() -> bool:
	return (fireTimer * fireRate) >= 1;

func resetFireTimer() -> void:
	fireTimer = 0;

func createBullet():
	fireTimer = 0;

func _ready():
	fireTimer = 1e20;

func _process(delta):
	fireTimer += delta;