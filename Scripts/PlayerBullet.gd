extends "res://Scripts/BulletScript.gd"

var player: PlayerScript

var mostRecentBounce = null

func SetUpPlayerBullet(spawnPoint: Vector2, direction: Vector2, owner: CharacterBody2D) -> void:
	super.SetUpBullet(spawnPoint, direction)
	player = owner
	pass

func collisionEffect(collision: KinematicCollision2D):
	var collider = collision.get_collider()
	if(collider is EnemyScript):
		collider.die()
		player.teleport(collider.position)
		pass
	elif collider is TileMapLayer:
		var tilemap_layer: TileMapLayer = collider
		var collidedPhysicsBodyRID = collision.get_collider_rid()
		var cell_coord = tilemap_layer.get_coords_for_body_rid(collidedPhysicsBodyRID)
		var data = tilemap_layer.get_cell_tile_data(cell_coord)
		
		match data.get_custom_data("TileType"):
			"normal":
				player.die()
				queue_free()
			"stationary":
				player.teleport(position)
				queue_free()
			"bouncy":
				var bounceDirection: Vector2 = movementDirection
				
				if (collision.get_normal().x != 0):
					bounceDirection.x *= -1
				if (collision.get_normal().y != 0):
					bounceDirection.y *= -1
				
				if(mostRecentBounce != cell_coord):
					super.SetUpBullet(position, (bounceDirection) * 1.15)
				mostRecentBounce = cell_coord
			_:
				player.die()
				print("tile type undefined")
				queue_free()
		return
		pass
	else:
		player.die()
		#player.teleport(position)
	queue_free()
