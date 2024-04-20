extends RichTextEffect
class_name RichTextType
var bbcode = "typewrite"
var counter: int = 0

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var speed: float = char_fx.env.get("speed", 20.0)
	var wait: int = char_fx.env.get("delay", 0.0)

	char_fx.visible = false
	if char_fx.elapsed_time * speed - wait >= char_fx.relative_index:
		char_fx.visible = true
	return true
