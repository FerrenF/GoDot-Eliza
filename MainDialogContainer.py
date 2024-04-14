from godot import exposed, export
from godot import *

from io import StringIO
import os, sys
import godot

p = os.path.abspath(os.getcwd())
newp = p + "\\addons\\pythonscript\\windows-64\\lib\\site-packages\\eliza_python_translation\\"
sys.path.insert(0,newp)

from eliza_python_translation import elizaconstant, elizaencoding, elizautil, elizalogic, elizascript, eliza

@exposed
class MainDialogContainer(PanelContainer):

   
	# member variables here, example:
	name = export(str)
	chatbox_node = "MainContentContainer/VerticalLayoutContainer/MiddleRow/ElizaResponseArea/ElizaChat"
	DEBUG = True
	script_name = "doctor.txt"
	script_obj = elizascript.Script()
	load_status = False
	def _ready(self):		
		print("Initializing Eliza...")
		self.init_eliza()
		
	def init_eliza(self):
		try:
			script_str: StringIO = self._load_script(MainDialogContainer.script_name)
		except RuntimeError as e:
			print("Failed to load file.")
			exit(2)
		script_str_str = script_str.getvalue()
		if MainDialogContainer.DEBUG:
			print(f'Script string loaded: {len(script_str_str)} characters in length.')
				
		try:
			status, script = elizascript.ElizaScriptReader.read_script(script_str.getvalue())
		except RuntimeError as e:
			print(f"Error loading script: {e.__str__()}")
			exit(2)
			
		if MainDialogContainer.DEBUG:
			print(f'Script loaded, {len(script.rules.items())} rules found.')

		if not status:
			print("Failed to load script.")		
			exit(2)
			
		MainDialogContainer.load_status = status
		MainDialogContainer.script_obj = script
		
		self.eliza_obj = eliza.Eliza(script.rules, script.mem_rule)
		if MainDialogContainer.DEBUG:
			print(f'Eliza initialized.')
			
	def _load_script(self, name):
		cd = os.getcwd()
		scr_path = cd + "\\Data\\"+name
		try:
			with open(scr_path, 'r') as file:
				file_content = file.read()
				stringio_obj = StringIO(file_content)
				return stringio_obj
		except FileNotFoundError as e:
			print(f"Error: File '{scr_path}' not found.")
			raise e
			
	def _user_input_request(self, input):
		if not MainDialogContainer.load_status:
			if MainDialogContainer.DEBUG:
				print("Received input but script is not loaded... Dropping...")
			return
		
		node = self.get_node(self.chatbox_node)
		node.call("add_user_request", input)
		
		if MainDialogContainer.DEBUG:
				print("Received input: ")
				print(input)
		self._process_eliza_response(input)
			
		
	def _process_eliza_response(self, input):
		
		if not MainDialogContainer.load_status:
			if MainDialogContainer.DEBUG:
				print("Problem receiving response")
				
		response = self.eliza_obj.response(str(input))
		if MainDialogContainer.DEBUG:
			print("Got response: ")
			print(response)			
			node = self.get_node(self.chatbox_node)
			node.call("add_eliza_response", response)
			
		
