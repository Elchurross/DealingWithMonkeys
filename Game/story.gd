extends Node2D

var pause:bool = true
export var reference_path = ""

func _ready() -> void:
	# scroll
	$tween_scroll.interpolate_property($Node, "position", Vector2(0, 320), Vector2(0, -288), 30, Tween.TRANS_LINEAR, 0)
	$tween_scroll.start()
	pause = false
func _process(delta:float) -> void:
	if !pause:
		var up:bool = Input.is_action_just_pressed("jump")

		if up:
			if(reference_path != ""):
				get_tree().change_scene(reference_path)
