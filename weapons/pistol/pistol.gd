extends Weapon

const bullet = preload("res://weapons/pistol/pistolBullet.tscn");

func _ready():
	damage = 1;
	bulletSpeed = 300;
	fireRate = 2;
	recoil = 1;
	firePoint = Vector2(-7, -2.5);

func createBullet():
	var instance = bullet.instance();
	instance.speed = bulletSpeed;
	instance.damage = damage;
	return instance;