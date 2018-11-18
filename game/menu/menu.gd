# menu

extends HBoxContainer

func _ready():
	pass
	
func _on_jugar_pressed():
	get_node("/root/global").apretar_ui_button()
	get_node("/root/global").empezarJuego()

func _on_salir_pressed():
	get_node("/root/global").apretar_ui_button()
	get_tree().quit()

func _on_acerca_pressed():
	get_node("/root/global").apretar_ui_button()
	get_node("/root/global").irAlMenu()

func esJugable():
	return false

func _on_creditos_pressed():
	get_node("/root/global").apretar_ui_button()
	get_node("/root/global").irALosCreditos()