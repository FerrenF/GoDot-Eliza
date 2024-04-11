from godot import exposed, export
from godot import *

import os
import godot

from eliza_python_translation import constant, encoding, util, elizalogic, elizascript, eliza

@exposed
class MainDialogContainer(PanelContainer):

   
	# member variables here, example:
	name = export(str)

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
		except RuntimeException as e:
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
				stringio_obj = elizascript.StringIO(file_content)
				return stringio_obj
		except FileNotFoundError as e:
			print(f"Error: File '{scr_path}' not found.")
			raise e
			
	def _user_input_request(self, input):
		if not MainDialogContainer.load_status:
			if MainDialogContainer.DEBUG:
				print("Received input but script is not loaded... Dropping...")
			return
		if MainDialogContainer.DEBUG:
				print("Received input: ")
				print(input)
		self._get_eliza_response(input)
			
	def _on_ElizaCharacter_gui_input(self, event):
		pass
		
	def _get_eliza_response(self, input):
		if not MainDialogContainer.load_status:
			if MainDialogContainer.DEBUG:
				print("Problem receiving response")
				
		response = self.eliza_obj.response(str(input))
		if MainDialogContainer.DEBUG:
			print("Got response: ")
			print(response)
			node = self.get_node("VBoxContainer/HBoxContainer2/ElizaDialogBox/ElizaText")
			node.text = response
		
		
