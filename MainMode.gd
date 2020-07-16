extends Spatial

export (PackedScene) var die_node = preload("res://Dice/D6.tscn")
export (int, 1, 10) var dice_spawn_count := 1
export var dice_spawn_spacing = 5
export var dice_overlap_check_distance = 4.2

var die
var spawned_dice = []
var dice_positions_list = []
var dice_thrown := false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# spawn dice instances
	for i in dice_spawn_count:
		die = die_node.instance()
		spawned_dice.append(die)
		add_child(die)
	
	move_dice_to_spawn_pos()


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if not dice_thrown:
				for die_inst in spawned_dice:
					die_inst.throw_dice()
					dice_thrown = true
			else:
				var i = 0
				for die_inst in spawned_dice:
					die_inst.reset_dice(dice_positions_list[i])
					i += 1
					dice_thrown = false

	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func move_dice_to_spawn_pos():
	var die_spawn_position = $DiceSpawnPos.get_translation()
	var die_count = 0 # count nr of spawned dice
	var is_not_overlapping = false
	
	# move dice to spawn location
	for die_inst in spawned_dice:
		die_count += 1
		die_inst.set_translation(die_spawn_position)
		dice_positions_list.append(die_spawn_position) # store to use later when resetting dice
		
		# offset spawn position when spawning multiple dice to prevent overlapping
#		if dice_spawn_count > 1:
#
#			var offset = Vector3(rand_range(-dice_spawn_spacing, dice_spawn_spacing), 0, 0)
#			var new_pos = die_spawn_position + offset
#			var distance_to_prev = (new_pos - die_spawn_position).length()
#
#			# if overlapping, generate new offset value
#			for prev_pos in dice_positions_list:
#
#
#
#			while distance_to_prev < dice_overlap_check_distance:
#
#			die_spawn_position += offset
