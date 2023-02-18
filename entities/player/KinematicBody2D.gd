extends KinematicBody2D


var pokeball_counter = 0

signal pokeball_taken
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

	var movement = velocity.normalized() * 100 * delta
	self.move_and_collide(movement)
	self.update_animations(velocity)
	
	if $RayCast2DPlayer.is_colliding():
		var collider = $RayCast2DPlayer.get_collider()
		if collider and Input.is_key_pressed(KEY_SPACE) and "StaticBody2DPokeball" in collider.name:
			collider.queue_free()
			pokeball_counter += 1
			emit_signal("pokeball_taken", pokeball_counter)
			

func update_animations(velocity):
	if velocity.y == 1:
		$AnimatedSpritePlayer.play("walk_down")
		$RayCast2DPlayer.cast_to = Vector2(0, +20)
	elif velocity.y == -1:
		$AnimatedSpritePlayer.play("walk_up")
		$RayCast2DPlayer.cast_to = Vector2(0, -20)
	elif velocity.x == -1:
		$AnimatedSpritePlayer.flip_h = false
		$AnimatedSpritePlayer.play("walk_left")
		$RayCast2DPlayer.cast_to = Vector2(-20, 0)
	elif velocity.x == 1:
		$AnimatedSpritePlayer.play("walk_left")
		$AnimatedSpritePlayer.flip_h = true
		$RayCast2DPlayer.cast_to = Vector2(20, 0)
		
	if velocity == Vector2():
		if $AnimatedSpritePlayer.animation == "walk_down":
			$AnimatedSpritePlayer.play("stand_down")
		elif $AnimatedSpritePlayer.animation == "walk_up":
			$AnimatedSpritePlayer.play("stand_up")
		elif $AnimatedSpritePlayer.animation == "walk_left":
			$AnimatedSpritePlayer.play("stand_left")
