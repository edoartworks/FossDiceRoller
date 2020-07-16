extends Spatial

export (PackedScene) var die_node = preload("res://Dice/D6.tscn")
export (int, 1, 10) var dice_spawn_count := 1
export var dice_spawn_spacing = 5

var die
var spawned_dice = []
var dice_reset_position = []
var dice_thrown := false
var dice_spawn_position : Vector3


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	dice_spawn_position = $DiceSpawnLoc.get_translation()
	# spawn dice
	for i in dice_spawn_count:
		die = die_node.instance()
		spawned_dice.append(die)
		add_child(die)

	# move dice to spawn location
	for die_inst in spawned_dice:
		die_inst.set_translation(dice_spawn_position)
		dice_reset_position.append(dice_spawn_position) # store to use later when resetting dice
		# offset spawn position when spawning multiple dice
		if dice_spawn_count > 1:
			#TODO: generate new spawn pos if is overlapping existing dice+++
			dice_spawn_position += Vector3(rand_range(-dice_spawn_spacing, dice_spawn_spacing), 0, 0)


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
					die_inst.reset_dice(dice_reset_position[i])
					i += 1
					dice_thrown = false

	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


