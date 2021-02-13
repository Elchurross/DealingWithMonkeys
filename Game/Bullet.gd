extends KinematicBody2D

var speed : int = 10
var direction : bool = true

func _init():
	pass

func _physics_process(delta):
	var movement = Vector2(speed,0)
	move_and_collide(movement)
