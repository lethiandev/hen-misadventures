extends "res://levels/level_base/level_base.gd"

func _enter_tree():
	GameUI.hide_ui()

func _exit_tree():
	GameUI.show_ui()

func _ready():
	$TileMap/Player.freeze()
	
	yield(Transition, "fade_in_ended")
	$AnimationPlayer.play("intro")
	
	yield($AnimationPlayer, "animation_finished")
	_on_exit_entered($TileMap/Player)
