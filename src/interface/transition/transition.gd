extends CanvasLayer

signal introduced()
signal fade_in_started()
signal fade_in_ended()
signal fade_out_started()
signal fade_out_ended()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		$VBoxContainer/TitleLabel.skip()
		$VBoxContainer/HintLabel.skip()

func level_introduce(title, hint, origin = Vector2(), fade_in = true):
	$VBoxContainer.show()
	
	$VBoxContainer/TitleLabel.text = title
	$VBoxContainer/TitleLabel.visible_characters = 0
	$VBoxContainer/HintLabel.text = hint
	$VBoxContainer/HintLabel.visible_characters = 0
	
	$ColorRect.show()
	$ColorRect._interpolate_shader_param(0.0)
	
	yield($VBoxContainer/TitleLabel.start_tween(), "tween_completed")
	yield($VBoxContainer/HintLabel.start_tween(), "tween_completed")
	yield(get_tree().create_timer(1.0), "timeout")
	
	if fade_in:
		$VBoxContainer.hide()
		fade_in(origin)
	
	emit_signal("introduced")

func fade_in(origin):
	$ColorRect.show()
	
	emit_signal("fade_in_started")
	
	yield($ColorRect.fade_in(origin), "tween_completed")
	yield(get_tree().create_timer(0.2), "timeout")
	
	$ColorRect.hide()
	
	emit_signal("fade_in_ended")

func fade_out(origin):
	$ColorRect.show()
	
	emit_signal("fade_out_started")
	
	yield($ColorRect.fade_out(origin), "tween_completed")
	yield(get_tree().create_timer(0.2), "timeout")
	
	emit_signal("fade_out_ended")
