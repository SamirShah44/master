extends Sprite2D

var noise = FastNoiseLite.new()

var width = 8
var height = 8
@onready var player = get_tree().get_first_node_in_group("player")

func ready():
	noise.seed = randi()
	noise.frequency = 0.5

func _process(delta: float) -> void:
	var player_tile_pos = player.position
	

func get_noise(x,y):
	var noise_pos = noise.get_noise_2d(player.x - width /2 + x,player.y - height/2 + y) * 10
	return noise_pos
