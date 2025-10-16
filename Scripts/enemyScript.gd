extends CharacterBody2D
class_name EnemyScript

@export var deathEffect: PackedScene
@export var bullet: PackedScene
@export var nozzleBase: Node2D
@export var nozzleEnd: Node2D

static var player: PlayerScript

@export var maxCooldown: float
var currentCooldown: float

static var enemyCount: int


func _ready() -> void:
	enemyCount += 1
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	nozzleBase.look_at(player.position)
	shoot(delta)
	move_and_slide()


func shoot(delta: float) -> void:
	if(currentCooldown >= maxCooldown):
		var instance = bullet.instantiate()
		add_sibling(instance)
		instance.SetUpBullet(nozzleEnd.global_position, (nozzleEnd.global_position - nozzleBase.global_position).normalized())
		currentCooldown = 0
	else:
		currentCooldown += delta
	pass

func die() -> void:
	var instance = deathEffect.instantiate()
	add_sibling(instance)
	instance.starteffect(rotation, position)
	enemyCount -= 1
	
	if(enemyCount == 0):
		MenuScript.instance.winGame()
	queue_free()
	pass
