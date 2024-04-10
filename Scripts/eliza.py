# eliza_wrapper.gd

from godot import exposed, Node
from eliza_python_translation.eliza import Eliza

@exposed
class Eliza(Node):
	def __init__(self):
		super().__init__()
		self.initialize()

	def initialize(self):
		print("test")

	def reset(self):
		# Reset any conversation state if needed
		pass

	def initial(self):
		# Return initial greeting
		pass

	def respond(self, user_input):
		# Determine appropriate response based on user input
		return "fart"
