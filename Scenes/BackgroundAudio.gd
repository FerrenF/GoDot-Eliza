
extends AudioStreamPlayer

class_name BGAudio
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var bg_vol_percent = 25.0;
export var fade_duration = 3.0

var loop_files = [
	"res://Sound/9. Harris Heller - Warm Peach_head.mp3",
	"res://Sound/9. Harris Heller - Warm Peach_loop.mp3",
	"res://Sound/9. Harris Heller - Warm Peach_tail.mp3"
]
var loop_end = false

func toggleAudio(state = !is_playing()):
	if state:
		self.stream_paused = false
	else:
		self.stream_paused = true
	
func change_stream(new_stream: AudioStream):
	stop()
	self.stream = new_stream
	play()
	
func playBackgroundMusic(head_resource: String, loop_resource: String, tail_resource: String) -> void:
	var head_stream = load(head_resource)
	var loop_stream = load(loop_resource)
	var tail_stream = load(tail_resource)
	
	# Set the head audio file
	
	self.volume_db = -40
	change_stream(head_stream)

	# Fade in the music
	var start_time = OS.get_system_time_msecs()
	var elapsed_time = 0.0
	while elapsed_time < fade_duration:
		self.volume_db = -40 + (elapsed_time / fade_duration) * 40*(bg_vol_percent/100)
		# max out at half volume
		elapsed_time = (OS.get_system_time_msecs() - start_time) / 1000.0
		yield(get_tree(), "idle_frame")

	while is_playing():
		yield(get_tree(), "idle_frame")
			
	change_stream(loop_stream)

	while not loop_end:
		# Wait for head track to finish
		while is_playing():
			yield(get_tree(), "idle_frame")

	
	change_stream(tail_stream)

	# Wait for tail track to finish
	while is_playing():
		yield(get_tree(), "idle_frame")

func enqueue_stream(stream: AudioStream, loop: bool=false) -> void:
	var stream_instance = AudioStreamPlayer.new()
	stream_instance.stream = stream
	stream_instance.loop = loop
	add_child(stream_instance)
	stream_instance.play()
	
# Called when the node enters the scene tree for the first time.
func _ready():

	playBackgroundMusic(loop_files[0], loop_files[1], loop_files[2])



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
