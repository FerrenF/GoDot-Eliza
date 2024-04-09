extends CanvasLayer

var dialog_text = {} # The ELIZA text file that lists all the possible responses. I think.
var current_text = [] # The text that will be currently shown in the dialog box.

func _ready():
	var background: TextureRect = $Background
	# dialog_text = load_dialog_text() # doesn't work but we might need it
	pass

func _process(_delta):
	pass

func _on_user_input_text_text_submitted(_new_text):
	pass

func _on_quit_button_down():
	get_tree().quit()

