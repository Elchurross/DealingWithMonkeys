extends KinematicBody2D

var speed : int = 10
var direction : bool = true
onready var sprite : Sprite = get_node("bullet")

func _init():
	pass

func _physics_process(_delta):
	if direction:
		sprite.flip_h = true
		position.x -= speed
	else:
		sprite.flip_h = false
		position.x += speed
