extends ConfirmationDialog

func _ready():
	pass

func _on_SalirDialog_confirmed():
	get_tree().quit()

func _on_SalirDialog_popup_hide():
	get_node("/root/global").resume()
