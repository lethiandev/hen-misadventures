extends ColorRect

const AUDIO_DOWN = preload("res://interface/transition/down.wav")
const AUDIO_UP = preload("res://interface/transition/up.wav")

export var tween_duration = 0.7
export var tween_delay = 0.0

var fade_origin = Vector2()

func _process(delta):
	if visible:
		var xform = get_viewport().canvas_transform
		var origin = xform.xform(fade_origin)
		material.set_shader_param("offset", origin)

func fade_in(origin = Vector2()):
	fade_origin = origin
	_play_fade_sfx(AUDIO_UP)
	$FadeIn.remove_all()
	$FadeIn.interpolate_method(self, "_interpolate_shader_param", 0.0, 0.5,
		tween_duration * 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN, tween_delay)
	$FadeIn.start()
	return $FadeIn

func fade_out(origin = Vector2()):
	fade_origin = origin
	_play_fade_sfx(AUDIO_DOWN, 0.5)
	$FadeOut.remove_all()
	$FadeOut.interpolate_method(self, "_interpolate_shader_param", 1.0, 0.0,
		tween_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT, tween_delay)
	$FadeOut.start()
	return $FadeOut

func _interpolate_shader_param(value):
	material.set_shader_param("value", value)

func _play_fade_sfx(stream, delay = 0.0):
	$AudioStreamPlayer.stream = stream
	var timer = get_tree().create_timer(delay)
	timer.connect("timeout", $AudioStreamPlayer, "play")
