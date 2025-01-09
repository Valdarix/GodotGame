extends CharacterBody2D

const SPEED = 110.0
const JUMP_VELOCITY = -300.0

@onready var sprite: AnimatedSprite2D = $PlayerAnim
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

func _physics_process(delta: float) -> void:
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	var direction := Input.get_axis("move_left", "move_right")
	
	sprite.flip_h = true if direction < 0 else false
	
	if is_on_floor():	
		sprite.play("idle" if direction == 0 else "run")
	else:
		sprite.play("jump")		
		
			
	velocity.x = direction * SPEED if direction else move_toward(velocity.x, 0, SPEED)

	move_and_slide()
