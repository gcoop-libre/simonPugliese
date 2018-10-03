extends Node2D

signal gane 

func _ready():
	get_node("/root/global").play_bg_music()

func _on_personaje_chocando(colisionador):
	if(colisionador.get_parent().get_parent() == get_node("items")):
		sonarItemCollected()
		agarrarItem(colisionador)
	else: 
		sonarColision()

func sonarColision():
	if(!get_node("sonidos_laberinto").is_playing):
		get_node("sonidos_laberinto").play_sound("collision")

func sonarItemCollected():
	get_node("sonidos_laberinto").play_sound("itemCollected")

func _on_personaje_caminando():
	if(!get_node("sonidos_laberinto").is_playing):
		get_node("sonidos_laberinto").play_sound("walk")

func _on_escena_gane():
	get_node("/root/global").siguienteNivel()
	
func agarrarItem(item):
	get_node("inventario").agregarItem(item.get_name())
	item.get_parent().free()
	print(cantidadItems())
	if(cantidadItems() == 0):
		get_node("ganaste/Panel/anim").play("mostrar")
		get_node("sonidos_laberinto").play_sound("win")
		yield( get_node("ganaste/Panel/anim"), "finished" )
		emit_signal("gane")

func cantidadItems():
	return get_node("items").get_child_count()