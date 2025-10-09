extends "res://Scripts/BulletScript.gd"

func collisionEffect(collision: KinematicCollision2D):
	if(collision.get_collider() is PlayerScript):
		collision.get_collider().die()
		pass
	queue_free()
