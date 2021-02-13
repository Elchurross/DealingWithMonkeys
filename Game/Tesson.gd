extends Area2D

var speedx : int = 250
var speedy : int = 475
var direction : bool = true
var boost : bool = false
onready var sprite : Sprite = get_node("tesson")

func _physics_process(delta):
	var velocity = Vector2(speedx * delta, -speedy * delta)
	if direction:
		sprite.flip_h = true
		velocity.x *= -1
	else:
		sprite.flip_h = false
	velocity.y += gravity * delta
	translate(velocity)
	speedy -= 11

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Tesson_body_entered(body):
	if body.is_in_group("Ennemy"):
		if boost:
			body.hurt(60)
		else:
			body.hurt(30)
	queue_free()
