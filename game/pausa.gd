extends TextureButton

var textura_pausado = load("res://assets/buttons/play.png")
var textura_jugando = load("res://assets/buttons/pause.png")

func _ready():
	set_focus_mode(0)
	set_normal_texture(textura_jugando)
	
func _on_pausa_pressed():
	get_tree().set_pause(!(get_tree().is_paused()))
	if(get_tree().is_paused()):
		set_normal_texture(textura_pausado)
		get_node("/root/global").apretar_ui_button()
		get_node("Timer").start()
		yield(get_node("Timer"), "timeout")
		get_node("/root/global").pausarSonido()
	else:
		set_normal_texture(textura_jugando)
		get_node("/root/global").continuarSonido()
		get_node("/root/global").apretar_ui_button()

