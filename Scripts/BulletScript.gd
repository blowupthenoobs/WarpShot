extends CharacterBody2D

@export var maxSpeed: float
var currentSpeed: float
@export var accelleration: float

var movementDirection: Vector2

func SetUpBullet(spawnPoint: Vector2, direction: Vector2) -> void:
	position = spawnPoint
	movementDirection = direction
	look_at(position + direction)
	pass

func _physics_process(delta: float) -> void:
	if(!MenuScript.instance.stopGame):
		alterSpeed(delta)
		velocity = movementDirection * currentSpeed * delta
		var collision = move_and_collide(velocity)
		if collision:
			collisionEffect(collision)
		alterSpeed(delta)

func alterSpeed(delta: float):
	if(currentSpeed < maxSpeed):
		currentSpeed += accelleration * delta
	else:
		currentSpeed = maxSpeed
	pass

func collisionEffect(collision: KinematicCollision2D):
	queue_free()
