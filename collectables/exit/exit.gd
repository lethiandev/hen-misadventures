extends "res://collectables/collectable.gd"

signal exit_entered()

func _ready():
	var level = get_tree().current_scene
	connect("exit_entered", level, "_on_exit_entered")

func can_collect(by):
	return $AnimationPlayer.current_animation == "opened"

func collect(by):
	emit_signal("exit_entered", self)

func open():
	$AnimationPlayer.play("opened")
