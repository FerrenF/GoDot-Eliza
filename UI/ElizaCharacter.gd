extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
class_name ElizaCharacter

onready var nodes = {
	"mouth" : $CharacterRect/MouthControl/MouthSprite, #AnimatedSprite
	# state: default, neutral, speak_happy, speak_neutral
	"eyes" : $CharacterRect/EyeControl/EyeSprite #AnimatedSprite
	# states: default, blink
}

export var blink_range_min = 2
export var blink_range_max = 5

var blink_timer = Timer.new()
var talk_timer = Timer.new()

var talk_spacing = 0.25
var effect_speed = 20
var talk_counter = 0
func _textfx_typing_str(s):	
	var estimated_time_to_speak = (len(s)+1)/effect_speed
	var how_many_talks = floor(estimated_time_to_speak / talk_spacing)
	talk_counter = how_many_talks
	talk_timer.wait_time = talk_spacing
	talk_timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	blink_timer.wait_time = rand_range(blink_range_min, blink_range_max) # Adjust these values for blink frequency
	blink_timer.connect("timeout", self, "_blink_tick")
	talk_timer.connect("timeout", self, "_talk")
	add_child(blink_timer)
	add_child(talk_timer)
	blink_timer.start()

func _blink_tick():
	_blink(true)

func _blink(reset_timer=false):
	_change_anim("eyes", "blink")
	if not reset_timer:
		return
	blink_timer.stop()
	blink_timer.wait_time = rand_range(blink_range_min, blink_range_max) # Adjust these values for blink frequency
	blink_timer.start()
	
func _set_eyes(closed=false):
	_change_anim("eyes", "closed" if closed else "default")

var smile_state = true
func _smile():
	smile_state = true
	_changed_expression()

func _neutral_expression():
	smile_state = false
	_changed_expression()
	
func _changed_expression():
	_change_anim("mouth", "default" if smile_state else "neutral")
	
func _talk():	
	_change_anim("mouth", "speak_happy" if smile_state else "speak_neutral")
	if talk_counter > 0:
		talk_counter -= 1
		if talk_counter == 0:
			talk_timer.stop()
		else:
			talk_timer.start() # Restart the timer for the next talk
	
func _start_talking(smile=true):
	_talk()
	
func _stop_talking(smile=true):
	_talk()
	
func _change_anim(node_name, new_state="default"):
	if not node_name in nodes.keys():
		return
	var node: AnimatedSprite = nodes[node_name]
	node.stop()
	node.animation = "default"
	node.animation = new_state
	node.play()
	
