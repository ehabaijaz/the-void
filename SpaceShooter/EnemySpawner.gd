extends Node2D

# Comments are made by me
const Enemy = preload("res://SpaceShooter/Enemy.tscn") # Preloading the enemy scene into a variable in order to access instantiation 

onready var spawnPoints = $SpawnPoints # Getting the SpawnPoints node and putting in a variable once the scene is ready to prevent errors


func get_spawn_position():
	var points = spawnPoints.get_children() #SpawnPoints returns an array of Markers 
	points.shuffle() # Shuffles the array of Markers to make the enemies spawn randomly
	return points[0].global_position # Returns the value of the global position of the first marker in the array
	

func spawn_enemy():
	var spawn_position = get_spawn_position() # The returned value is now put in this variable
	var enemy = Enemy.instance() # The instantiation of the preloaded enemy scene in the Enemy variable
	var main = get_tree().current_scene # Gets the current scene thats playing (Space World)
	main.add_child(enemy) # Adds enemy to the main scene
	enemy.position = spawn_position # Makes enemy position to the spawn position

func _on_Timer_timeout():
	spawn_enemy()
