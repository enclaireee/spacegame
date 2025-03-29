extends CharacterBody2D

@export var speed: float = 300.0  
@export var acceleration: float = 300.0  
@export var friction: float = 500.0  
@export var max_hp: int = 3  

var current_hp: int

func _ready():
	current_hp = max_hp  

func _physics_process(delta):
	var direction = Vector2.ZERO  

	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()

func _on_body_entered(body):
	if body.is_in_group("obstacles"):
		current_hp -= 1
		print("HP:", current_hp)
		
		if current_hp <= 0:
			die()

func die():
	print("Player Died!")  
	queue_free()
