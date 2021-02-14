extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	var lights = get_tree().get_nodes_in_group("LRoom1")
	print(body)
	if body.is_in_group("Player"):
		print(lights)
		for light in lights:
			if (light.get_energy() == 0):
				light.set_energy(3)
			else:
				light.set_energy(0)
