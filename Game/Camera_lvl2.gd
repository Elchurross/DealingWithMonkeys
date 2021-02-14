extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var old_global_pos = Vector2(171,350)
var new_global_pos = Vector2(0,0)
var maxXNiveau = 10000
var minY = 300
var minX = -1300

# Called when the node enters the scene tree for the first time.
func _ready():
	set_global_position(new_global_pos)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player = get_tree().get_nodes_in_group("Player")[0]
	new_global_pos.y = minY
	if player.get_global_position().x < minX:
		new_global_pos.x = minX
		set_global_position(new_global_pos)
	elif player.get_global_position().x >= maxXNiveau:
		new_global_pos.x = maxXNiveau
		set_global_position(new_global_pos)
	else:
		new_global_pos.x = player.get_global_position().x
		set_global_position(new_global_pos)
