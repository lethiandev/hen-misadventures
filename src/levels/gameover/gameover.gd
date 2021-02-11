extends "res://levels/level_base/level_base.gd"

func _init():
	auto_fade_in = false

func _ready():
	Transition.connect("introduced", self, "set_process", [true])
	set_process(false)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		GameUI.reset()
		get_tree().change_scene(next_level)
