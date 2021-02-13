extends Area2D

var speed : int = 700
var direction : bool = true

func _init(dir):
	direction = dir

func _physics_process(delta):
	position += transform.x * speed * delta
