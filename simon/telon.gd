extends Node2D

signal telonAbierto
signal telonCerrado

func _ready():
	pass
	
func abrir_telon():
	get_node("abre").show()
	for telon in get_node("abre").get_children():
		telon.play("abre")
	yield(get_node("abre/izquierda"), "finished")
	emit_signal("telonAbierto")
	
func cerrar_telon():
	get_node("cierra").show()
	for telon in get_node("cierra").get_children():
		telon.play("cierra")
	yield(get_node("cierra/izquierda"), "finished")
	emit_signal("telonCerrado")