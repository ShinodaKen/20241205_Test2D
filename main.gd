extends Node2D

@export var player_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = player_scene.instantiate()
	add_child(player)
	player.spawn(Vector2(200, get_viewport_rect().size.y - 100))
	var map_block_root = get_node("MapBlocks")
	var map_blocks = map_block_root.get_children()
	player.set_map_blocks(map_blocks)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
