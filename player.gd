extends Area2D

@export var g = 3000
@export var air_resistance_factor = 0.4
@export var mass = 0.05
@export var input_force = 150.0
@export var jump_velocity = -1200

var velocity = Vector2.ZERO
var map_blocks = null

func spawn(pos) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false

func set_map_blocks(blocks) -> void:
	map_blocks = blocks


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	$CollisionShape2D.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_f = 0
	if Input.is_action_pressed("move_right"):
		input_f += input_force
	if Input.is_action_pressed("move_left"):
		input_f -= input_force

	var total_f = input_f - (air_resistance_factor * velocity.x)
	var accelerate = total_f / mass
	velocity.x += accelerate * delta
	
	if Input.is_action_pressed("jump"):
		if velocity.y == 0:
			velocity.y += jump_velocity

	velocity.y += g * delta

	position += velocity * delta

	for block in map_blocks:
		var block_collision = block.find_child("Collision*")
		var block_rect = block_collision.shape.get_rect()
		block_rect.position += block.global_position

		var my_collision = find_child("Collision*")
		var my_area_rect = my_collision.shape.get_rect()
		my_area_rect.position += my_collision.global_position

		if (block_rect.position.x < my_area_rect.end.x) and (block_rect.end.x > my_area_rect.position.x):
			if velocity.y > 0:
				if my_area_rect.end.y > block_rect.position.y:
					position.y = block_rect.position.y
					velocity.y = 0

#func _on_area_entered(area: Area2D) -> void:
	#pass
