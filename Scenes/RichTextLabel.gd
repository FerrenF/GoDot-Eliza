extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var escript = "ELIZA is an early natural language processing experiment by Joseph Weisenbaumm. This game is a  simulation of the recreation of this chatbot, made for learning purposes. ELIZA was originally designed to respond to user input as if it were an elizabethian style therapist. We have elevated that here with some art and convienence."

# Called when the node enters the scene tree for the first time.
func _ready():
	self.bbcode_text = "[typewrite]"+escript+"[/typewrite]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
