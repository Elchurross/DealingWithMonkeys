extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var old_global_pos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var player = get_owner().get_node("Player")
	global_position.y = 190
	if player.get_global_position().x < old_global_pos:
		global_position.x = old_global_pos
	else:
		global_position.x = player.get_global_position().x + 175
	pass
