extends Node2D

var pause:bool = true
export var reference_path = ""
func _ready() -> void:
	yield(get_tree().create_timer(1.0), "timeout")
	pause = false

func _process(delta:float) -> void:
	if !pause:
		var up:bool = Input.is_action_just_pressed("punch")

		if up:
			if(reference_path != ""):
				get_tree().change_scene(reference_path)

