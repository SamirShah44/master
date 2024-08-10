extends Area2D


@export var damage:int = 1
var hp:int = 1
var speed = 150

var ammo:int = 10
var base_ammo =10
var attack_speed =1.0
var level = 1

var target:Vector2 = Vector2.ZERO
var angle :Vector2= Vector2.ZERO


@onready var hitBox= $HitBox
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	hitBox.damage = damage
	angle = global_position.direction_to(target)
	rotation = angle.angle()+ deg_to_rad(0)
	var tween = create_tween()
	tween.tween_property(self,"rotation",rotation + deg_to_rad(90),1.0)
	tween.tween_property(self,"rotation",rotation + deg_to_rad(180),1.0)
	tween.tween_property(self,"rotation",rotation + deg_to_rad(90*3),1.0)
	tween.tween_property(self,"rotation",rotation + deg_to_rad(90),1.0)	
	tween.play()
	
func _physics_process(delta):
	position += angle * speed*delta


func _on_timer_timeout():
	queue_free()
