extends Area2D
class_name Bullet

var dir: Vector2;
var speed: float;
var damage: float;

func initialize(dir: Vector2, speed: float, damage: float) -> void:
	self.dir = dir;
	self.speed = speed;
	self.damage = damage;

func _process(delta) -> void:
	global_position += dir * speed;