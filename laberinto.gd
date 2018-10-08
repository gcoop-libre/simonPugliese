extends Node2D

signal gane 

func _ready():
	get_node("/root/global").play_bg_music()
	
func _on_personaje_chocando(colisionador):
	if(colisionador.get_parent() == get_node("items")):
		agarrarItem(colisionador)
	else: 
		sonarColision()

func sonarColision():
	if(!get_node("sonidos_laberinto").is_playing):
		get_node("sonidos_laberinto").play_sound("collision")

func _on_personaje_caminando():
	if(!get_node("sonidos_laberinto").is_playing):
		get_node("sonidos_laberinto").play_sound("engine_running")

func _on_personaje_parando():
	if(!get_node("sonidos_laberinto").is_playing):
		get_node("sonidos_laberinto").play_sound("engine_idle")

func _on_escena_gane():
	get_node("/root/global").siguienteNivel()
	
func agarrarItem(item):
	get_node("inventario").agregarItem(item.instrumento)
	item.queue_free()
	get_node("sonidos_laberinto/timerLargo").start()
	yield(get_node("sonidos_laberinto/timerLargo"), "timeout")
	if(cantidadItems() == 0):
		get_node("ganaste/Panel/anim").play("mostrar")
		get_node("sonidos_laberinto").play_sound("win")
		yield( get_node("ganaste/Panel/anim"), "finished" )
		emit_signal("gane")

func cantidadItems():
	return get_node("items").get_child_count()

