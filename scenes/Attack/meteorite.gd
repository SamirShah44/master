extends Area2D

@export var damage:int = 10
var hp:int = 1
var speed :int= 1

var target:Vector2 = Vector2.ZERO
var angle :Vector2= Vector2.ZERO

@onready var hitBox= $HitBox
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	hitBox.damage = damage
	#angle = global_position.direction_to(target)
	#rotation = angle.angle()
	########
	set_physics_process(false)
	set_destination(target)
	#############
	
	var tween = create_tween()
	tween.parallel()
	tween.tween_property(self,"scale",scale + Vector2(0.25,0.25),0.4)
	tween.tween_property(self,"scale",scale + Vector2(0.25,0.25),0.2)
	tween.tween_property(self,"scale",scale + Vector2(0.25,0.25),0.5)
	#tween.tween_property(self,"rotation",rotation + deg_to_rad(90),0.2)
	tween.tween_property(self,"scale",scale + Vector2(0.5,0.5),0.2)
	
	tween.play()

func _physics_process(delta):
	if(hp<1):
		queue_free()
	if t<=1:
		t += speed * delta 
	position = position.bezier_interpolate(p0,p1,p2,t) 
	if(absf(position.x - target.x) <= 1 && absf(position.y - target.y) <= 1):
		queue_free()
		print("target destroyed")
		



func _on_timer_timeout()->void:
	queue_free()



#########################################
#For beizer curve
#FOr bezier curve 
@export var deviation_distance :float = 1.0
@export var deviation_angle:float = 60

var p0 :Vector2
var p1 :Vector2    #3 points for curve
var p2 :Vector2

var t:float = 0.0  #denotes progression of curve   
#0 -> initial and 1->final position

func _quadratic_curve()->Vector2:
	var q0 :Vector2 = p0.lerp(p1,t)
	var q1:Vector2 = p1.lerp(p2,t)
	return q0.lerp(q1,t)

func set_destination(destination):
	p0 = player.global_position
	p2 = destination
	var tilted_unit_vector = (p2-p0).normalized().rotated(deg_to_rad(-deviation_angle))
	p1 = p0 + deviation_distance * tilted_unit_vector
	
	call_deferred("set_physics_process",true)
########################################


func _on_visible_on_screen_enabler_2d_screen_exited():
	visible = false

