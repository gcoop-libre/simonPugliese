# root/menu

extends HBoxContainer

func _ready():
	pass
	
func _on_jugar_pressed():
	play_click()
	get_node("/root/menu/Timer").start()
	yield(get_node("/root/menu/Timer"), "timeout")
	get_node("/root/global").empezarJuego()

func _on_salir_pressed():
	play_click()
	get_node("Timer").start()
	yield(get_node("Timer"), "timeout")
	get_tree().quit()

func _on_acerca_pressed():
	play_click()
	get_node("Timer").start()
	yield(get_node("Timer"), "timeout")
	get_tree().change_scene("res://info.tscn")

func play_click():
	get_node("/root/menu/sonidos_ui").play("click") 

func _on_volver_pressed():
	self._on_jugar_pressed()
