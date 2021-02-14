extends Node2D

var Box = preload("res://DialogBox.tscn")
var playerNear : bool = false
var box 
export var reference_path = ""
var player
var talking = true
const dialog = ["Wow! Your fighting skill is actually crazy!","Half junkie, half ninja!","Careful, I just walked passed someone who looked just like Sideshow Bob!","Take a puff"]

func _process(_delta):
	if box == null and player != null and talking:
		player.talking = false
		talking = false
	if playerNear and Input.is_action_just_pressed("Interact"):
		if !player.talking:
			player.talking = true
			talking = true
			box = Box.instance()
			box.position = get_node("Position2D").position
			add_child(box)

func _on_NPC_body_entered(body): 
	if body.is_in_group("Player"):
		player = body
		playerNear = true

func _on_NPC_body_exited(body):
	if body.is_in_group("Player"):
		playerNear = false
