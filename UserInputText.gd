extends LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_text_submitted(_new_text):
	clear()
	
export var response_char_limit = 256
export var errmsg_toolong = "WOW I AM NOT GOING TO READ ALL OF THAT"
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
	var t = get_node(".").text
	
	if t == "":
		#reject
		return
		
	if len(t) > response_char_limit:
		autoloadpy.call("_add_eliza_response", errmsg_toolong)
		clear_text()
		return
		
	autoloadpy.call("_user_input_request",t)
	clear_text()
