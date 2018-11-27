extends ConfirmationDialog

func _ready():
	get_cancel().set_text("Cancelar")
	get_ok().set_text("Aceptar")

func _on_salirDialog_confirmed():
	get_tree().quit()

func _on_salirDialog_popup_hide():
	get_node("/root/global").resume()
