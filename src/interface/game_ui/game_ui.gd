extends CanvasLayer

var lives = 8 setget set_lives
var score = 0 setget set_score

func _enter_tree():
	reset()

func reset():
	set_lives(8)
	set_score(0)

func set_lives(value):
	lives = value
	$Control/Lives.rect_size.x = lives * 32.0

func set_score(value):
	score = value
	$Control/HBoxContainer/ScoreLabel.text = str(score)

func show_ui():
	$Control.show()

func hide_ui():
	$Control.hide()
