extends Node2D


@onready  var bullet = preload("res://scenes/Attack/bullet.tscn")
@onready var bulletTimer = get_node("%bulletTimer")
@onready var bulletAtkTimer = get_node("%bulletAtkTimer")
@onready var player = get_tree().get_first_node_in_group("player")


#bullet
var bullet_level:int = 1
var bullet_ammo: = 5
var bullet_base_ammo: =10
var bullet_attack_speed: =0.5


func attack() -> void:
	var bulletlvl = bullet_level
	if bulletlvl >= 1:
		bulletTimer.wait_time =bullet_attack_speed
		if bulletTimer.is_stopped():
			bulletTimer.start()

func _on_bullet_atk_timer_timeout():
	if bullet_ammo > 0:
		var bullet_shoot = bullet.instantiate()
		bullet_shoot.position = player.position
		bullet_shoot.target = get_target()
		get_parent().add_sibling(bullet_shoot)
		bullet_ammo -=1
		if(bullet_ammo>0):
			bulletAtkTimer.start()
		else:
			bulletAtkTimer.stop()
		

func _on_bullet_timer_timeout() -> void:
	bullet_ammo +=bullet_base_ammo

func get_target()->Vector2:
	if player.enemy_closed.size() > 0:
		return get_closest_enemy(global_position, player.enemy_closed).global_position
	else:
		return Vector2.UP

func get_closest_enemy(current_position: Vector2, enemies):
	var closest_enemy = null
	var closest_distance:float = 1e20  # Initialize with a large number
	
	for enemy in enemies:
		var distance = current_position.distance_to(enemy.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = enemy
	return closest_enemy

