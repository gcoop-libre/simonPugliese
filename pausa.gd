extends Button

func _ready():
	pass

func _on_pausa_pressed():
	get_node("/root/global").apretar_ui_button()
	get_node("Timer").start()
	yield(get_node("Timer"), "timeout")
	get_tree().set_pause(!(get_tree().is_paused()))
	if(get_tree().is_paused()):
		pausar()
		set_text("continuar")
	else:
		continuar()
		set_text("pausa")
	
func pausar():
	AudioServer.set_stream_global_volume_scale(0)
	AudioServer.set_fx_global_volume_scale(0)

func continuar():
	AudioServer.set_stream_global_volume_scale(1)
	AudioServer.set_fx_global_volume_scale(1)
