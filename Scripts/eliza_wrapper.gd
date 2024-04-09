# eliza_wrapper.gd

extends Node

# Preload the Python module containing the Eliza class
const ElizaPython = preload("res://Scripts/eliza.py")

class_name ElizaWrapper

# Initialize the Eliza chatbot
var eliza_chatbot = Scripts.Eliza()

func _ready():
	eliza_chatbot.initialize()
	pass

# Function to start a conversation with Eliza
func start_conversation():
	# Reset the chatbot for a new conversation
	eliza_chatbot.reset()
	# Return initial message from Eliza
	return eliza_chatbot.initial()

# Function to continue the conversation with Eliza
func continue_conversation(user_input):
	
	var response = eliza_chatbot.respond(user_input)
	# Return Eliza's response
	return response
