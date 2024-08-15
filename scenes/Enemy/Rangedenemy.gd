extends CharacterBody2D

@export var Speed : int= 90
@export var Hp :int= 10
@export var Damage :int = 5
@export var AtkRange :int = 100

@onready  var bullet = preload("res://scenes/Attack/enemyBullet.tscn")
@onready var player := get_tree().get_first_node_in_group("player")
@onready var hitBox = $HitBox

#bullet
var bullet_level:int = 1
var bullet_ammo:int = 3
var bullet_base_ammo:int =3
var bullet_attack_speed:float =1.0
var target:Vector2 = Vector2.ZERO
var angle :Vector2= Vector2.ZERO
@onready var bulletTimer = get_node("%BulletTimer")
@onready var bulletAtkTimer = get_node("%BulletAtkTimer")


func _ready():
	hitBox.damage = Damage
	
	

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	if(abs(position.x - player.global_position.x) > AtkRange && abs(position.y - player.global_position.y) > AtkRange):
		velocity = direction * Speed
		move_and_slide()
	else:
		attack()


func _on_hurt_box_hurt(damage)->void:
	Hp -= damage
	if(Hp<=0):
		Death()
	#print("Enemy hp" , Hp)

func Death()->void:
	queue_free()


func _on_visible_on_screen_enabler_2d_screen_entered():
	visible = true

func _on_visible_on_screen_enabler_2d_screen_exited():
	visible = false

func attack():
	if bullet_level >= 1:
		bulletTimer.wait_time =bullet_attack_speed
		if bulletTimer.is_stopped():
			bulletTimer.start()


func _on_bullet_timer_timeout():
	bullet_ammo += bullet_base_ammo
	bulletAtkTimer.start()

func _on_bullet_atk_timer_timeout():
	if bullet_ammo > 0:
		var bullet_shoot = bullet.instantiate()
		#bullet_shoot.set_collision_mask_value(3,true)
		#bullet_shoot.set_collision_layer_value(2,true)
		#bullet_shoot.set_collision_mask_value(1,false)
		#bullet_shoot.set_collision_layer_value(1,false)
		#bullet_shoot.set_collision_mask_value(2,false)
		#bullet_shoot.set_collision_layer_value(3,false)
		bullet_shoot.position = self.position
		bullet_shoot.target = player.position
		get_parent().add_sibling(bullet_shoot)
		bullet_ammo -=1
		if(bullet_ammo>0):
			bulletAtkTimer.start()
		else:
			bulletAtkTimer.stop()
