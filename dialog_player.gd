extends CanvasLayer

func _process(_delta):
	pass

func _on_user_input_text_text_submitted(_new_text):
	pass

func _on_quit_button_down():
	get_tree().quit()



func _on_DialogPlayer_ready():
	
	var ElizT = ElizaWrapper.new()
	print("ugh")
