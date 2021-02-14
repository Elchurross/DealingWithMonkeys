extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_Room1Area2D_body_entered(body):
	var lights = get_tree().get_nodes_in_group("LRoom1")
	var lightsOut = get_tree().get_nodes_in_group("LOut1")
	if body.is_in_group("Player"):
		for light in lights:
			light.set_energy(3)
		for light in lightsOut:
			light.set_energy(0)

func _on_Room1Area2D_body_exited(body):
	var tree = get_tree()
	var lights
	var lightsOut
	if (tree != null):
		lights = tree.get_nodes_in_group("LRoom1")
		lightsOut = get_tree().get_nodes_in_group("LOut1")
	if (body != null):
		if body.is_in_group("Player"):
			if (lights != null):
				for light in lights:
					light.set_energy(0)
			if (lightsOut != null):
				for light in lightsOut:
					light.set_energy(5)




