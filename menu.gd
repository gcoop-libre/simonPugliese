extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_jugar_pressed():
	get_tree().change_scene("res://principal.tscn")

func _on_salir_pressed():
	get_tree().quit()

func _on_acerca_pressed():
	get_tree().change_scene("res://info.tscn")
