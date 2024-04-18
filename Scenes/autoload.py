from godot import exposed, export
from godot.bindings import *

from io import StringIO
import os, sys
import godot


p = os.path.abspath(os.getcwd())
newp = p + "\\addons\\pythonscript\\windows-64\\lib\\site-packages\\eliza_python_translation\\"
sys.path.insert(0,newp)

from eliza_python_translation import elizaconstant, elizaencoding, elizautil, elizalogic, elizascript, eliza


def dbg_msg(str):
	if autoload.DEBUG:
			print(str)
			
@exposed
class autoload(Node):

	chatbox_node = ""
	DEBUG = True
	script_name = "doctor.txt"
	init_status = False
	load_status = False
	eliza_obj = None
	script_obj = elizascript.Script()
			
	def is_ready(self):
		return self.load_status and self.init_status
		
	def set_chatbox_node(self, node):
		self.chatbox_node = node
		self.init_status = True if node != "" else False
	
	def _ready(self):		
		print("Initializing Eliza...")
		self.init_eliza()
		
	def init_eliza(self):
		try:
			script_str: StringIO = self._load_script(self.script_name)
		except RuntimeError as e:
			dbg_msg("Failed to load file.")
			exit(2)
		script_str_str = script_str.getvalue()
		dbg_msg(f'Script string loaded: {len(script_str_str)} characters in length.')
				
		try:
			status, script = elizascript.ElizaScriptReader.read_script(script_str.getvalue())
		except RuntimeError as e:
			dbg_msg(f"Error loading script: {e.__str__()}")
			exit(2)
			
		dbg_msg(f'Script loaded, {len(script.rules.items())} rules found.')

		if not status:
			dbg_msg("Failed to load script.")		
			exit(2)
			
		self.load_status = status
		self.script_obj = script
		
		self.eliza_obj = eliza.Eliza(script)
		dbg_msg(f'Eliza initialized.')
		self.load_status = True
		
		if self.init_status:
			self._add_eliza_response(str(self._get_script_greeting()))
			
	def _load_script(self, name):
		cd = os.getcwd()
		scr_path = cd + "\\Data\\"+name
		try:
			with open(scr_path, 'r') as file:
				file_content = file.read()
				stringio_obj = StringIO(file_content)
				return stringio_obj
		except FileNotFoundError as e:
			dbg_msg(f"Error: File '{scr_path}' not found.")
			raise e
			
	def send_greeting(self):
		self._add_eliza_response(str(self._get_script_greeting()))
	def _get_script_greeting(self):
		if not self.is_ready:
			return "Hello."
		return self.eliza_obj.get_greeting()
			
	def _user_input_request(self, input):
		if not self.is_ready:
			dbg_msg("Received input but script is not loaded... Dropping...")
			return
		
		node = self.get_tree().get_current_scene().find_node(self.chatbox_node)
		node.call("add_user_request", input)
		
		dbg_msg("Received input: \n " + str(input))
		self._process_eliza_response(input)
			
		
	def _process_eliza_response(self, input):
		
		response = self.eliza_obj.response(str(input))
		dbg_msg("Got response: "+response)
		self._add_eliza_response(response)
		
	def _add_eliza_response(self, response):
		
		if not self.is_ready:
			dbg_msg("Problem receiving response")
			return
			
		node = self.get_tree().get_current_scene().find_node(self.chatbox_node)
		node.call("add_eliza_response", response)
			
		

		
