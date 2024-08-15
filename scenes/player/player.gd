extends CharacterBody2D

@export var SPEED:int = 150
@export var Hp:int = 100
@export var Damage :int= 2

@onready var hitBox = $HitBox
#@onready var bullet = "res://scenes/Attack/bullet.tscn"
@onready var atk = %Attack
var enemy_closed=[]

#var vpr = get_viewport_rect().size 

#gui layer
@onready var lblTimer = $GuiLayer/gui/lblTImer
var time =0

func _ready():
	hitBox.damage = 0
	atk.attack()


func _physics_process(delta):
	get_input()
	move_and_slide()


func get_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * SPEED


func _on_hurt_box_hurt(damage) ->void:
	Hp -= damage
	print(Hp)

func _on_enemy_detection_area_body_entered(body)->void:
	if not enemy_closed.has(body):
		enemy_closed.append(body)
		


func _on_enemy_detection_area_body_exited(body)->void:
	if enemy_closed.has(body):
		enemy_closed.erase(body)


func change_time(argtime =0)->void:
	time = argtime
	var get_m = int(time/60.0)
	var get_s = int(time%60)
	if get_m < 10 :
		get_m = str(0,get_m)
	if get_s < 10:
		get_s = str(0,get_s)
	lblTimer.text = str(get_m,":",get_s)
