extends ColorRect


@onready var lblName = $lbl_name
@onready var lbl_description = $lbl_description
@onready var lbl_level = $lbl_level
@onready var itemIcon  = $ColorRect/itemIcon


var mouse_over=false
var item = null
@onready var player = get_tree().get_first_node_in_group("player")
@onready var button: TextureButton = $button
signal selected_upgrade(upgrade)

func _ready():
	assert(selected_upgrade.connect(player.upgrade_character) == OK)
	assert(button.pressed.connect(click) == OK)
	if item == null:
		item= "food"
	lblName.text = UpgradeDb.UPGRADES[item]["displayname"]
	lbl_description.text = UpgradeDb.UPGRADES[item]["details"]
	lbl_level.text = UpgradeDb.UPGRADES[item]["level"]
	itemIcon.texture=load(UpgradeDb.UPGRADES[item]["icon"])
	itemIcon.set_scale(Vector2(0.4,0.4))
	

func click() -> void:
	selected_upgrade.emit(item)

