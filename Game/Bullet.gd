extends Area2D

var speed : int = 700
var direction : bool = true

func _init(dir):
	direction = dir

func _physics_process(delta):
	print("ok")
#	var pos : Vector2 = get_position()
#	print(direction)
#	if direction:
#		pos.x += speed * delta
#	else:
#		pos.x -= speed * delta
#	set_position(pos)
