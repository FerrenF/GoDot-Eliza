from godot import exposed, export
from godot import *

from eliza_python_translation import constant, encoding, util, elizalogic, elizascript

@exposed
class ElizaDialogScene(CanvasLayer):

	# member variables here, example:
	a = export(int)
	b = export(str, default='foo')

	
	script = elizascript.Script()
	def _ready(self):
		"""
		Called every time the node is added to the scene.
		Initialization here.
		"""
		print("Test")
		pass

