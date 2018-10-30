extends TextureButton

func _ready():
	hide()

func _on_RichTextLabel_textoCompleto():
	show()