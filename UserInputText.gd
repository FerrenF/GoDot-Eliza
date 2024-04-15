extends LineEdit



var root_relative = "../../../../../../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_text_submitted(_new_text):
	clear()


var initial_input_cleared = false

func clear_text():
	get_node(".").text = ""
	
func do_resize_font():
	var parent_height = get_parent_area_size().y
	var current_font = get_node(".").get("custom_fonts/font")
	current_font.set("size", parent_height * 0.50)

func _gui_input(event):
	if event is InputEventKey:
		if event.pressed and not initial_input_cleared:
			initial_input_cleared = true
			clear_text()
		elif event.pressed and event.scancode == KEY_ENTER and get_node(".").text:
			handle_submit()

	 return false

func handle_submit():
	_on_Submit_pressed()

func _on_Submit_pressed():
		get_node(root_relative).call("_user_input_request",get_node(".").text)
	#_user_input_request(get_node(".").text)
		clear_text()
		pass # Replace with function body.
