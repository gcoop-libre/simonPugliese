extends Button

func _ready():
	pass

func _on_pausa_pressed():
	get_tree().set_pause(!(get_tree().is_paused()))
	if(get_tree().is_paused()):
		get_node("/root/global").apretar_ui_button()
		get_node("Timer").start()
		yield(get_node("Timer"), "timeout")
		AudioServer.set_stream_global_volume_scale(0)
		AudioServer.set_fx_global_volume_scale(0)
		set_text("continuar")
	else:
		AudioServer.set_stream_global_volume_scale(1)
		AudioServer.set_fx_global_volume_scale(1)
		get_node("/root/global").apretar_ui_button()
		set_text("pausa")