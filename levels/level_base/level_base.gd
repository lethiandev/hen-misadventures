extends Node

export var title = "Unknown Location"
export var hint = "Keep calm"

export(String, FILE) var next_level

var auto_fade_in = true

func _init():
	VisualServer.set_default_clear_color(Color(0, 0, 0))

func _ready():
	var players = get_tree().get_nodes_in_group("player")
	var origin = Vector2(512, 300)
	
	if players.size():
		origin = players[0].global_position
	
	Transition.level_introduce(title, hint, origin, auto_fade_in)

func _on_exit_entered(exit):
	Transition.fade_out(exit.position)
	yield(Transition, "fade_out_ended")
	get_tree().change_scene(next_level)
