from godot import exposed, export, InputEventMouseButton
from godot import *
import os


from eliza_python_translation import constant, encoding, util, elizalogic, elizascript

@exposed
class ElizaDialogScene(CanvasLayer):

	# member variables here, example:
	a = export(int)
	b = export(str, default='foo')

	DEBUG = True
	script_name = "doctor.txt"
	script_obj = elizascript.Script()
	load_status = False
	def _ready(self):
		"""
		Called every time the node is added to the scene.
		Initialization here.
		"""
		
	def init_eliza(self):
		try:
			script_str: StringIO = self._load_script(ElizaDialogScene.script_name)
		except RuntimeException as e:
			print("Failed to load file.")
			exit(2)
		script_str_str = script_str.getvalue()
		if ElizaDialogScene.DEBUG:
			print(f'Script string loaded: {len(script_str_str)} characters in length.')
				
		try:
			status, script = elizascript.ElizaScriptReader.read_script(script_str.getvalue())
		except RuntimeError as e:
			print(f"Error loading script: {e.__str__()}")
			exit(2)
			
		if ElizaDialogScene.DEBUG:
			print(f'Script loaded, {len(script.rules.items())} rules found.')

		if not status:
			print("Failed to load script.")		
			exit(2)
			
		ElizaDialogScene.load_status = status
		ElizaDialogScene.script_obj = script
		
		if ElizaDialogScene.DEBUG:
			print(f'Eliza initialized.')
			
	def _load_script(self, name):
		cd = os.getcwd()
		scr_path = cd + "\\Data\\"+name
		try:
			with open(scr_path, 'r') as file:
				file_content = file.read()
				stringio_obj = elizascript.StringIO(file_content)
				return stringio_obj
		except FileNotFoundError as e:
			print(f"Error: File '{scr_path}' not found.")
			raise e
			
	def _on_ElizaCharacter_gui_input(self, event):
		
		if 'InputEventMouseButton' in str(event.__class__) :
			self.init_eliza()
		
	def _get_eliza_response(self, input):
		pass
		
