extends Area2D

var damage:int = 1
@onready var collision = $CollisionShape2D
@onready var time = $Timer

func tempDisable()->void:
	collision.call_deferred("set","disabled",true)
	time.start()
	


func _on_timer_timeout()->void:
	collision.call_deferred("set","disabled",false)
	
