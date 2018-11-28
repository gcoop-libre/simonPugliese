extends Control

var textoAcercaDe = ["Simón Pugliese es un juego educativo para probar el ingenio, los reflejos y la memoria.", "Está pensado para la infancia pero lo puede jugar cualquier persona, su nivel de dificultad es bajo.", "Se juega de forma individual desde un dispositivo móvil o una computadora.", "El objetivo ayudar a la orquesta de Osvaldo Pugliese y sus músicos a “ensayar” y conseguir los instrumentos necesarios para que la orquesta pueda tocar. Para ello hay que pasar una serie de niveles en los cuales deberán repetir melodías en un teclado virtual y resolver laberintos.", "En cada jugada primero se mostrará una melodía que se tendrá que repetir tocando las teclas adecuadas, siempre desde el principio y en el mismo orden, formando una cadena de sonidos. ", "A continuación se deberá atravesar un laberinto para conseguir los instrumentos que la orquesta necesita.", "El juego finaliza una vez superados todos los niveles: cuando el jugador o la jugadora pueda tocar las melodías completas y la orquesta cuente con todos los instrumentos que necesita."]  

func _ready():
	var dialog = get_node("/root/global").get_dialog_volver()
	dialog.mostrarTexto(textoAcercaDe)
	dialog.conectarBoton("irAlMenu", get_node("/root/global"))
	add_child(dialog)

