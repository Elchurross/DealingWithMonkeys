extends Area2D

var speed : int = 200
var direction : bool = true
onready var sprite : Sprite = get_node("bullet")

func _init():
	pass

func _physics_process(delta):
	var velocity = Vector2(speed * delta, 0)
	if direction:
		sprite.flip_h = true
		velocity.x *= -1
	else:
		sprite.flip_h = false
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	print ("bullet hit")
	queue_free()
