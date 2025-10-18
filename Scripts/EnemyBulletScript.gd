extends "res://Scripts/BulletScript.gd"

var mostRecentBounce = null

func collisionEffect(collision: KinematicCollision2D):
	var collider = collision.get_collider()
	if(collider is PlayerScript):
		collider.die()
		pass
	elif collider is TileMapLayer:
		var tilemap_layer: TileMapLayer = collider
		var collidedPhysicsBodyRID = collision.get_collider_rid()
		var cell_coord = tilemap_layer.get_coords_for_body_rid(collidedPhysicsBodyRID)
		var data = tilemap_layer.get_cell_tile_data(cell_coord)
		
		match data.get_custom_data("TileType"):
			"bouncy":
				var bounceDirection: Vector2 = movementDirection
				
				if (collision.get_normal().x != 0):
					bounceDirection.x *= -1
				if (collision.get_normal().y != 0):
					bounceDirection.y *= -1
				
				
				if((bounceDirection == movementDirection * -1)):
					if(abs(collision.get_normal().x) > abs(collision.get_normal().y)):
						bounceDirection.y *= -1
					else:
						bounceDirection.x *= -1
					pass
				
				if(mostRecentBounce != cell_coord):
					super.SetUpBullet(position, (bounceDirection) * 1.15)
				mostRecentBounce = cell_coord
		return
	queue_free()
