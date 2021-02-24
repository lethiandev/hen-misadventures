extends "res://levels/level_base/level_base.gd"

signal intro_finished()

func _enter_tree():
	GameUI.hide_ui()

func _exit_tree():
	GameUI.show_ui()

func _ready():
	$TileMap/Player.freeze()
	
	yield(Transition, "fade_in_ended")
	$AnimationPlayer.connect("animation_finished", self, "_finish_intro")
	$AnimationPlayer.play("intro")
	
	yield(self, "intro_finished")
	_on_exit_entered($TileMap/Player)

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		_finish_intro()

func _finish_intro():
	emit_signal("intro_finished")
