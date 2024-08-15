extends CharacterBody2D

@export var Speed : int= 90
@export var Hp :int= 10
@export var Damage :int = 5

@onready var player := get_tree().get_first_node_in_group("player")
@onready var hitBox = $HitBox

func _ready():
	hitBox.damage = Damage
	

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * Speed
	move_and_slide()


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
