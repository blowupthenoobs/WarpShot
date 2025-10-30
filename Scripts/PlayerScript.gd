# PlayerScript.gd
extends CharacterBody2D
class_name PlayerScript

@export var deathEffect: PackedScene
@export var bullet: PackedScene
@export var shootSoundEffect: AudioStream
@export var teleportSoundEffect: AudioStream
@export var deathSoundEffect: AudioStream
@export var nozzleBase: Node2D
@export var nozzleEnd: Node2D
@export var laser: AimLaserScript

func _ready() -> void:
	EnemyScript.player = self
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	move_and_slide()
	pass


func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("Shoot") && !MenuScript.instance.stopGame):
		var instance = bullet.instantiate()
		add_sibling(instance)
		instance.SetUpPlayerBullet(nozzleEnd.global_position, (nozzleEnd.global_position - nozzleBase.global_position).normalized(), self)
		MenuScript.instance.PlaySound(shootSoundEffect, 5)
		
	if(event.is_action_pressed("FireAimingLaser")):
		laser.setCasting(true)
	elif(event.is_action_released("FireAimingLaser")):
		laser.setCasting(false)
	pass

func teleport(newPos: Vector2) -> void:
	position = newPos
	MenuScript.instance.PlaySound(teleportSoundEffect, 0)
	pass

func die() -> void:
	var instance = deathEffect.instantiate()
	add_sibling(instance)
	instance.starteffect(nozzleBase.rotation, position)
	MenuScript.instance.PlaySound(deathSoundEffect, 0)
	visible = false
	pass
