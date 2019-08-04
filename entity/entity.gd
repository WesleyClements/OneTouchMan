extends KinematicBody2D

class_name Entity

var brain: BehaviorTree

var maxHealth: int
var health: int

func _init(var brain: BehaviorTree, var maxHealth: int):
	self.brain = brain
	self.maxHealth = maxHealth
	self.health = maxHealth

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass