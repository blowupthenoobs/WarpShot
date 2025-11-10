extends RemoteTransform2D


var usingController: bool

func _process(delta: float) -> void:
	
	if(!MenuScript.instance.stopGame || MenuScript.instance.rotateAnyway):
		if(usingController):
			var aimX = Input.get_joy_axis(0, JOY_AXIS_LEFT_X)
			var aimY = Input.get_joy_axis(0, JOY_AXIS_LEFT_Y)
			
			if(Vector2(aimX, aimY).length() > 0.7):
				rotation = Vector2(aimX, aimY).angle()
		else:
			look_at(get_global_mouse_position())
		
	pass



func _input(event: InputEvent) -> void:
	if(event is InputEventMouseMotion):
		usingController = false
	if(event is InputEventJoypadMotion):
		usingController = true
	pass
