extends Node2D

signal gane 

func _ready():
	get_node("musica").play('intro_la_yumba')

func _on_personaje_chocando(colisionador):
	sonarColision()
	if(colisionador == get_node("meta")):
		get_node("ganaste/Panel/anim").play("mostrar")
		get_node("sonidos_laberinto").play_sound("win")
		yield( get_node("ganaste/Panel/anim"), "finished" )
		emit_signal("gane")

func sonarColision():
	if(!get_node("sonidos_laberinto").is_playing):
		get_node("sonidos_laberinto").play_sound("collision")

func _on_personaje_caminando():
	if(!get_node("sonidos_laberinto").is_playing):
		get_node("sonidos_laberinto").play_sound("walk")

func _on_escena_gane():
	get_node("/root/global").siguienteNivel()