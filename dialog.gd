extends Polygon2D

func _ready():
	get_node("Timer").start()
	get_node("volver").hide()

func _on_RichTextLabel_textoCompleto():
	get_node("Timer").stop()
	get_node("volver").show()
	