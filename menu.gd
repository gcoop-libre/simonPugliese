extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("sonidos_ui").play('intro_la_yumba')

func _on_jugar_pressed():
	play_click()
	get_tree().change_scene("res://principal.tscn")

func _on_salir_pressed():
	play_click()
	get_tree().quit()

func _on_acerca_pressed():
	play_click()
	get_tree().change_scene("res://info.tscn")

func play_click():
	get_node("sonidos_ui").play('click')