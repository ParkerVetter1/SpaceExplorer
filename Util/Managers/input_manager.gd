class_name InputManager
extends Node

signal interact
signal action

func _input(event):
	#signal sent to Trader.gd, playerSwing.gd, playerMovement.gd
	if event.is_action_pressed("interact"): emit_signal("interact")
	#signal sent to Trader.gd, playerSwing.gd
	if event.is_action_pressed("action"): emit_signal("action")
