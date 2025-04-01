extends CharacterBody2D

@export var speed: float = 100.0
@export var move_distance: float = 200.0
@export var fire_rate: float = 1.5
@export var max_hp: int = 3  
@export var projectile_scene: PackedScene = preload("res://scenes/projectile.tscn")
var direction: int = 1
var start_x: float
var current_hp: int


func _ready():
	start_x = position.x
	current_hp = max_hp
	
	var shoot_timer = $ShootTimer
	shoot_timer.wait_time = fire_rate
	shoot_timer.one_shot = false
	shoot_timer.start()
	shoot_timer.timeout.connect(self.on_shoot_timer_timeout)
	
	var move_timer = $MoveTimer
	move_timer.wait_time = 1.0
	move_timer.one_shot = false
	move_timer.start()
	move_timer.timeout.connect(self.on_move_timer_timeout)

func _process(delta):
	position.x += direction * speed * delta
	
	if abs(position.x - start_x) >= move_distance:
		direction *= -1

func on_shoot_timer_timeout():
	var bullet = projectile_scene.instantiate()
	bullet.position = position + Vector2(0, 20)  # Offset to spawn below the enemy
	
	get_parent().add_child(bullet)

func on_move_timer_timeout():
	direction *= -1

func _on_move_timer_timeout() -> void:
	pass 

func die() -> void:
	print("Enemy Died!")
	queue_free()
