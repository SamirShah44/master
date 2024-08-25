extends Node2D

const speed = 2
var d =0
var radius = 200
var initial_angle_offset = 0  # This will be different for each rotating object
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	print(initial_angle_offset)
func _physics_process(delta):
	d+=delta
	position = Vector2(
		sin(d*speed*initial_angle_offset) * radius,
		cos(d*speed*initial_angle_offset) * radius
	) + player.position
	 #- Vector2(radius+50,radius+50)
	#position += speed * delta * transform.x



func _on_timer_timeout():
	queue_free()
