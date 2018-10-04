extends Polygon2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("volver").hide()

func _on_RichTextLabel_textoCompleto():
	get_node("volver").show()