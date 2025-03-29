extends CharacterBody2D

@export var speed: float = 100.0
@export var move_distance: float = 200.0
@export var fire_rate: float = 1.5
@export var projectile_scene: PackedScene 

var direction: int = 1
var start_x: float

func _ready():
	start_x = position.x
	$ShootTimer.wait_time = fire_rate
	$ShootTimer.start()
	$ShootTimer.connect("timeout", _on_shoot_timer_timeout)
	
	$MoveTimer.wait_time = 2.0
	$MoveTimer.start()
	$MoveTimer.connect("timeout", _on_move_timer_timeout)

func _process(delta):
	position.x += direction * speed * delta
	
	if abs(position.x - start_x) >= move_distance:
		direction *= -1

func _on_shoot_timer_timeout():
	var bullet = projectile_scene.instantiate()
	bullet.position = position
	get_parent().add_child(bullet)

func _on_move_timer_timeout():
	direction *= -1
