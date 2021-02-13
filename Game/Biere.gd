extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 10
var isUp = false
var isDown = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var raycast_node = get_node("RayCast2D")
	if raycast_node.is_colliding():
		var distance =  self.position.distance_to(raycast_node.get_collision_point())
		print(distance)
		if (distance < 26):
			isUp = true
			isDown = false
		elif (distance > 35 and isUp == true):
			isUp = false
			isDown = true
	else:
		isDown = true
		isUp = false
	print(isUp)
	print(isDown)
	if (isDown) :
		move_and_slide(Vector2(0,1) * speed)
	elif (isUp) :
		move_and_slide(Vector2(0,-1) * speed)

	pass

func _on_Area2D_body_entered(body):
	
	if (body.get_name() == "Player"):
		var player = get_owner().get_node("Player")
		player.drinkBeer()
		queue_free()
	pass # Replace with function body.
