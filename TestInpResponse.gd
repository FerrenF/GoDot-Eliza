extends VBoxContainer


func set_text(input: String, response: String):
	$Input.text = " > " + input
	$Response.text = response
