extends Node2D

@onready var tileMap = $TileMap
const Map_size = Vector2(128,128)
const LAND_CAP = 0.3
func _ready():
	generateWorld()
	

func generateWorld():
	var noise = FastNoiseLite.new()
	noise.seed = 1 #randi()
	
	var cells : Array = []
	for x in range(-Map_size.x/2,Map_size.x/2):
		for y in range(-Map_size.y/2,Map_size.y/2):
			var a = noise.get_noise_2d(x,y)
			if a<LAND_CAP:
				cells.append(Vector2(x,y))
			else:
				tileMap.set_cell(0,Vector2(x,y),1,Vector2(0,0),0)
	tileMap.set_cells_terrain_connect(0,cells,0,0,true)
