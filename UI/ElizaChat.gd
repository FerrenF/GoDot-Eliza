extends RichTextLabel


var max_lines = 30
var user_name_text_color = "green"
var user_request_text_color = "white"
var eliza_name_text_color = "blue"
var eliza_response_text_color = "white"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func append_bbline(line, typewrite=false, wrapper=[]):
	var current_lines = get_node(".").bbcode_text
	var li = PoolStringArray([]) if current_lines.empty() else current_lines.split('\n')
	var current_count = len(li)
	if current_count > max_lines:
		li.remove(0)
	
	
	# strip all typewriting effects.

	var regex = RegEx.new()
	regex.compile("(.*)\\[typewrite\\](.*?)\\[\\/typewrite\\](.*)")

	for n in range(li.size() - 1, -1, -1):
		var st = li[n]
		var matches = regex.search_all(st)
		
		for mtch in matches:
			var before_typewrite = mtch.get_string(1)  # Content before [typewrite] tag
			var typewrite_content = mtch.get_string(2)  # Content within [typewrite] tags
			var after_typewrite = mtch.get_string(3)  # Content after [/typewrite] tag
			st = before_typewrite + typewrite_content + after_typewrite
		
		li[n] = st
	
	# Add one back if we need it
	if typewrite:
		line = '[typewrite]'+line+'[/typewrite]'
		
	# Apply a wrapper if we have one
	if wrapper:
		line = wrapper[0] + line;
		if len(wrapper) > 1:
			line += wrapper[1]
		
	li.push_back(line)
	current_lines = li.join('\n')
	get_node(".").bbcode_text = current_lines
	
func add_eliza_response(response):
	var to_append = '[color='+eliza_response_text_color+']'+response+'[/color]'
	var wrapper = [ '[color='+eliza_name_text_color+']ELIZA:\t[/color]' ]
	append_bbline(to_append, true, wrapper)


func add_user_request(request):
	var to_append =  '[color='+user_request_text_color+']'+request+'[/color]'
	var wrapper = ['[color='+user_name_text_color+']YOU:\t[/color]']
	append_bbline(to_append, false, wrapper)
