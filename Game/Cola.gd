extends Area2D

var speedx : int = 250
var speedy : int = 475
var direction : bool = true
var rot : float = 90
onready var sprite : Sprite = get_node("cola")

func _init():
	randomize()
	speedx = rand_range(200, 300)
	randomize()
	speedy = rand_range(400, 650)

func _physics_process(delta):
	var velocity = Vector2(speedx * delta, -speedy * delta)
	if direction:
		sprite.flip_h = true
		velocity.x *= -1
	else:
		sprite.flip_h = false
	velocity.y += gravity * delta
	translate(velocity)
	sprite.set_global_rotation(rot)
	rot += 0.3
	speedy -= 11

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Tesson_body_entered(body):
	if body.is_in_group("Player"):
			body.hurt(35)
	queue_free()
