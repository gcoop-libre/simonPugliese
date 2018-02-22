extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("musica").play('intro_la_yumba')

func _on_personaje_chocando(colisionador):
	sonarColision()
	if(colisionador == get_node("meta")):
		get_node("ganaste/Panel/anim").play("mostrar")
		yield( get_node("ganaste/Panel/anim"), "finished" )
		get_tree().change_scene("res://principal.tscn")
	
func sonarColision():
	if(!get_node("sonidos_laberinto").is_playing):
		get_node("sonidos_laberinto").play_sound("collision")

func _on_personaje_caminando():
	if(!get_node("sonidos_laberinto").is_playing):
		get_node("sonidos_laberinto").play_sound("walk")
