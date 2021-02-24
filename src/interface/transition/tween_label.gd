extends Label

export var tween_duration = 1.0
export var tween_delay = 0.0

var char_index = -1

func _ready():
	connect("visibility_changed", self, "set", ["visible_characters", 0])
	visible_characters = 0

func start_tween():
	$Tween.interpolate_method(self, "_interpolate_visible_chars", 0.0, 1.0,
		tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN, tween_delay)
	$Tween.start()
	return $Tween

func skip():
	var time_frame = tween_duration + tween_delay
	if $Tween.tell() < time_frame:
		# Seek tween just right before the end
		# Workaround for emitting tween_completed signal
		$Tween.seek(time_frame - 0.001)

func _interpolate_visible_chars(value):
	visible_characters = int(value * text.length())
	
	if visible_characters != char_index:
		char_index = visible_characters
		$AudioStreamPlayer.play()
