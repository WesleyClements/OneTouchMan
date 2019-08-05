extends KinematicBody2D

class_name Entity

var brain: BehaviorTree setget setBrain, getBrain

var maxHealth: int
var health: int

func _init(_maxHealth: int):
	maxHealth = _maxHealth
	health = _maxHealth

func setBrain(_brain: BehaviorTree):
	brain = _brain

func getBrain():
	return brain

func _process(delta):
	brain._process(delta)