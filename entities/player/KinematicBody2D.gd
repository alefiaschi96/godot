extends KinematicBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -1

	var movement = velocity.normalized() * 150 * delta
	self.move_and_collide(movement)
	#self.update_animations(velocity)


#func update_animations(velocity):
	
