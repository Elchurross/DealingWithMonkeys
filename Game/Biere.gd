extends Node2D


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
func _process(delta):
	var raycast_node = get_node("RayCast2D")
	if raycast_node.is_colliding():
		var distance =  self.position.distance_to(raycast_node.get_collision_point())
		if (distance < 20):
			isUp = true
			isDown = false
		elif (distance > 27 and isUp == true):
			isUp = false
			isDown = true
	else:
		isDown = true
		isUp = false
	if (isDown) :
		self.position = self.position.move_toward(self.transform.y, -speed * delta)
	elif (isUp) :
		self.position = self.position.move_toward(self.transform.y, speed * delta)

	pass
