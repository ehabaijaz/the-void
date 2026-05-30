extends Area2D

# Comments are made by me, not AI.. uhh i got bored of writing comments so i stopped halfway
const ExplosionEffect = preload('res://SpaceShooter/ExplosionEffect.tscn') # Preloading the explosion effect scene 
const Bullet = preload("res://SpaceShooter/Laser.tscn") # Preloading the bullet scene in bullet var
export(int) var SPEED = 500 # Exporting the speed variable so modification in inspector is possible
var can_move = false
signal player_death

func _process(delta): # Runs every second
	if Input.is_action_just_pressed("seven"):
		can_move = true
	if Input.is_action_pressed('ui_up'): # If the player presses the up arrow key
		position.y -= SPEED * delta # Make the ship move up by speed * delta to make movement frame rate independent
	if Input.is_action_pressed('ui_down'): 
		position.y += SPEED * delta # Moves shp down
	if Input.is_action_just_pressed('ui_accept'): # If player presses enter key or space bar
		fire_bullet() # Call fire bullet func
	if Input.is_action_just_pressed("powerup"):
		for i in range(5):
			fire_bullet()
		$PowerupTimer.start()
		if not $PowerupTimer.is_stopped():
			pass
			
	if Input.is_action_just_pressed("invisibility"):
		$InvisibilityTimer.start()
		if not $InvisibilityTimer.is_stopped():
			$Sprite.modulate = Color(1.0,0.0,0.0,1.0)
			$CollisionPolygon2D.set_deferred("disabled", true)
	if can_move == true:
		if Input.is_action_pressed('ui_left'):
			position.x -= SPEED * delta
		if Input.is_action_pressed('ui_right'):
			position.x += SPEED * delta

	
		
		
		
		
func fire_bullet():
	var bullet = Bullet.instance() # Instantiating the Bullet preload
	var main = get_tree().current_scene # Getting the current scene and putting that in main var
	main.add_child(bullet) # Adding the child bullet to the main scene
	bullet.global_position = global_position # Making bullet global position the global position of the ship


func _on_Ship_area_entered(area): # If area enters the ship (the only other area is enemy, atleast so far)
	area.queue_free()  #queue free the area that collided with the ship aka the enemy
	queue_free() # queue_free the ship

func _exit_tree():
	var main = get_tree().current_scene
	var explosion_effect = ExplosionEffect.instance()
	main.call_deferred("add_child",explosion_effect)
	explosion_effect.global_position = global_position # The same as death of enemy 
	emit_signal("player_death")



func _on_InvisibilityTimer_timeout():
		$Sprite.modulate = Color(1.0,1.0,1.0,1.0)
		$CollisionPolygon2D.set_deferred("disabled", false)
