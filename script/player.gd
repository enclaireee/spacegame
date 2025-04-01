extends CharacterBody2D

@export var speed: float = 300.0  
@export var acceleration: float = 300.0  
@export var friction: float = 500.0  
@export var max_hp: int = 3  
@export var projectile_scene: PackedScene = preload("res://scenes/player_proj.tscn")

var current_hp: int

func _ready():
	current_hp = max_hp  

func _physics_process(delta):
	var direction = Vector2.ZERO  
	# change "move_right" "move_left" input with wavelength input (?)
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
	
	if Input.is_action_just_pressed("move_up"):
		shoot()

func die():
	print("Player Died!")  
	queue_free()
	


# implement player proj 
func shoot():
	var bullet = projectile_scene.instantiate()
	bullet.position = position + Vector2(0, -20)
	get_parent().add_child(bullet)

# todo: add velocity modifier based on focus input 
