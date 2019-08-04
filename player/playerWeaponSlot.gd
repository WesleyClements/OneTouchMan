extends Node2D

onready var weapon:= $pistol;

func createBullet():
	var bullet = weapon.createBullet();
	
	bullet.dir = Vector2(-1, 0);
	bullet.transform = get_global_transform();
