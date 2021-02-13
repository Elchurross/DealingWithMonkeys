extends Area2D

var speed : int = 200
var direction : bool = true
onready var sprite : Sprite = get_node("bullet")

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
	if body.is_in_group("Ennemy"):
		body.hurt(30)
	queue_free()
