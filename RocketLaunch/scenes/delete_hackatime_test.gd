extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var list = ["apple", "banana", "tomato"]
# Called when the node enters the scene tree for the first time.
func _ready():
	print("On testing hackatime")
	for i in range(list):
		print(list[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
