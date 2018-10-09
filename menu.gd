# menu

extends HBoxContainer

func _ready():
	pass
	
func _on_jugar_pressed():
	apretar()
	get_node("/root/global").empezarJuego()

func _on_salir_pressed():
	apretar()
	get_tree().quit()

func _on_acerca_pressed():
	apretar()
	get_tree().change_scene("res://info.tscn")

func apretar():	
	play_click()
	get_node("/root/global/TimerBoton").start()
	yield(get_node("/root/global/TimerBoton"), "timeout")
	
func play_click():
	get_node("/root/global/sonidos_ui").play("click") 
