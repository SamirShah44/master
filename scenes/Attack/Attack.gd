extends Node2D

@onready var rotatingBullet = preload("res://scenes/Attack/RotatingAttack.tscn")
@onready var meteor = preload("res://scenes/Attack/meteorite.tscn")
@onready var bullet = preload("res://scenes/Attack/bullet.tscn")
@onready var bulletTimer = get_node("%bulletTimer")
@onready var bulletAtkTimer = get_node("%bulletAtkTimer")
@onready var meteorTimer = get_node("%meteorTimer")
@onready var meteorAtkTimer = get_node("%MeteorAtkTimer")
@onready var player = get_tree().get_first_node_in_group("player")

@onready var rotatingTimer = get_node("%rotatingTimer")
@onready var rotatingAtkTimer =get_node("%rotatingAtkTimer")

#bullet
var bullet_level:int =1
var bullet_ammo:int = 1
var bullet_base_ammo:int =1
var bullet_attack_speed:float =0.8

#meteorite
var meteorite_level : int =1
var meteorite_count : int = 1
var meteorite_base_count : int = 1
var meteorite_base_attack_speed: float = 1.1

#Rotating attack
@onready var shoot_timer = $RotatingAtk/ShootTimer
@onready var rotater = $RotatingAtk/Rotater
var rotatingAtkAmmo = 2
var rotatingAtkBaseAmmo = 2

var rotatingAtk_level : int = 1
const spawn_point_count : int=2
const radius : int= 150
const rotate_speed = 3
const shoot_timer_wait_time = 1



func _process(delta):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)

func attack() -> void:
	var bulletlvl = bullet_level
	if bulletlvl >= 1:
		bulletTimer.wait_time =bullet_attack_speed
		if bulletTimer.is_stopped():
			bulletTimer.start()
	if meteorite_level >= 1:
		meteorTimer.wait_time = meteorite_base_attack_speed
		if meteorTimer.is_stopped():
			meteorTimer.start()
	
	if rotatingAtk_level >=1:
		rotatingTimer.wait_time = shoot_timer_wait_time
		if rotatingTimer.is_stopped():
			rotatingTimer.start()
	
	if rotatingAtk_level >=1:
		var step = 2 * PI / spawn_point_count
		for i in range(spawn_point_count):
			var spawn_point = Node2D.new()
			var pos = Vector2(radius, 0).rotated(step * i+1)
			spawn_point.global_position = pos
			spawn_point.rotation = pos.angle()
			rotater.add_child(spawn_point)
			
		shoot_timer.wait_time = shoot_timer_wait_time
		shoot_timer.start()


func _on_bullet_timer_timeout() -> void:
	bullet_ammo += bullet_base_ammo 
	bulletAtkTimer.start()

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
func get_random_target() ->Vector2:
	if player.enemy_closed.size() > 0:
		return player.enemy_closed.pick_random().global_position
	else:
		return Vector2.UP

func get_random_position() -> Vector2:
	var vpr = get_viewport_rect().size *randf_range(1.1,1.2)
	var top_left = Vector2(player.global_position.x - vpr.x/2,player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2,player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2,player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2,player.global_position.y + vpr.y/2)
	
	var pos_side = ["up", "down" , "right","left"].pick_random()
	var spwan_pos1 = Vector2.ZERO
	var spwan_pos2 = Vector2.ZERO
	match pos_side:
		"up":
			spwan_pos1 = top_left
			spwan_pos2 = top_right
		"down":
			spwan_pos1 = bottom_left
			spwan_pos2 = bottom_right
		"right":
			spwan_pos1=top_right
			spwan_pos2 = bottom_right
		"left":
			spwan_pos1=top_left
			spwan_pos2 = bottom_left
	var x_spwan = randf_range(spwan_pos1.x,spwan_pos2.x)
	var y_spwan = randf_range(spwan_pos1.y,spwan_pos2.y)
	return Vector2(x_spwan,y_spwan)


func _on_bullet_atk_timer_timeout()->void:
	if bullet_ammo > 0:
		var bullet_shoot = bullet.instantiate()
		
		bullet_shoot.set_collision_mask_value(2,true)
		bullet_shoot.set_collision_layer_value(3,true)
		bullet_shoot.set_collision_mask_value(1,false)
		bullet_shoot.set_collision_layer_value(1,false)
		bullet_shoot.set_collision_mask_value(3,false)
		bullet_shoot.set_collision_layer_value(2,false)
		
		bullet_shoot.position = player.position
		bullet_shoot.target = get_target()
		get_parent().add_sibling(bullet_shoot)
		bullet_ammo -=1
		if(bullet_ammo>0):
			bulletAtkTimer.start()
		else:
			bulletAtkTimer.stop()
		

func _on_meteor_atk_timer_timeout()->void:
	if meteorite_count > 0:
		var drop_meteor = meteor.instantiate()
		drop_meteor.position = player.position
		drop_meteor.target = get_random_position()
		get_parent().add_sibling(drop_meteor)
		meteorite_count-=1
		if(meteorite_count>0):
			meteorAtkTimer.start()
		else:
			meteorAtkTimer.stop()


func _on_meteor_timer_timeout()->void:
	meteorite_count += meteorite_base_count
	meteorAtkTimer.start()


func _on_shoot_timer_timeout():
	for s in rotater.get_children():
		var rotating = rotatingBullet.instantiate()
		rotating.initial_angle_offset = s.rotation
		get_parent().get_tree().root.add_child(rotating)
		rotating.global_position = s.global_position
		rotating.rotation = s.global_rotation


func _on_rotating_timer_timeout():
	rotatingAtkAmmo += rotatingAtkBaseAmmo
	rotatingAtkTimer.start()


func _on_rotating_atk_timer_timeout():
	
	if rotatingAtkAmmo>1000:
		for i in range(rotatingAtkAmmo):  
			var step =  (2*PI) / rotatingAtkAmmo
			var pos = Vector2(radius,0).rotated(step*(i+1))
			var rotateShoot =  rotatingBullet.instantiate()
			rotateShoot.position =player.global_position + pos
			rotateShoot.initial_angle_offset = pos
			print(i,"starting pos->", pos )
			rotateShoot.global_rotation = pos.angle()
			get_parent().add_sibling(rotateShoot)
			#rotatingAtkAmmo-=1
		rotatingAtkAmmo=0
		rotatingAtkTimer.stop()
	
	#var step =PI * 2 / rotatingAtkAmmo
		#for i in range(rotatingAtkAmmo):  
			# Create multiple rotating objects
			#var rotateShoot = rotatingBullet.instantiate()
			#rotateShoot.position =player.global_position
			#rotateShoot.rotation = Vector2(radius, 0).rotated(step * i).angle()
			# Set a unique angle offset for each rotating object
			#
			#get_parent().add_sibling(rotateShoot)
		#
		#rotatingAtkAmmo = 0  # Reset ammo after firing all bullets
		#rotatingAtkTimer.stop()
