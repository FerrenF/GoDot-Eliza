extends RichTextLabel


var max_lines = 30
export var tracer_text_color = "white"

export var eliza_name_text_color = "blue"
export var eliza_response_text_color = "white"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func append_bbline(line):
	var current_lines = get_node(".").bbcode_text
	var li = PoolStringArray([]) if current_lines.empty() else current_lines.split('\n')
	var current_count = len(li)
	if current_count > max_lines:
		li.remove(0)
		
	li.push_back(line)
	current_lines = li.join('\n')
	get_node(".").bbcode_text = current_lines
	
	
func add_tracer_response(text_input, response):	

	var to_append = '[color='+eliza_name_text_color+']ELIZA:\t[/color]'
	to_append += '[color='+eliza_response_text_color+']'+text_input+'[/color]\n[color=yellow]DECOMPOSITION:[/color]\n'
	to_append += '[color='+tracer_text_color+']'+response+'[/color]'
	append_bbline(to_append)

