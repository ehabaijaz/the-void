extends Area2D

export(int) var SPEED = 200 # exporting the speed var for modification in inspector
export (int) var ARMOR = 3 # same here

func _process(delta):
	position.x -= SPEED * delta # move the position x to the left according to speed and multiply with delta for frame-rate independence


func _on_Enemy_body_entered(body): # if body enters the Enemy. It can be CharacterBody, StaticBody, RigidBody, etc.
	body.queue_free() # Queue_free the body that collided with the enemy aka the bullet
	ARMOR -= 1 # Reducing the armor variable by 1
	if ARMOR <= 0: # if the armor variable reaches 0 or less than zero in rare cases (to prevent bugs)
		queue_free() # queue_free the enemy


func _on_VisibilityNotifier2D_screen_exited(): # if the enemy has exited the screen
	queue_free() # queue_free the enemy
