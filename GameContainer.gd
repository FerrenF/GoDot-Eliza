
class_name GameContainer

extends CanvasLayer

export var min_win = Vector2(500,500)

const InputResponse = preload("res://TestInpResponse.tscn")

export (int) var max_lines_remembered := 30
var max_scroll_length := 0

onready var dialogueHistory_rows = $MainContentBackground/MainContentContainer/VerticalLayoutContainer/MiddleRow/ElizaResponseArea/ScrollContainer/DialogHistory
onready var scroll = $MainContentBackground/MainContentContainer/VerticalLayoutContainer/MiddleRow/ElizaResponseArea/ScrollContainer
onready var scrollbar = scroll.get_v_scrollbar()
onready var def_siz = OS.window_size

# When text is entered it scrolls to the bottom of the chat history
func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value
		scroll.scroll_vertical = max_scroll_length


# Saves up to 30 instances of the users response & makes it visible to the scene before deleting past chat resposes
func _on_UserInputText_text_entered(new_text):
	var input_response = InputResponse.instance()
	input_response.set_text(new_text, "Placeholder Text")
	dialogueHistory_rows.add_child(input_response)
	
	delete_history_beyond_limit()


func delete_history_beyond_limit():
	if dialogueHistory_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = dialogueHistory_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			dialogueHistory_rows.get_child(i).queue_free()


func _ready():
	OS.min_window_size = min_win
	scrollbar.connect("changed", self, "handle_scrollbar_changed")
	max_scroll_length = scrollbar.max_value
	

func window_resize_handler():
	if not def_siz:
		return
	var winsz = OS.window_size
	var change = Vector2(winsz.x - def_siz.x, winsz.y - def_siz.y)
	if abs(change.x):
		OS.window_size = Vector2(winsz.x,winsz.x)
	else:
		OS.window_size = Vector2(winsz.y,winsz.y)
	
	get_tree().call_group("dynamic_text_size", "do_resize_font")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

