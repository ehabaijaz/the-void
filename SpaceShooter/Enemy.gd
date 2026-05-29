extends Area2D
# Comments are made by me, not AI
const ExplosionEffect = preload('res://SpaceShooter/ExplosionEffect.tscn')


export(int) var SPEED = 200 # exporting the speed var for modification in inspector
export (int) var ARMOR = 3 # same here

func _process(delta):
	position.x -= SPEED * delta # move the position x to the left according to speed and multiply with delta for frame-rate independence


func _on_Enemy_body_entered(body):
	body.create_hit_effect() # if body enters the Enemy. It can be CharacterBody, StaticBody, RigidBody, etc.
	body.queue_free() # Queue_free the body that collided with the enemy aka the bullet
	ARMOR -= 1 # Reducing the armor variable by 1
	if ARMOR <= 0: # if the armor variable reaches 0 or less than zero in rare cases (to prevent bugs)
		var main = get_tree().current_scene # Getting access to main scene
		if main.is_in_group("World"): # khan dress
			main.score += 10
		queue_free() # queue_free the enemy


func _on_VisibilityNotifier2D_screen_exited(): # if the enemy has exited the screen
	queue_free() # queue_free the enemy

func _exit_tree(): # Once the enemy dies or exits the tree by queue_free()
	var main = get_tree().current_scene # Gets the main sceen which is SpaceWorld
	var explosion_effect = ExplosionEffect.instance() # Instances the explosion effect
	main.add_child(explosion_effect) # Adds it to SpaceWorld
	explosion_effect.global_position = global_position  # Makes position of the explosion where Enemy is
