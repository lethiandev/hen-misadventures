extends "res://levels/level_base/level_base.gd"

func _ready():
	Transition.connect("fade_out_started", $Camera2D/AnimationPlayer, "stop")
	Transition.connect("fade_out_ended", $Camera2D/AnimationPlayer, "seek", [0, true])
	Transition.connect("fade_in_ended", $Camera2D/AnimationPlayer, "play", ["rising"])
