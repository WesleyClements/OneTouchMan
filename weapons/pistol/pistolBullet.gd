extends Area2D

var dir: Vector2;
var speed: float;
var damage: float;

func _ready() -> void:
	pass

func _process(delta) -> void:
	global_position += delta * dir * speed;

func _on_pistolBullet_body_entered(body: PhysicsBody2D) -> void:
	if body and body is Player:
		return;
	get_parent().remove_child(self);