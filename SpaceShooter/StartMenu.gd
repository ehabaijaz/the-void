extends Node


func _ready():
	pass


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://SpaceShooter/SpaceWorld.tscn")
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()



func _on_PiggyButton_pressed():
	get_tree().change_scene("res://Piggy/scenes/PiggyWorld.tscn")


func _on_RocketButton_pressed():
	get_tree().change_scene("res://RocketLaunch/scenes/launch_world.tscn")
