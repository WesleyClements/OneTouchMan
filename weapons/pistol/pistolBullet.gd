extends Area2D

var dir: Vector2;
var speed: float;
var damage: float;

func initialize(dir: Vector2, speed: float, damage: float) -> void:
	self.dir = dir;
	self.speed = speed;
	self.damage = damage;

func _ready() -> void:
	pass

func _process(delta) -> void:
	global_position += dir * speed;

func _on_pistolBullet_body_entered(body: PhysicsBody2D) -> void:
	if body.is_a_parent_of(self):
		return;