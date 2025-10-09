# PlayerScript.gd
extends CharacterBody2D
class_name PlayerScript

@export var bullet: PackedScene
@export var nozzleBase: Node2D
@export var nozzleEnd: Node2D

# Called when the node enters the scene tree for the first time.
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
	pass

func teleport(newPos: Vector2) -> void:
	position = newPos
	pass

func die() -> void:
	print("died")
	EnemyScript.enemyCount = 0
	get_tree().reload_current_scene()
	pass
