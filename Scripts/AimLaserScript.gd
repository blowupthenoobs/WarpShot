@tool
extends RayCast2D

class_name AimLaserScript

@export var laser: Line2D
@export var predictedLandedDot: Sprite2D
@export var startLength: float
@export var maxLength: float
@export var laserWidth: float
@export var laserSpeed: float
@export var firingTime: float
var isCasting: bool = false

var tween: Tween = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setCasting(isCasting)
	laser.points = [Vector2.ZERO, Vector2.RIGHT * startLength]
	laser.visible = false
	
	if(not Engine.is_editor_hint()):
		set_physics_process(false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#target_position.x = move_toward(target_position.x, maxLength, laserSpeed * delta)
	target_position.x = maxLength
	
	var laserEndPos := Vector2(target_position.x, 0)
	force_raycast_update()
	
	if(is_colliding()):
		laserEndPos = to_local(get_collision_point())
		pass
	
	predictedLandedDot.position = laserEndPos
	laser.points[1] = laserEndPos
	pass

func fireLaser() -> void:
	laser.visible = true
	predictedLandedDot.visible = true
	if(tween and tween.is_running()):
		tween.kill()
	tween = create_tween()
	tween.tween_property(laser, "width", laserWidth, firingTime * 2.0).from(0.0)
	pass

func dissipateLaser() -> void:
	if(tween and tween.is_running()):
		tween.kill()
	tween = create_tween()
	tween.tween_property(laser, "width", 0.0, firingTime).from_current()
	tween.tween_callback(laser.hide)
	tween.tween_callback(predictedLandedDot.hide)
	pass

func setCasting(firing: bool) -> void:
	if(isCasting == firing):
		return
	isCasting = firing
	set_physics_process(isCasting)
	
	if(isCasting):
		var laserStart := Vector2.RIGHT * startLength
		laser.points[0] = laserStart
		laser.points[1] = laserStart
		fireLaser()
		pass
	else:
		target_position = Vector2.ZERO
		dissipateLaser()
	pass
